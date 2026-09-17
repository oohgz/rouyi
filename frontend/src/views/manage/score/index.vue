<template>
  <div class="app-container">
    <!-- 成绩分布图表：仅教师/管理员可见 -->
    <div v-if="showChart && hasTeacherOrAdminPermi" class="chart-container" style="height: 300px; margin-bottom: 20px;"></div>

    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <!-- 搜索框保留 -->
      <el-form-item label="课程名称" prop="courseName">
        <el-input
            v-model="queryParams.courseName"
            placeholder="请输入课程名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学生名称" prop="studentName">
        <el-input
            v-model="queryParams.studentName"
            placeholder="请输入学生名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="成绩" prop="score">
        <el-input
            v-model="queryParams.score"
            placeholder="请输入成绩"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <!-- 新增/修改/删除/导出按钮：仅教师/管理员可见 -->
      <el-col :span="1.5" v-if="hasTeacherOrAdminPermi">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
            v-hasPermi="['manage:score:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5" v-if="hasTeacherOrAdminPermi">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['manage:score:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5" v-if="hasTeacherOrAdminPermi">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['manage:score:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5" v-if="hasTeacherOrAdminPermi">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
            v-hasPermi="['manage:score:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="scoreList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="课程名称" align="center" prop="courseName" />
      <el-table-column label="学生名称" align="center" prop="studentName" />
      <el-table-column label="成绩" align="center" prop="score" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <!-- 操作按钮：仅教师/管理员可见 -->
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['manage:score:edit']" v-if="hasTeacherOrAdminPermi">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['manage:score:remove']" v-if="hasTeacherOrAdminPermi">删除</el-button>
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

    <!-- 对话框确定按钮：仅教师/管理员可见 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="scoreRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="课程名称" prop="courseId">
          <el-select
              v-model="form.courseId"
              placeholder="请选择课程"
              clearable
              style="width: 100%"
              @change="handleCourseChange"
          >
          <el-option
              v-for="course in courseList"
              :key="course.id"
              :label="course.courseName"
              :value="course.id"
          ></el-option>
          </el-select>
        </el-form-item>
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
        <el-form-item label="成绩" prop="score">
          <el-input v-model="form.score" placeholder="请输入成绩" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm" v-if="hasTeacherOrAdminPermi">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Score">
// 移除 Vuex 导入，换成 Pinia 的 user store
import { listScore, getScore, delScore, addScore, updateScore, getScoreDistribution } from "@/api/manage/score"
import { listStudent, listStudentByCourse } from "@/api/manage/student"
import { ref, onMounted, reactive, toRefs, getCurrentInstance, computed } from "vue"
import * as echarts from 'echarts'
// 🔥 关键：导入 Pinia 的用户状态管理（框架默认路径）
import { useUserStore } from '@/store/modules/user'
import { listCourse, listCourseByTeacher } from "@/api/manage/course"

// 🔥 替换 Vuex 的 store，用 Pinia 的 userStore
const userStore = useUserStore()
// 角色判断：用 Pinia 的 userStore.roles 替代 Vuex 的 store.state.user.roles
const hasTeacherOrAdminPermi = computed(() => {
  const roles = userStore.roles || [] // Pinia 直接取属性，无需 state
  return roles.includes('teacher') || roles.includes('admin') || roles.includes('manage')
})

const { proxy } = getCurrentInstance()

const showChart = ref(false)
const studentList = ref([])
const courseList = ref([])
const scoreList = ref([])
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
    courseName: null,
    studentName: null,
    score: null,
  },
  rules: {
    courseId: [
      { required: true, message: "课程不能为空", trigger: "blur" }
    ],
    studentId: [
      { required: true, message: "学生不能为空", trigger: "blur" }
    ],
    score: [
      { required: true, message: "成绩不能为空", trigger: "blur" },
      { pattern: /^\d+(\.\d+)?$/,  message: "成绩必须为数字", trigger: "blur" }
    ],
    remark: [
      { trigger: "blur" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

// 新增：课程变化时，查询该课程的选课学生
function handleCourseChange(courseId) {
  // 1. 未选择课程时，清空学生列表
  if (!courseId) {
    studentList.value = [];
    return;
  }

  // 2. 调用后端接口，查询选了该课程的学生
  listStudentByCourse(courseId).then(response => {
    if (response.code === 200) {
      studentList.value = response.data || [];
      // 3. 无学生选该课程时，提示教师
      if (studentList.value.length === 0) {
        proxy.$modal.msgInfo("该课程暂无学生选课，无法添加成绩");
      }
    } else {
      studentList.value = [];
      proxy.$modal.msgError(response.msg || "查询学生失败");
    }
  }).catch(error => {
    studentList.value = [];
    console.error("查询选课学生失败：", error);
    proxy.$modal.msgError("查询学生失败，请重试");
  });
}

function getList() {
  loading.value = true
  listScore(queryParams.value).then(response => {
    loading.value = false
    if (response && response.code === 200) {
      scoreList.value = response.rows || [] // 直接取response.rows
      total.value = response.total || 0
      console.log("成绩列表：", scoreList.value) // 有数据就会显示
    } else {
      scoreList.value = []
      total.value = 0
    }
  }).catch(error => {
    loading.value = false
    scoreList.value = []
    total.value = 0
    console.error("获取成绩列表失败：", error)
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    id: null,
    courseId: null,
    studentId: null,
    score: null,
    remark: null
  };
  studentList.value = [];
  proxy.resetForm("scoreRef");
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加学生成绩"
}

function handleUpdate(row) {
  reset()
  const _id = row?.id || ids.value[0] // 修复：避免数组直接赋值
  getScore(_id).then(response => {
    form.value = response.data // RuoYi 接口返回格式是 response.data
    open.value = true
    title.value = "修改学生成绩"
  }).catch(error => {
    console.error("获取成绩详情失败：", error)
  })
}

/** 提交按钮（修改后） */
function submitForm() {
  proxy.$refs.scoreRef.validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        // 修改成绩逻辑（保持不变）
        updateScore(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        }).catch(error => {
          console.error("修改成绩失败：", error)
        })
      } else {
        // 新增成绩：根据后端响应 code 动态显示提示颜色
        addScore(form.value).then(response => {
          if (response.code === 200) {
            // 正常新增（code=200）：绿色提示
            proxy.$modal.msgSuccess(response.msg);
          } else {
            // 重复添加（code≠200，后端返回 error）：红色提示
            proxy.$modal.msgError(response.msg);
          }
          open.value = false;
          getList();
        }).catch(error => {
          // 网络错误等异常：红色提示
          proxy.$modal.msgError(error.response?.data?.msg || "新增成绩失败");
        })
      }
    }
  });
}

