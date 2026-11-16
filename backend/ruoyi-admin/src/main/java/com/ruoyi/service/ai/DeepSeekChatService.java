package com.ruoyi.service.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.config.AiConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

/**
 * DeepSeek AI 服务，支持 Function Calling 查询数据库
 */
@Service
public class DeepSeekChatService {

    private static final Logger log = LoggerFactory.getLogger(DeepSeekChatService.class);
    private static final String API_URL = "https://api.deepseek.com/chat/completions";

    @Autowired
    private AiConfig aiConfig;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private RedisCache redisCache;

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final RestTemplate restTemplate = new RestTemplate();

    private static final String SYSTEM_PROMPT =
            "你是智慧课程管理系统的AI助手。学生和老师会用自然语言提问，你可以调用工具查询数据库获取真实数据。\n" +
            "规则：\n" +
            "1. 需要查数据时，必须调用工具，不要自己编造数据\n" +
            "2. 拿到工具返回的数据后，用简洁友好的中文回答\n" +
            "3. 如果问题和课程管理无关，礼貌告知你只能回答课程相关问题\n" +
            "4. 当前登录用户ID从上下文中获取，查个人相关数据时使用";

    private ArrayNode buildTools() {
        ArrayNode tools = objectMapper.createArrayNode();

        ObjectNode tool1 = objectMapper.createObjectNode();
        tool1.put("type", "function");
        ObjectNode func1 = tool1.putObject("function");
        func1.put("name", "getStudentCourses");
        func1.put("description", "查询某个学生选了哪些课程，返回课程名、学分、教师");
        ObjectNode params1 = func1.putObject("parameters");
        params1.put("type", "object");
        ObjectNode props1 = params1.putObject("properties");
        props1.putObject("studentId").put("type", "integer").put("description", "学生用户ID");
        params1.putArray("required").add("studentId");
        tools.add(tool1);

        ObjectNode tool2 = objectMapper.createObjectNode();
        tool2.put("type", "function");
        ObjectNode func2 = tool2.putObject("function");
        func2.put("name", "getStudentScores");
        func2.put("description", "查询某个学生的所有课程成绩");
        ObjectNode params2 = func2.putObject("parameters");
        params2.put("type", "object");
        ObjectNode props2 = params2.putObject("properties");
        props2.putObject("studentId").put("type", "integer").put("description", "学生用户ID");
        params2.putArray("required").add("studentId");
        tools.add(tool2);

        ObjectNode tool3 = objectMapper.createObjectNode();
        tool3.put("type", "function");
        ObjectNode func3 = tool3.putObject("function");
        func3.put("name", "getCourseList");
        func3.put("description", "查询所有课程列表，可按学院筛选");
        ObjectNode params3 = func3.putObject("parameters");
        params3.put("type", "object");
        ObjectNode props3 = params3.putObject("properties");
        props3.putObject("college").put("type", "string").put("description", "学院名称（可选，不传则查全部）");
        tools.add(tool3);

        ObjectNode tool4 = objectMapper.createObjectNode();
        tool4.put("type", "function");
        ObjectNode func4 = tool4.putObject("function");
        func4.put("name", "getTeacherCourses");
        func4.put("description", "查询某个教师教了哪些课程");
        ObjectNode params4 = func4.putObject("parameters");
        params4.put("type", "object");
        ObjectNode props4 = params4.putObject("properties");
        props4.putObject("teacherId").put("type", "integer").put("description", "教师用户ID");
        params4.putArray("required").add("teacherId");
        tools.add(tool4);

        ObjectNode tool5 = objectMapper.createObjectNode();
        tool5.put("type", "function");
        ObjectNode func5 = tool5.putObject("function");
        func5.put("name", "getCourseAverageScores");
        func5.put("description", "查询每门课程的平均分、最高分、最低分和选课人数");
        ObjectNode params5 = func5.putObject("parameters");
        params5.put("type", "object");
        params5.putObject("properties");
        tools.add(tool5);

        // 第6个工具：查不及格学生
        ObjectNode tool6 = objectMapper.createObjectNode();
        tool6.put("type", "function");
        ObjectNode func6 = tool6.putObject("function");
        func6.put("name", "getRiskStudents");
        func6.put("description", "查询成绩不及格（低于60分）的学生列表，返回学生姓名、课程名和分数");
        ObjectNode params6 = func6.putObject("parameters");
        params6.put("type", "object");
        ObjectNode props6 = params6.putObject("properties");
        props6.putObject("college").put("type", "string").put("description", "学院名称（可选，不传则查全部学院）");
        tools.add(tool6);

        // 第7个工具：查选课异常记录
        ObjectNode tool7 = objectMapper.createObjectNode();
        tool7.put("type", "function");
        ObjectNode func7 = tool7.putObject("function");
        func7.put("name", "getSelectionExceptions");
        func7.put("description", "查询选课异常记录，包括重复选课和超员选课，返回学生姓名、课程名、异常类型");
        ObjectNode params7 = func7.putObject("parameters");
        params7.put("type", "object");
        ObjectNode props7 = params7.putObject("properties");
        props7.putObject("exceptionType").put("type", "integer").put("description", "异常类型：1=重复选课，2=超员选课（可选，不传则查全部）");
        tools.add(tool7);

        // 第8个工具：查课程成绩分布
        ObjectNode tool8 = objectMapper.createObjectNode();
        tool8.put("type", "function");
        ObjectNode func8 = tool8.putObject("function");
        func8.put("name", "getCourseScoreDistribution");
        func8.put("description", "查询某门课程的成绩分布情况，包括平均分、最高分、最低分、各分数段人数");
        ObjectNode params8 = func8.putObject("parameters");
        params8.put("type", "object");
        ObjectNode props8 = params8.putObject("properties");
        props8.putObject("courseName").put("type", "string").put("description", "课程名称，比如Java程序设计");
        params8.putArray("required").add("courseName");
        tools.add(tool8);

        // 第9个工具：按学院统计成绩
        ObjectNode tool9 = objectMapper.createObjectNode();
        tool9.put("type", "function");
        ObjectNode func9 = tool9.putObject("function");
        func9.put("name", "getCollegeStats");
        func9.put("description", "按学院统计各学院的平均分、选课人数、不及格人数，用于对比各学院教学情况");
        ObjectNode params9 = func9.putObject("parameters");
        params9.put("type", "object");
        params9.putObject("properties");
        tools.add(tool9);

        return tools;
    }

