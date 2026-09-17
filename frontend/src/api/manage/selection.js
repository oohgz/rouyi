import request from '@/utils/request'

// 查询学生选课列表
export function listSelection(query) {
  return request({
    url: '/manage/selection/list',
    method: 'get',
    params: query
  })
}

// 查询学生选课详细
export function getSelection(id) {
  return request({
    url: '/manage/selection/' + id,
    method: 'get'
  })
}

// 新增学生选课
export function addSelection(data) {
  return request({
    url: '/manage/selection',
    method: 'post',
    data: data
  })
}

// 修改学生选课
export function updateSelection(data) {
  return request({
    url: '/manage/selection',
    method: 'put',
    data: data
  })
}

// 删除学生选课
export function delSelection(id) {
  return request({
    url: '/manage/selection/' + id,
    method: 'delete'
  })
}