function handleDelete(row) {
  const _ids = row?.id || ids.value.join(',') // 修复：批量删除用逗号拼接
  proxy.$modal.confirm('是否确认删除学生成绩编号为"' + _ids + '"的数据项？').then(function() {
    return delScore(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function handleExport() {
  proxy.download('manage/score/export', {
    ...queryParams.value
  }, `score_${new Date().getTime()}.xlsx`)
}

function loadCourseList() {
  // 判断当前角色：教师调用新接口，管理员调用原接口
  const roles = userStore.roles || [];
  const isTeacher = roles.includes('teacher');
  const isAdmin = roles.includes('admin') || roles.includes('manage');

  // 教师角色：加载自己的课程
  if (isTeacher) {
    listCourseByTeacher().then(response => {
      if (response.code === 200) {
        courseList.value = response.data || [];
        console.log("教师的课程列表：", courseList.value);
      } else {
        courseList.value = [];
      }
    }).catch(error => {
      courseList.value = [];
      console.error("获取教师课程失败：", error);
    });
  }
  // 管理员角色：加载所有课程（保留原逻辑）
  else if (isAdmin) {
    listCourse().then(response => {
      if (response && response.code === 200) {
        courseList.value = response.rows || [];
        console.log("管理员的课程列表：", courseList.value);
      } else {
        courseList.value = [];
      }
    }).catch(error => {
      courseList.value = [];
      console.error("获取所有课程失败：", error);
    });
  }
  // 其他角色（如学生）：无需加载课程（但前端按钮已通过权限隐藏）
  else {
    courseList.value = [];
  }
}

const initChart = (statData) => {
  const dom = document.querySelector('.chart-container')
  if (!dom) return // 避免图表容器未渲染时报错
  const myChart = echarts.init(dom)
  const option = {
    title: { text: '成绩分布统计', left: 'center' },
    tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: { type: 'category', data: Object.keys(statData) },
    yAxis: { type: 'value', name: '人数' },
    series: [{
      name: '学生人数',
      type: 'bar',
      data: Object.values(statData),
      itemStyle: { color: '#409EFF' }
    }]
  }
  myChart.setOption(option)
  window.addEventListener('resize', () => myChart.resize())
}

// 🔥 修改：用 Pinia 的 userStore 替代 Vuex 的 store
const loadChartData = async () => {
  const roles = userStore.roles || []
  console.log("账号角色：", roles)
  const isMatch = roles.some(role => {
    const lowerRole = role.toLowerCase().replace('role_', '')
    return lowerRole === 'manage' || lowerRole === 'teacher'|| lowerRole === 'admin'
  })

  if (isMatch) {
    showChart.value = true
    try {
      const res = await getScoreDistribution()
      console.log("图表接口返回：", res) // 打印接口返回的完整数据
      const chartData = res.data || res // 兼容是否嵌套data
      initChart(chartData)
    } catch (error) {
      // 🔥 打印详细错误：状态码、错误信息、响应数据
      console.error("获取成绩分布失败-详细信息：", {
        message: error.message,
        status: error.response?.status, // 接口状态码（404/500等）
        response: error.response?.data // 接口返回的错误信息
      })
    }
  } else {
    showChart.value = false
  }
}

onMounted(() => {
  loadCourseList()
  getList()
  loadChartData()
})
</script>