    public String chat(String userMessage, Long currentUserId) {
        String apiKey = aiConfig.getApiKey();
        if (apiKey == null || apiKey.isEmpty()) {
            return "AI功能未配置API Key，请在application.yml中配置ruoyi.ai.apiKey";
        }

        try {
            ArrayNode messages = objectMapper.createArrayNode();

            ObjectNode sysMsg = objectMapper.createObjectNode();
            sysMsg.put("role", "system");
            String systemContent = SYSTEM_PROMPT;
            if (currentUserId != null) {
                systemContent += "\n当前登录用户ID是：" + currentUserId;
                // 查用户身份
                try {
                    Map<String, Object> student = jdbcTemplate.queryForMap(
                        "SELECT student_name, college, class_name FROM tb_student WHERE user_id = ?", currentUserId);
                    systemContent += "，身份是学生，姓名：" + student.get("student_name")
                        + "，学院：" + student.get("college")
                        + "，班级：" + student.get("class_name");
                } catch (Exception e1) {
                    try {
                        Map<String, Object> teacher = jdbcTemplate.queryForMap(
                            "SELECT teacher_name, college FROM tb_teacher WHERE user_id = ?", currentUserId);
                        systemContent += "，身份是教师，姓名：" + teacher.get("teacher_name")
                            + "，学院：" + teacher.get("college");
                    } catch (Exception e2) {
                        systemContent += "，身份是管理员";
                    }
                }
            }
            sysMsg.put("content", systemContent);
            messages.add(sysMsg);

            // 从Redis读取历史对话，加到messages里
            String historyKey = "ai:chat:history:" + (currentUserId != null ? currentUserId : "anonymous");
            String historyJson = redisCache.getCacheObject(historyKey);
            if (historyJson != null && !historyJson.isEmpty()) {
                ArrayNode history = (ArrayNode) objectMapper.readTree(historyJson);
                for (JsonNode msg : history) {
                    messages.add((ObjectNode) msg);
                }
            }

            ObjectNode userMsg = objectMapper.createObjectNode();
            userMsg.put("role", "user");
            userMsg.put("content", userMessage);
            messages.add(userMsg);

            String firstResponse = callDeepSeek(messages, buildTools());
            JsonNode firstJson = objectMapper.readTree(firstResponse);
            JsonNode choice = firstJson.path("choices").path(0).path("message");

            if (choice.has("tool_calls") && !choice.path("tool_calls").isNull()) {
                messages.add((ObjectNode) choice);

                for (JsonNode toolCall : choice.path("tool_calls")) {
                    String toolName = toolCall.path("function").path("name").asText();
                    String arguments = toolCall.path("function").path("arguments").asText();
                    String toolCallId = toolCall.path("id").asText();

                    log.info("AI调用工具: {}, 参数: {}", toolName, arguments);
                    String toolResult = executeTool(toolName, arguments);

                    ObjectNode toolMsg = objectMapper.createObjectNode();
                    toolMsg.put("role", "tool");
                    toolMsg.put("tool_call_id", toolCallId);
                    toolMsg.put("content", toolResult);
                    messages.add(toolMsg);
                }

                String secondResponse = callDeepSeek(messages, buildTools());
                JsonNode secondJson = objectMapper.readTree(secondResponse);
                String answer = secondJson.path("choices").path(0).path("message").path("content").asText();
                saveToHistory(historyKey, userMessage, answer);
                return answer;
            }

            String answer = choice.path("content").asText();
            saveToHistory(historyKey, userMessage, answer);
            return answer;

        } catch (Exception e) {
            log.error("AI调用失败", e);
            return "AI服务暂时不可用：" + e.getMessage();
        }
    }

