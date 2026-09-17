import request from '@/utils/request'

// 新增：根据课程ID查询选课学生
export function listStudentByCourse(courseId) {
    return request({
        url: `/manage/student/listByCourse/${courseId}`,
        method: 'get'
    });
}
// 查询学生信息（学生个人信息）列表
export function listStudent(query) {
  return request({
    url: '/manage/student/list',
    method: 'get',
    params: query
  })
}

// 查询学生信息（学生个人信息）详细
export function getStudent(id) {
  return request({
    url: '/manage/student/' + id,
    method: 'get'
  })
}

// 新增学生信息（学生个人信息）
export function addStudent(data) {
  return request({
    url: '/manage/student',
    method: 'post',
    data: data
  })
}

// 修改学生信息（学生个人信息）
export function updateStudent(data) {
  return request({
    url: '/manage/student',
    method: 'put',
    data: data
  })
}

// 删除学生信息（学生个人信息）
export function delStudent(id) {
  return request({
    url: '/manage/student/' + id,
    method: 'delete'
  })
}
