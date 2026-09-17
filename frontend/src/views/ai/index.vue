<template>
  <div class="ai-assistant-page">
    <AiAssistant />
  </div>
</template>

<script setup>
import AiAssistant from '@/components/AiAssistant/index.vue'

// 页面标题
defineOptions({
  name: 'AiAssistantPage'
})
</script>

<style lang="scss" scoped>
.ai-assistant-page {
  padding: 0;
  background-color: #f5f7fa;
  min-height: calc(100vh - 115px);
}
</style>