    /**
     * 保存对话历史到Redis，只保留最近10轮
     */
    private void saveToHistory(String key, String userMessage, String aiAnswer) {
        ArrayNode history;
        String historyJson = redisCache.getCacheObject(key);
        if (historyJson != null && !historyJson.isEmpty()) {
            try {
                history = (ArrayNode) objectMapper.readTree(historyJson);
            } catch (Exception e) {
                history = objectMapper.createArrayNode();
            }
        } else {
            history = objectMapper.createArrayNode();
        }

        ObjectNode userMsg = objectMapper.createObjectNode();
        userMsg.put("role", "user");
        userMsg.put("content", userMessage);
        history.add(userMsg);

        ObjectNode aiMsg = objectMapper.createObjectNode();
        aiMsg.put("role", "assistant");
        aiMsg.put("content", aiAnswer);
        history.add(aiMsg);

        // 只保留最近20条消息（10轮对话），避免太长
        while (history.size() > 20) {
            history.remove(0);
        }

        redisCache.setCacheObject(key, history.toString(), 1, java.util.concurrent.TimeUnit.HOURS);
    }

    private String callDeepSeek(ArrayNode messages, ArrayNode tools) {
        try {
            ObjectNode body = objectMapper.createObjectNode();
            body.put("model", aiConfig.getModel());
            body.set("messages", messages);
            body.set("tools", tools);
            body.put("max_tokens", 1024);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(aiConfig.getApiKey());

            HttpEntity<String> request = new HttpEntity<>(objectMapper.writeValueAsString(body), headers);
            return restTemplate.postForObject(API_URL, request, String.class);
        } catch (Exception e) {
            throw new RuntimeException("调用DeepSeek失败: " + e.getMessage(), e);
        }
    }

