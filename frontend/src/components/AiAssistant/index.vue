<template>
  <div class="ai-assistant-container">
    <div class="ai-header">
      <h3><svg-icon icon-class="chat" /> AI 智能助手</h3>
      <div class="ai-tabs">
        <el-radio-group v-model="activeTab" size="medium">
          <el-radio-button label="chat">智能对话</el-radio-button>
          <el-radio-button label="summary">文本摘要</el-radio-button>
        </el-radio-group>
      </div>
    </div>

    <div class="ai-chat-container">
      <div class="chat-messages" ref="chatContainer">
        <div
          v-for="(msg, index) in messages"
          :key="index"
          :class="['message', msg.sender]"
        >
          <div class="avatar">
            <svg-icon
              :icon-class="msg.sender === 'user' ? 'user' : 'ai'"
              :style="{ color: msg.sender === 'user' ? '#409EFF' : '#67C23A' }"
            />
          </div>
          <div class="content">
            <div class="bubble" :class="msg.sender">
              {{ msg.content }}
            </div>
            <div class="timestamp">{{ formatDate(msg.timestamp) }}</div>
          </div>
        </div>
      </div>

      <div class="chat-input-area">
        <el-input
          v-model="inputMessage"
          :rows="2"
          type="textarea"
          placeholder="请输入您的问题..."
          maxlength="500"
          show-word-limit
          @keyup.enter="handleSend($event)"
        />
        <el-button
          type="primary"
          :loading="sending"
          :disabled="!inputMessage.trim() || sending"
          @click="sendMessage"
          class="send-btn"
        >
          <svg-icon icon-class="send" /> 发送
        </el-button>
      </div>
    </div>

    <div class="ai-features">
      <h4>AI 功能</h4>
      <div class="feature-grid">
        <el-card class="feature-item" @click="predefinedQuestion('介绍系统')">
          <div class="feature-content">
            <svg-icon icon-class="info" class="feature-icon" />
            <h5>介绍系统</h5>
            <p>了解 RuoYi 系统功能</p>
          </div>
        </el-card>

        <el-card class="feature-item" @click="predefinedQuestion('使用帮助')">
          <div class="feature-content">
            <svg-icon icon-class="help" class="feature-icon" />
            <h5>使用帮助</h5>
            <p>获取系统使用指导</p>
          </div>
        </el-card>

        <el-card class="feature-item" @click="predefinedQuestion('最佳实践')">
          <div class="feature-content">
            <svg-icon icon-class="lightning" class="feature-icon" />
            <h5>最佳实践</h5>
            <p>获取开发建议</p>
          </div>
        </el-card>
      </div>
    </div>

    <!-- 文本摘要功能区域 -->
    <div v-if="activeTab === 'summary'" class="summary-container">
      <div class="summary-header">
        <h4><svg-icon icon-class="document" /> 智能文本摘要</h4>
        <p>输入长文本，AI将自动生成简洁的摘要</p>
      </div>
      
      <div class="summary-content">
        <div class="input-section">
          <el-input
            v-model="inputText"
            type="textarea"
            :rows="10"
            placeholder="请输入需要生成摘要的长文本..."
            maxlength="5000"
            show-word-limit
          />
          <div class="summary-options">
            <span class="option-label">摘要长度：</span>
            <el-radio-group v-model="summaryLength" size="small">
              <el-radio-button label="short">简短</el-radio-button>
              <el-radio-button label="medium">中等</el-radio-button>
              <el-radio-button label="long">详细</el-radio-button>
            </el-radio-group>
            <el-button
              type="primary"
              :loading="summarizing"
              :disabled="!inputText.trim() || summarizing"
              @click="generateSummary"
              class="summarize-btn"
            >
              <svg-icon icon-class="magic" /> 生成摘要
            </el-button>
          </div>
        </div>
        
        <div class="result-section" v-if="summaryResult">
          <div class="result-header">
            <h5>摘要结果</h5>
            <div class="result-stats">
              <span>原文长度: {{ summaryResult.originalLength }} 字符</span>
              <span>摘要长度: {{ summaryResult.summaryLength }} 字符</span>
              <span>压缩比: {{ summaryResult.compressionRatio }}</span>
            </div>
          </div>
          <div class="result-content">
            <el-input
              v-model="summaryResult.summary"
              type="textarea"
              :rows="6"
              readonly
            />
          </div>
          <div class="result-actions">
            <el-button @click="copySummary" size="small">
              <svg-icon icon-class="copy" /> 复制摘要
            </el-button>
            <el-button @click="clearSummary" size="small">
              <svg-icon icon-class="delete" /> 清空
            </el-button>
          </div>
        </div>
        
        <div class="empty-result" v-else>
          <svg-icon icon-class="document" class="empty-icon" />
          <p>摘要结果将在这里显示</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, nextTick, onMounted } from 'vue'
