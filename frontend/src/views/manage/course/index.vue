<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="课程编码" prop="courseCode">
        <el-input
          v-model="queryParams.courseCode"
          placeholder="请输入课程编码"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="课程名称" prop="courseName">
        <el-input
          v-model="queryParams.courseName"
          placeholder="请输入课程名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="授课教师" prop="teacherName">
        <el-input
            v-model="queryParams.teacherName"
            placeholder="请输入授课教师名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable  style="width: 150px" >
          <el-option
            v-for="dict in sys_normal_disable"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5" v-if="hasOperatePermi">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['manage:course:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5" v-if="hasOperatePermi">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['manage:course:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5" v-if="hasOperatePermi">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['manage:course:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5" v-if="hasOperatePermi">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['manage:course:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="courseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />

      <el-table-column label="课程编码" align="center" prop="courseCode" />
      <el-table-column label="课程名称" align="center" prop="courseName" />
      <el-table-column label="授课教师" align="center" prop="teacherName" />
      <el-table-column label="最大选课人数" align="center" prop="maxStudents" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <dict-tag :options="sys_normal_disable" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['manage:course:edit']"  v-if="hasOperatePermi">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['manage:course:remove' ]" v-if="hasOperatePermi">删除</el-button>
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

    <!-- 添加或修改课程信息对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="courseRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="课程编码" prop="courseCode">
          <el-input v-model="form.courseCode" placeholder="请输入课程编码" />
        </el-form-item>
        <el-form-item label="课程名称" prop="courseName">
          <el-input v-model="form.courseName" placeholder="请输入课程名称" />
        </el-form-item>
        <el-form-item label="授课教师" prop="teacherId">
          <el-select v-model="form.teacherId" placeholder="请选择授课教师">
            <el-option
                v-for="teacher in teacherList"
                :key="teacher.id"
                :label="teacher.teacherName"
                :value="teacher.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="最大选课人数" prop="maxStudents">
          <el-input v-model="form.maxStudents" placeholder="请输入最大选课人数" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in sys_normal_disable"
              :key="dict.value"
              :label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
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

<script setup name="Course">
import { listCourse, getCourse, delCourse, addCourse, updateCourse } from "@/api/manage/course"
import { listTeacher } from "@/api/manage/teacher"; // 导入教师列表接口
import { ref, onMounted, reactive, toRefs, getCurrentInstance } from "vue"; // 确保导入ref和onMounted
// 新增：导入Pinia用户状态，判断角色
import { useUserStore } from '@/store/modules/user';
import { computed } from 'vue';

const userStore = useUserStore();
// 仅教师、管理员、manage角色可操作（学生不可见操作按钮）
const hasOperatePermi = computed(() => {
  const roles = userStore.roles || [];
  return roles.includes('teacher') || roles.includes('admin') || roles.includes('manage');
});

const { proxy } = getCurrentInstance()
const { sys_normal_disable } = proxy.useDict('sys_normal_disable')
const teacherList = ref([]); // 新增：存储教师数据的数组

const courseList = ref([])
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
    courseCode: null,
    courseName: null,
    teacherName: null,
    maxStudents: null,
    status: null
  },
  rules: {
    courseCode: [
      { required: true, message: "课程编码不能为空", trigger: "blur" }
    ],
    courseName: [
      { required: true, message: "课程名称不能为空", trigger: "blur" }
    ],
    teacherId: [
      { required: true, message: "授课教师ID不能为空", trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询课程信息列表 */
function getList() {
  loading.value = true
  listCourse(queryParams.value).then(response => {
    courseList.value = response.rows
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
    courseCode: null,
    courseName: null,
    teacherId: null,
    maxStudents: null,
    status: null
  }
  proxy.resetForm("courseRef")
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
  title.value = "添加课程信息"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getCourse(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改课程信息"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["courseRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateCourse(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addCourse(form.value).then(response => {
          proxy.$modal.msgSuccess(response.msg) // 直接使用后端返回的提示
          open.value = false
          getList()
        }).catch(error => {
          // 仅处理非编码重复的异常（如参数错误、网络问题）
          proxy.$modal.msgError(error.response?.data?.msg || "新增课程失败，请重试")
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value
  proxy.$modal.confirm('是否确认删除课程信息编号为"' + _ids + '"的数据项？').then(function() {
    return delCourse(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('manage/course/export', {
    ...queryParams.value
  }, `course_${new Date().getTime()}.xlsx`)
}

function loadTeacherList() {
  // 调用教师列表接口（无需参数，查询所有教师）
  listTeacher().then(response => {
    // 假设接口返回格式为 { code: 200, rows: [教师对象数组] }
    teacherList.value = response.rows; // 将接口返回的教师数据赋值给teacherList
    console.log("教师列表数据：", teacherList.value); // 调试用，可删除
  }).catch(error => {
    console.error("获取教师列表失败：", error);
  });
}

// 组件挂载时加载教师列表（确保打开对话框前数据已加载）
onMounted(() => {
  if (hasOperatePermi.value) {
    loadTeacherList();
  } // 新增：调用加载方法
});

getList()
</script>
