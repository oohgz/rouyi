import request from '@/utils/request'

// AI聊天接口
export function aiChat(data) {
  return request({
    url: '/ai/chat',
    method: 'post',
    data: data
  })
}

// AI内容生成接口
export function aiGenerate(data) {
  return request({
    url: '/ai/generate',
    method: 'post',
    data: data
  })
}

// AI文本分析接口
export function aiAnalyze(data) {
  return request({
    url: '/ai/analyze',
    method: 'post',
    data: data
  })
}

// 获取AI功能状态
export function getAiStatus() {
  return request({
    url: '/ai/status',
    method: 'get'
  })
}

// AI智能文本摘要生成接口
export function aiSummarize(data) {
  return request({
    url: '/ai/summarize',
    method: 'post',
    data: data
  })
}