import { aiChat, aiSummarize } from '@/api/ai/index.js'
import { parseTime } from '@/utils/ruoyi'
import { ElMessage } from 'element-plus'

const inputMessage = ref('')
const messages = ref([
  {
    sender: 'ai',
    content: '您好！我是RuoYi系统的AI助手，很高兴为您服务。您可以问我关于系统使用、功能说明或开发相关的问题。',
    timestamp: new Date()
  }
])
const sending = ref(false)
const chatContainer = ref(null)
const activeTab = ref('chat') // 当前活动标签：chat 或 summary
const inputText = ref('') // 摘要功能的输入文本
const summarizing = ref(false) // 摘要生成状态
const summaryResult = ref(null) // 摘要结果
const summaryLength = ref('medium') // 摘要长度

// 格式化时间显示
const formatDate = (time) => {
  return parseTime(time, '{y}-{m}-{d} {h}:{i}')
}

// 发送消息
const sendMessage = async () => {
  const msg = inputMessage.value.trim()
  if (!msg) return

  // 添加用户消息
  messages.value.push({
    sender: 'user',
    content: msg,
    timestamp: new Date()
  })

  inputMessage.value = ''
  sending.value = true

  try {
    const response = await aiChat({ message: msg })
    if (response.code === 200) {
      // 添加AI回复
      messages.value.push({
        sender: 'ai',
        content: response.data.answer,
        timestamp: new Date(response.data.timestamp)
      })
    } else {
      messages.value.push({
        sender: 'ai',
        content: `抱歉，处理您的请求时出现问题: ${response.msg}`,
        timestamp: new Date()
      })
    }
  } catch (error) {
    console.error('发送消息失败:', error)
    messages.value.push({
      sender: 'ai',
      content: '抱歉，连接AI服务时出现错误，请稍后再试。',
      timestamp: new Date()
    })
  } finally {
    sending.value = false
    scrollToBottom()
  }
}

// 处理回车发送
const handleSend = (event) => {
  if (event.shiftKey) {
    // Shift + Enter 换行
    return
  }
  event.preventDefault()
  sendMessage()
}

// 滚动到底部
const scrollToBottom = () => {
  nextTick(() => {
    if (chatContainer.value) {
      chatContainer.value.scrollTop = chatContainer.value.scrollHeight
    }
  })
}

// 预设问题
const predefinedQuestion = (question) => {
  switch(question) {
    case '介绍系统':
      inputMessage.value = '请介绍一下RuoYi系统的主要功能和特点'
      break
    case '使用帮助':
      inputMessage.value = '如何在RuoYi系统中添加新用户？'
      break
    case '最佳实践':
      inputMessage.value = 'RuoYi系统开发的最佳实践是什么？'
      break
    default:
      inputMessage.value = question
  }
  sendMessage()
}

// 组件挂载后滚动到底部
onMounted(() => {
  scrollToBottom()
})

// 生成文本摘要
const generateSummary = async () => {
  if (!inputText.value.trim()) {
    ElMessage.warning('请输入需要摘要的文本')
    return
  }

  summarizing.value = true
  try {
    const response = await aiSummarize({
      text: inputText.value,
      length: summaryLength.value
    })
    
    if (response.code === 200) {
      summaryResult.value = response.data
      ElMessage.success('摘要生成成功')
    } else {
      ElMessage.error(`摘要生成失败: ${response.msg}`)
    }
  } catch (error) {
    console.error('生成摘要失败:', error)
    ElMessage.error('生成摘要时出现错误，请稍后再试')
  } finally {
    summarizing.value = false
  }
}

// 复制摘要到剪贴板
const copySummary = async () => {
  if (!summaryResult.value || !summaryResult.value.summary) {
    ElMessage.warning('没有可复制的摘要内容')
    return
  }
  
  try {
    await navigator.clipboard.writeText(summaryResult.value.summary)
    ElMessage.success('摘要已复制到剪贴板')
  } catch (err) {
    console.error('复制失败:', err)
    ElMessage.error('复制失败，请手动复制')
  }
}

// 清空摘要结果
const clearSummary = () => {
  summaryResult.value = null
  inputText.value = ''
}
</script>

