import request from '@/utils/request'

// 查询选课异常记录列表
export function listException(query) {
  return request({
    url: '/manage/exception/list',
    method: 'get',
    params: query
  })
}

// 查询选课异常记录详细
export function getException(id) {
  return request({
    url: '/manage/exception/' + id,
    method: 'get'
  })
}

// 新增选课异常记录
export function addException(data) {
  return request({
    url: '/manage/exception',
    method: 'post',
    data: data
  })
}

// 修改选课异常记录
export function updateException(data) {
  return request({
    url: '/manage/exception',
    method: 'put',
    data: data
  })
}

// 删除选课异常记录
export function delException(id) {
  return request({
    url: '/manage/exception/' + id,
    method: 'delete'
  })
}
