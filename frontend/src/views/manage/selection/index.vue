<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <!-- 新增：课程名称搜索 -->
      <el-form-item label="课程名称" prop="courseName">
        <el-input
            v-model="queryParams.courseName"
            placeholder="请输入课程名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>

      <!-- 新增：学生名称搜索 -->
      <el-form-item label="学生名称" prop="studentName">
        <el-input
            v-model="queryParams.studentName"
            placeholder="请输入学生名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <!-- 保留：选课状态筛选（可选） -->
      <el-form-item label="选课状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择选课状态" clearable style="width: 150px">
          <el-option label="已选" value="0"/>
          <el-option label="已退" value="1"/>
        </el-select>
      </el-form-item>
      <el-form-item label="选课时间" prop="selectTime">
        <el-date-picker clearable
          v-model="queryParams.selectTime"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择选课时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['manage:selection:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['manage:selection:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['manage:selection:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['manage:selection:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="selectionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <!-- 替换：课程名称（原课程ID列删除） -->
      <el-table-column label="课程名称" align="center" prop="courseName" />
      <!-- 替换：学生名称（原学生ID列删除） -->
      <el-table-column label="学生名称" align="center" prop="studentName" />
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <!-- 0显示“已选”，1显示“已退”，其他显示“未知” -->
          <span v-if="scope.row.status === 0" class="text-success">已选</span>
          <span v-else-if="scope.row.status === 1" class="text-warning">已退</span>
          <span v-else>未知状态</span>
        </template>
      </el-table-column>
      <el-table-column label="选课时间" align="center" prop="selectTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.selectTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['manage:selection:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['manage:selection:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改学生选课对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="selectionRef" :model="form" :rules="rules" label-width="80px">
        <!-- 新“课程名称”下拉选择框 -->
        <el-form-item label="课程名称" prop="courseId">
          <el-select
              v-model="form.courseId"
              placeholder="请选择课程"
              clearable
              style="width: 100%"
          >
            <el-option
                v-for="course in courseList"
                :key="course.id"
                :label="course.courseName"
                :value="course.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <!-- 新“学生名称”下拉选择框 -->
        <el-form-item label="学生名称" prop="studentId">
          <el-select
              v-model="form.studentId"
              placeholder="请选择学生"
              clearable
              style="width: 100%"
          >
            <el-option
                v-for="student in studentList"
                :key="student.id"
                :label="student.studentName"
                :value="student.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="选课状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">已选</el-radio> <!-- value=0，显示“已选” -->
            <el-radio label="1">已退</el-radio> <!-- value=1，显示“已退” -->
          </el-radio-group>
        </el-form-item>
        <el-form-item label="选课时间" prop="selectTime">
          <el-date-picker clearable
            v-model="form.selectTime"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择选课时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Selection">
import { listSelection, getSelection, delSelection, addSelection, updateSelection } from "@/api/manage/selection"
import { listStudent } from "@/api/manage/student"
import { listCourse } from "@/api/manage/course"
import { ref, onMounted, reactive, toRefs, getCurrentInstance } from "vue"

const { proxy } = getCurrentInstance()
// 新增：存储学生列表（用于下拉选择）
const studentList = ref([])
// 新增：存储课程列表（用于下拉选择）
const courseList = ref([])

// 原有变量（selectionList、open等）保持不变...
const selectionList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    courseName: null,  // 新增：课程名称搜索参数
    studentName: null,  // 新增：学生名称搜索参数
    status: null,
    selectTime: null
  },
  rules: {
    courseId: [
      { required: true, message: "课程ID不能为空", trigger: "blur" }
    ],
    studentId: [
      { required: true, message: "学生ID不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "选课状态不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

// 新增：加载学生列表
function loadStudentList() {
  listStudent().then(response => {
    // 接口返回格式为{rows: [...], total: ...}，取rows数据
    studentList.value = response.rows
  }).catch(error => {
    console.error("获取学生列表失败：", error)
  })
}

// 新增：加载课程列表
function loadCourseList() {
  listCourse().then(response => {
    courseList.value = response.rows
  }).catch(error => {
    console.error("获取课程列表失败：", error)
  })
}

// 新增：页面挂载时加载数据（替换原单独的getList()）
onMounted(() => {
  loadStudentList()   // 加载学生列表
  loadCourseList()    // 加载课程列表
  getList()           // 加载选课列表
})

/** 查询学生选课列表 */
function getList() {
  loading.value = true
  listSelection(queryParams.value).then(response => {
    selectionList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    courseId: null,
    studentId: null,
    status: null,
    selectTime: null
  }
  proxy.resetForm("selectionRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加学生选课"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getSelection(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改学生选课"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["selectionRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateSelection(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
// 新增选课：核心修改！动态显示后端返回的提示
        addSelection(form.value).then(response => {
          // 直接显示后端返回的msg（可能是“选课成功”“重复选课”“超员选课”）
          proxy.$modal.msgSuccess(response.msg)
          open.value = false
          getList()
        }).catch(error => {
          // 非重复/超员的异常（如课程不存在、参数错误），显示后端错误提示
          proxy.$modal.msgError(error.response?.data?.msg || "选课失败，请重试")
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value
  proxy.$modal.confirm('是否确认删除学生选课编号为"' + _ids + '"的数据项？').then(function() {
    return delSelection(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('manage/selection/export', {
    ...queryParams.value
  }, `selection_${new Date().getTime()}.xlsx`)
}

getList()
</script>
