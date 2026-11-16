package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.config.AiConfig;
import com.ruoyi.service.ai.AiService;
import com.ruoyi.service.ai.AiStatsService;
import com.ruoyi.service.ai.DeepSeekChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;

/**
 * AI智能功能控制器
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/ai")
public class AiController
{
    @Autowired
    private AiConfig aiConfig;

    @Autowired
    private AiService aiService;

    @Autowired
    private DeepSeekChatService deepSeekChatService;

    @Autowired(required = false)  // 设置为可选，数据库不可用时不会报错
    private AiStatsService aiStatsService;

    // 检查数据库服务是否可用
    private boolean isStatsServiceAvailable() {
        return aiStatsService != null;
    }

    /**
     * AI健康检查接口
     */
    @Anonymous
    @GetMapping("/status")
    public AjaxResult getStatus()
    {
        Map<String, Object> status = new HashMap<>();
        status.put("enabled", aiConfig.isEnabled());
        status.put("provider", aiConfig.getProvider());
        status.put("model", aiConfig.getModel());
        status.put("timestamp", System.currentTimeMillis());

        return AjaxResult.success(status);
    }

    /**
     * AI智能问答接口（真实调用DeepSeek API + Function Calling）
     */
    @PostMapping("/chat")
    public AjaxResult chat(@RequestBody Map<String, String> requestData)
    {
        String message = requestData.get("message");
        if (StringUtils.isEmpty(message)) {
            return AjaxResult.error("请输入有效的问题");
        }

        Long userId = null;
        try {
            userId = SecurityUtils.getUserId();
        } catch (Exception e) {
            // 未登录用户也能问，但查个人数据时会失败
        }

        String answer = deepSeekChatService.chat(message, userId);

        Map<String, Object> result = new HashMap<>();
        result.put("question", message);
        result.put("answer", answer);
        result.put("timestamp", System.currentTimeMillis());

        return AjaxResult.success(result);
    }

    /**
     * AI文本生成接口（模拟实现）
     */
    @Anonymous
    @PostMapping("/generate")
    public AjaxResult generateText(@RequestBody Map<String, String> requestData)
    {
        if (!aiConfig.isEnabled()) {
            return AjaxResult.error("AI功能未启用");
        }

        String prompt = requestData.get("prompt");
        if (StringUtils.isEmpty(prompt)) {
            return AjaxResult.error("请输入有效的提示");
        }

        String contentType = requestData.getOrDefault("contentType", "text");

        // 模拟AI生成文本
        String generatedText = generateContent(prompt, contentType);

        Map<String, Object> result = new HashMap<>();
        result.put("prompt", prompt);
        result.put("generated", generatedText);
        result.put("contentType", contentType);
        result.put("timestamp", System.currentTimeMillis());

        return AjaxResult.success(result);
    }

    /**
     * AI文本分析接口（模拟实现）
     */
    @Anonymous
    @PostMapping("/analyze")
    public AjaxResult analyzeText(@RequestBody Map<String, String> requestData)
    {
        if (!aiConfig.isEnabled()) {
            return AjaxResult.error("AI功能未启用");
        }

        String text = requestData.get("text");
        if (StringUtils.isEmpty(text)) {
            return AjaxResult.error("请输入要分析的文本");
        }

        String analysisType = requestData.getOrDefault("analysisType", "sentiment");

        // 模拟AI分析文本
        Map<String, Object> analysisResult = analyzeContent(text, analysisType);

        return AjaxResult.success(analysisResult);
    }

    /**
     * 获取系统概览数据（课程数、学生数、成绩记录、平均分等）
     */
    @Anonymous
    @GetMapping("/overview")
    public AjaxResult getOverview()
    {
        // 检查数据库服务是否可用
        if (!isStatsServiceAvailable()) {
            // 返回模拟数据或错误提示
            Map<String, Object> mockData = new HashMap<>();
            mockData.put("totalCourses", 0);
            mockData.put("totalStudents", 0);
            mockData.put("totalScores", 0);
            mockData.put("avgScore", "0");
            mockData.put("note", "数据库服务不可用，这是模拟数据");
            return AjaxResult.success(mockData);
        }
        
        try {
            return AjaxResult.success(aiStatsService.getSystemOverview());
        } catch (Exception e) {
            // 记录日志并返回友好错误
            System.err.println("获取系统概览失败: " + e.getMessage());
            return AjaxResult.error("获取系统概览失败，请稍后再试");
        }
    }

    /**
     * 获取课程热门度排行
     */
    @Anonymous
    @GetMapping("/courseRanking")
    public AjaxResult getCourseRanking()
    {
        // 检查数据库服务是否可用
        if (!isStatsServiceAvailable()) {
            // 返回空列表或模拟数据
            List<Map<String, Object>> mockData = new ArrayList<>();
            Map<String, Object> mockCourse = new HashMap<>();
            mockCourse.put("courseName", "示例课程");
            mockCourse.put("courseCode", "DEMO001");
            mockCourse.put("note", "数据库服务不可用，这是模拟数据");
            mockData.add(mockCourse);
            return AjaxResult.success(mockData);
        }
        
        try {
            return AjaxResult.success(aiStatsService.getCoursePopularity());
        } catch (Exception e) {
            // 记录日志并返回友好错误
            System.err.println("获取课程排行失败: " + e.getMessage());
            return AjaxResult.error("获取课程排行失败，请稍后再试");
        }
    }

    /**
     * 学习预警学生列表
     */
    @Anonymous
    @GetMapping("/studentsWarn")
    public AjaxResult getStudentsWarn()
    {
        // 检查数据库服务是否可用
        if (!isStatsServiceAvailable()) {
            // 返回空列表
            List<Map<String, Object>> emptyList = new ArrayList<>();
            return AjaxResult.success(emptyList);
        }
        
        try {
            return AjaxResult.success(aiStatsService.getRiskAlerts());
        } catch (Exception e) {
            // 记录日志并返回友好错误
            System.err.println("获取预警学生失败: " + e.getMessage());
            return AjaxResult.error("获取预警学生失败，请稍后再试");
        }
    }

    /**
     * AI智能文本摘要生成接口
     */
    @Anonymous
    @PostMapping("/summarize")
    public AjaxResult generateSummary(@RequestBody Map<String, String> requestData)
    {
        if (!aiConfig.isEnabled()) {
            return AjaxResult.error("AI功能未启用");
        }

        String text = requestData.get("text");
        if (StringUtils.isEmpty(text)) {
            return AjaxResult.error("请输入要摘要的文本");
        }

        // 获取摘要长度参数，默认为中等长度
        String lengthStr = requestData.getOrDefault("length", "medium");
        int maxLength = 150; // 默认中等长度
        
        if ("short".equals(lengthStr)) {
            maxLength = 50;
        } else if ("long".equals(lengthStr)) {
            maxLength = 300;
        }

        // 调用智能摘要生成服务
        String summary = generateTextSummary(text, maxLength);

        Map<String, Object> result = new HashMap<>();
        result.put("originalText", text.length() > 100 ? text.substring(0, 100) + "..." : text);
        result.put("summary", summary);
        result.put("originalLength", text.length());
        result.put("summaryLength", summary.length());
        result.put("compressionRatio", String.format("%.1f%%", (1 - (double)summary.length() / text.length()) * 100));
        result.put("timestamp", System.currentTimeMillis());

        return AjaxResult.success(result);
    }

    /**
     * 模拟AI查询处理
     */
    private String processAiQuery(String message)
    {
        // 这里应该是实际的AI模型调用
        // 当前只是一个简单的模拟实现
        message = message.toLowerCase();

        if (message.contains("你好") || message.contains("hello")) {
            return "您好！我是AI助手，很高兴为您服务。";
        } else if (message.contains("名字") || message.contains("姓名")) {
            return "我是RuoYi系统的AI助手，您可以问我任何问题。";
        } else if (message.contains("帮助") || message.contains("help")) {
            return "我可以帮您解答关于RuoYi系统的问题，或者提供一般性的知识咨询。";
        } else if (message.contains("天气")) {
            return "抱歉，我无法获取实时天气信息，建议您查询专业天气预报网站。";
        } else if (message.contains("时间") || message.contains("几点")) {
            return "当前时间是：" + java.time.LocalDateTime.now().toString();
        } else if (message.contains("系统") || message.contains("功能")) {
            return "RuoYi是一款基于Spring Boot和Vue的前后端分离快速开发平台，具有用户管理、部门管理、岗位管理、菜单管理、角色管理等功能模块。";
        } else {
            return "我已经收到您的问题: \"" + message + "\"。这是一个模拟的AI回复，实际应用中会调用AI模型进行处理。";
        }
    }

    /**
     * 模拟AI内容生成
     */
    private String generateContent(String prompt, String contentType)
    {
        // 这里应该是实际的AI模型调用
        // 当前只是一个简单的模拟实现
        return "根据您的要求: \"" + prompt + "\", 这是AI生成的内容示例。\n\n" +
               "在实际应用中，这里会调用真实的AI模型来生成相应的内容，比如文本、代码或其他类型的输出。\n\n" +
               "生成类型: " + contentType + "\n" +
               "当前时间: " + java.time.LocalDateTime.now();
    }

    /**
     * 模拟AI内容分析
     */
    private Map<String, Object> analyzeContent(String text, String analysisType)
    {
        Map<String, Object> result = new HashMap<>();
        result.put("text", text);
        result.put("analysisType", analysisType);

        if ("sentiment".equals(analysisType)) {
            // 模拟情感分析
            result.put("sentiment", "neutral");
            result.put("confidence", 0.7);
            result.put("summary", "文本情感倾向为中性，置信度70%");
        } else if ("keywords".equals(analysisType)) {
            // 模拟关键词提取
            result.put("keywords", new String[]{"AI", "分析", "文本", "系统"});
            result.put("summary", "提取到4个关键词");
        } else if ("summary".equals(analysisType)) {
            // 模拟摘要生成
            result.put("summary", "这是文本的简要总结。在实际应用中，AI模型会根据文本内容生成更准确的摘要。");
        } else {
            result.put("summary", "AI分析完成");
        }

        result.put("timestamp", System.currentTimeMillis());
        return result;
    }

    /**
     * 生成文本摘要（模拟实现）
     * 实际应用中应调用真实的AI模型（如GPT、文心一言等）
     */
    private String generateTextSummary(String text, int maxLength) {
        // 简单的模拟实现：提取关键句子
        // 实际应用中应该使用NLP技术或调用AI模型API
        
        if (text.length() <= maxLength) {
            return text; // 如果文本本身就很短，直接返回
        }
        
        // 模拟智能摘要：取前几句关键内容
        String[] sentences = text.split("[。！？!?]+");
        StringBuilder summary = new StringBuilder();
        
        for (String sentence : sentences) {
            if (sentence.trim().length() > 0) {
                if (summary.length() + sentence.length() + 1 <= maxLength) {
                    if (summary.length() > 0) {
                        summary.append("。");
                    }
                    summary.append(sentence.trim());
                } else {
                    break;
                }
            }
        }
        
        // 如果摘要太短，添加省略号
        if (summary.length() < text.length() / 3) {
            summary.append("...");
        }
        
        return summary.toString();
    }
}