    private String executeTool(String toolName, String arguments) {
        try {
            JsonNode args = objectMapper.readTree(arguments);
            switch (toolName) {
                case "getStudentCourses": {
                    Long studentId = args.path("studentId").asLong();
                    List<Map<String, Object>> courses = jdbcTemplate.queryForList(
                        "SELECT c.course_name, t.teacher_name " +
                        "FROM tb_student_selection ss " +
                        "JOIN tb_course c ON ss.course_id = c.id " +
                        "LEFT JOIN tb_teacher t ON c.teacher_id = t.id " +
                        "JOIN tb_student stu ON ss.student_id = stu.id " +
                        "WHERE stu.user_id = ? AND ss.status = 0", studentId);
                    return objectMapper.writeValueAsString(courses);
                }
                case "getStudentScores": {
                    Long studentId = args.path("studentId").asLong();
                    List<Map<String, Object>> scores = jdbcTemplate.queryForList(
                        "SELECT c.course_name, s.score " +
                        "FROM tb_score s " +
                        "JOIN tb_course c ON s.course_id = c.id " +
                        "JOIN tb_student stu ON s.student_id = stu.id " +
                        "WHERE stu.user_id = ? " +
                        "ORDER BY c.course_name", studentId);
                    return objectMapper.writeValueAsString(scores);
                }
                case "getCourseList": {
                    String college = args.has("college") && !args.path("college").isNull()
                            ? args.path("college").asText() : null;
                    List<Map<String, Object>> courses;
                    if (college != null && !college.isEmpty()) {
                        courses = jdbcTemplate.queryForList(
                            "SELECT course_name, college FROM tb_course WHERE college = ?", college);
                    } else {
                        courses = jdbcTemplate.queryForList(
                            "SELECT course_name, college FROM tb_course");
                    }
                    return objectMapper.writeValueAsString(courses);
                }
                case "getTeacherCourses": {
                    Long teacherId = args.path("teacherId").asLong();
                    List<Map<String, Object>> courses = jdbcTemplate.queryForList(
                        "SELECT c.course_name " +
                        "FROM tb_course c " +
                        "JOIN tb_teacher t ON c.teacher_id = t.id " +
                        "WHERE t.user_id = ?", teacherId);
                    return objectMapper.writeValueAsString(courses);
                }
                default:
                    return "未知工具: " + toolName;

                case "getCourseAverageScores": {
                    List<Map<String, Object>> stats = jdbcTemplate.queryForList(
                        "SELECT c.course_name, " +
                        "ROUND(AVG(s.score),1) AS avg_score, " +
                        "MAX(s.score) AS max_score, " +
                        "MIN(s.score) AS min_score, " +
                        "COUNT(*) AS student_count " +
                        "FROM tb_score s " +
                        "JOIN tb_course c ON s.course_id = c.id " +
                        "WHERE s.score IS NOT NULL " +
                        "GROUP BY c.course_name " +
                        "ORDER BY avg_score DESC");
                    return objectMapper.writeValueAsString(stats);
                }
                case "getRiskStudents": {
                    String college = args.has("college") && !args.path("college").isNull()
                            ? args.path("college").asText() : null;
                    List<Map<String, Object>> list;
                    if (college != null && !college.isEmpty()) {
                        list = jdbcTemplate.queryForList(
                            "SELECT stu.student_name, c.course_name, s.score, stu.college " +
                            "FROM tb_score s " +
                            "JOIN tb_course c ON s.course_id = c.id " +
                            "JOIN tb_student stu ON s.student_id = stu.id " +
                            "WHERE s.score < 60 AND s.score IS NOT NULL AND stu.college = ? " +
                            "ORDER BY s.score ASC", college);
                    } else {
                        list = jdbcTemplate.queryForList(
                            "SELECT stu.student_name, c.course_name, s.score, stu.college " +
                            "FROM tb_score s " +
                            "JOIN tb_course c ON s.course_id = c.id " +
                            "JOIN tb_student stu ON s.student_id = stu.id " +
                            "WHERE s.score < 60 AND s.score IS NOT NULL " +
                            "ORDER BY s.score ASC");
                    }
                    return objectMapper.writeValueAsString(list);
                }
                case "getSelectionExceptions": {
                    Long exceptionType = args.has("exceptionType") && !args.path("exceptionType").isNull()
                            ? args.path("exceptionType").asLong() : null;
                    List<Map<String, Object>> list;
                    if (exceptionType != null) {
                        list = jdbcTemplate.queryForList(
                            "SELECT stu.student_name, c.course_name, e.exception_type, e.create_time " +
                            "FROM tb_selection_exception e " +
                            "JOIN tb_course c ON e.course_id = c.id " +
                            "JOIN tb_student stu ON e.student_id = stu.id " +
                            "WHERE e.exception_type = ? " +
                            "ORDER BY e.create_time DESC", exceptionType);
                    } else {
                        list = jdbcTemplate.queryForList(
                            "SELECT stu.student_name, c.course_name, e.exception_type, e.create_time " +
                            "FROM tb_selection_exception e " +
                            "JOIN tb_course c ON e.course_id = c.id " +
                            "JOIN tb_student stu ON e.student_id = stu.id " +
                            "ORDER BY e.create_time DESC");
                    }
                    return objectMapper.writeValueAsString(list);
                }
                case "getCourseScoreDistribution": {
                    String courseName = args.path("courseName").asText();
                    List<Map<String, Object>> distribution = jdbcTemplate.queryForList(
                        "SELECT c.course_name, " +
                        "COUNT(*) AS total, " +
                        "ROUND(AVG(s.score),1) AS avg_score, " +
                        "MAX(s.score) AS max_score, " +
                        "MIN(s.score) AS min_score, " +
                        "SUM(CASE WHEN s.score >= 90 THEN 1 ELSE 0 END) AS excellent_90, " +
                        "SUM(CASE WHEN s.score >= 80 AND s.score < 90 THEN 1 ELSE 0 END) AS good_80, " +
                        "SUM(CASE WHEN s.score >= 70 AND s.score < 80 THEN 1 ELSE 0 END) AS medium_70, " +
                        "SUM(CASE WHEN s.score >= 60 AND s.score < 70 THEN 1 ELSE 0 END) AS pass_60, " +
                        "SUM(CASE WHEN s.score < 60 THEN 1 ELSE 0 END) AS fail_below60 " +
                        "FROM tb_score s " +
                        "JOIN tb_course c ON s.course_id = c.id " +
                        "WHERE c.course_name = ? AND s.score IS NOT NULL " +
                        "GROUP BY c.course_name", courseName);
                    return objectMapper.writeValueAsString(distribution);
                }
                case "getCollegeStats": {
                    List<Map<String, Object>> stats = jdbcTemplate.queryForList(
                        "SELECT stu.college, " +
                        "COUNT(DISTINCT s.student_id) AS student_count, " +
                        "ROUND(AVG(s.score),1) AS avg_score, " +
                        "SUM(CASE WHEN s.score < 60 THEN 1 ELSE 0 END) AS fail_count " +
                        "FROM tb_score s " +
                        "JOIN tb_student stu ON s.student_id = stu.id " +
                        "WHERE s.score IS NOT NULL " +
                        "GROUP BY stu.college " +
                        "ORDER BY avg_score DESC");
                    return objectMapper.writeValueAsString(stats);
                }
            }
        } catch (Exception e) {
            log.error("工具执行失败: {}", toolName, e);
            return "查询失败: " + e.getMessage();
        }
    }
}