<style lang="scss" scoped>
.ai-assistant-container {
  max-width: 1200px;
  margin: 20px auto;
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);

  .ai-header {
    text-align: center;
    margin-bottom: 20px;

    h3 {
      color: #303133;
      font-size: 24px;

      .svg-icon {
        margin-right: 10px;
        color: #409EFF;
      }
    }
  }

  .ai-chat-container {
    border: 1px solid #e4e7ed;
    border-radius: 8px;
    overflow: hidden;
    margin-bottom: 30px;

    .chat-messages {
      height: 400px;
      overflow-y: auto;
      padding: 20px;
      background-color: #fafafa;

      .message {
        display: flex;
        margin-bottom: 15px;

        &.user {
          flex-direction: row-reverse;

          .avatar {
            margin-left: 10px;
          }
        }

        &.ai {
          .avatar {
            margin-right: 10px;
          }
        }

        .avatar {
          width: 40px;
          height: 40px;
          border-radius: 50%;
          background: #fff;
          display: flex;
          align-items: center;
          justify-content: center;
          flex-shrink: 0;

          .svg-icon {
            font-size: 20px;
          }
        }

        .content {
          flex: 1;

          .bubble {
            display: inline-block;
            padding: 10px 15px;
            border-radius: 18px;
            max-width: 70%;

            &.user {
              background: #409EFF;
              color: white;
              border-bottom-right-radius: 4px;
            }

            &.ai {
              background: white;
              color: #303133;
              border-bottom-left-radius: 4px;
              box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
          }

          .timestamp {
            font-size: 12px;
            color: #909399;
            margin-top: 5px;
            text-align: right;
          }
        }
      }
    }

    .chat-input-area {
      padding: 15px;
      background: white;
      display: flex;
      flex-direction: column;
      gap: 10px;

      .el-textarea {
        :deep(.el-textarea__inner) {
          resize: none;
        }
      }

      .send-btn {
        align-self: flex-end;
        margin-top: 10px;
      }
    }
  }

  .ai-features {
    h4 {
      margin-bottom: 15px;
      color: #303133;
      font-size: 18px;
    }

    .feature-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 15px;

      .feature-item {
        cursor: pointer;
        transition: transform 0.3s, box-shadow 0.3s;

        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.2);
        }

        .feature-content {
          text-align: center;

          .feature-icon {
            font-size: 36px;
            margin-bottom: 10px;
            color: #409EFF;
          }

          h5 {
            margin: 10px 0 5px 0;
            color: #303133;
          }

          p {
            margin: 0;
            font-size: 14px;
            color: #909399;
          }
        }
      }
    }
  }

  /* 文本摘要功能样式 */
  .ai-tabs {
    display: flex;
    justify-content: center;
    margin-top: 15px;
  }

  .summary-container {
    margin-top: 30px;
    border: 1px solid #e4e7ed;
    border-radius: 8px;
    overflow: hidden;

    .summary-header {
      padding: 20px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      text-align: center;

      h4 {
        margin: 0 0 10px 0;
        font-size: 20px;

        .svg-icon {
          margin-right: 10px;
        }
      }

      p {
        margin: 0;
        opacity: 0.9;
        font-size: 14px;
      }
    }

    .summary-content {
      padding: 20px;

      .input-section {
        margin-bottom: 20px;

        .summary-options {
          display: flex;
          align-items: center;
          gap: 15px;
          margin-top: 15px;
          flex-wrap: wrap;

          .option-label {
            font-weight: 500;
            color: #606266;
          }

          .summarize-btn {
            margin-left: auto;
          }
        }
      }

      .result-section {
        border: 1px solid #e4e7ed;
        border-radius: 8px;
        overflow: hidden;

        .result-header {
          padding: 15px 20px;
          background: #f5f7fa;
          border-bottom: 1px solid #e4e7ed;

          h5 {
            margin: 0 0 10px 0;
            color: #303133;
          }

          .result-stats {
            display: flex;
            gap: 20px;
            font-size: 12px;
            color: #909399;
          }
        }

        .result-content {
          padding: 20px;

          .el-textarea {
            :deep(.el-textarea__inner) {
              background: #fafafa;
              border: none;
              resize: none;
            }
          }
        }

        .result-actions {
          padding: 15px 20px;
          background: #f5f7fa;
          border-top: 1px solid #e4e7ed;
          display: flex;
          gap: 10px;
          justify-content: flex-end;
        }
      }

      .empty-result {
        text-align: center;
        padding: 40px 20px;
        color: #909399;

        .empty-icon {
          font-size: 48px;
          margin-bottom: 15px;
          opacity: 0.5;
        }

        p {
          margin: 0;
          font-size: 14px;
        }
      }
    }
  }
}
</style>