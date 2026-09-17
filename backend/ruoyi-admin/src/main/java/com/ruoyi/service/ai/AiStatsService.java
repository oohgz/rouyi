package com.ruoyi.service.ai;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.ruoyi.manage.domain.Course;
import com.ruoyi.manage.domain.Student;
import com.ruoyi.manage.domain.Score;
import com.ruoyi.manage.mapper.CourseMapper;
import com.ruoyi.manage.mapper.ScoreMapper;
import com.ruoyi.manage.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * AI学情分析服务（真实数据库查询）
 * 提供基于实际数据的系统概览、成绩分析和预警功能
 *
 * @author ruoyi
 */
@Service
public class AiStatsService
{
    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private ScoreMapper scoreMapper;

    @Autowired
    private StudentMapper studentMapper;

    /**
     * 获取系统概览数据
     */
    public Map<String, Object> getSystemOverview()
    {
        Map<String, Object> result = new HashMap<>();

        // 课程总数
        List<Course> allCourses = courseMapper.selectCourseList(new Course());
        int totalCourses = allCourses.size();
        result.put("totalCourses", totalCourses);

        // 学生总数
        List<Student> allStudents = studentMapper.selectStudentList(new Student());
        int totalStudents = allStudents.size();
        result.put("totalStudents", totalStudents);

        // 成绩记录总数和平均成绩
        List<Score> allScores = scoreMapper.selectScoreList(new Score());
        int totalScores = allScores.size();
        result.put("totalScores", totalScores);

        BigDecimal avgScore = BigDecimal.ZERO;
        if (!allScores.isEmpty()) {
            BigDecimal sum = allScores.stream()
                    .map(Score::getScore)
                    .filter(s -> s != null)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            long count = allScores.stream().filter(s -> s != null).count();
            if (count > 0) {
                avgScore = sum.divide(BigDecimal.valueOf(count), 2, BigDecimal.ROUND_HALF_UP);
            }
        }
        result.put("avgScore", avgScore.toString());

        return result;
    }

    /**
     * 获取成绩分布统计
     */
    public List<Map<String, Object>> getGradeDistribution()
    {
        Score queryParam = new Score();
        List<Map<String, Object>> distribution = scoreMapper.statScoreDistribution(queryParam);

        // 确保所有分数段都存在
        List<Map<String, Object>> complete = new ArrayList<>();
        String[] ranges = {"0-60分", "60-70分", "70-80分", "80-90分", "90-100分"};
        Map<String, Integer> rangeMap = new HashMap<>();
        for (Map<String, Object> item : distribution) {
            rangeMap.put((String) item.get("score_range"),
                         ((Number) item.get("student_count")).intValue());
        }
        for (String range : ranges) {
            Map<String, Object> entry = new HashMap<>();
            entry.put("score_range", range);
            entry.put("student_count", rangeMap.getOrDefault(range, 0));
            complete.add(entry);
        }
        return complete;
    }

    /**
     * 获取课程热门度排行
     */
    public List<Map<String, Object>> getCoursePopularity()
    {
        List<Course> courses = courseMapper.selectCourseList(new Course());
        List<Map<String, Object>> ranked = new ArrayList<>();

        for (int i = 0; i < courses.size(); i++) {
            Course course = courses.get(i);
            Map<String, Object> info = new HashMap<>();
            info.put("courseName", course.getCourseName());
            info.put("courseCode", course.getCourseCode());
            info.put("maxStudents", course.getMaxStudents());
            info.put("teacherName", course.getTeacherName());
            info.put("rank", i + 1);

            // 计算选课人数（从成绩表中统计该课程的已有成绩数）
            Score scoreQuery = new Score();
            List<Score> scores = scoreMapper.selectScoreList(scoreQuery);
            long enrolled = scores.stream().filter(s -> s.getCourseId().equals(course.getId())).count();
            info.put("enrolled", enrolled);

            // 计算该课程平均分
            List<Score> courseScores = scores.stream()
                    .filter(s -> s.getCourseId().equals(course.getId()) && s.getScore() != null)
                    .collect(Collectors.toList());
            if (!courseScores.isEmpty()) {
                BigDecimal sum = courseScores.stream()
                        .map(Score::getScore)
                        .reduce(BigDecimal.ZERO, BigDecimal::add);
                double avg = sum.divide(BigDecimal.valueOf(courseScores.size()), 2, BigDecimal.ROUND_HALF_UP)
                        .doubleValue();
                info.put("avgScore", Math.round(avg * 100.0) / 100.0);
            } else {
                info.put("avgScore", "-");
            }

            ranked.add(info);
        }

        return ranked;
    }

    /**
     * 获取学习预警学生列表
     */
    public List<Map<String, Object>> getRiskAlerts()
    {
        List<Score> allScores = scoreMapper.selectScoreList(new Score());
        Map<Long, List<Score>> scoresByStudent = new HashMap<>();
        for (Score s : allScores) {
            if (s.getScore() != null) {
                scoresByStudent.computeIfAbsent(s.getStudentId(), k -> new ArrayList<>()).add(s);
            }
        }

        List<Map<String, Object>> alerts = new ArrayList<>();
        for (Map.Entry<Long, List<Score>> entry : scoresByStudent.entrySet()) {
            List<Score> scores = entry.getValue();
            if (scores.size() < 2) continue; // 至少2门课才有意义

            BigDecimal sum = scores.stream()
                    .map(Score::getScore)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            double avg = sum.divide(BigDecimal.valueOf(scores.size()), 2, BigDecimal.ROUND_HALF_UP)
                    .doubleValue();

            if (avg < 70) {
                int failCount = (int) scores.stream()
                        .filter(s -> s.getScore().doubleValue() < 60)
                        .count();
                Map<String, Object> alert = new HashMap<>();
                alert.put("studentId", entry.getKey());
                alert.put("avgScore", Math.round(avg * 100.0) / 100.0);
                alert.put("failCount", failCount);
                alert.put("courseCount", scores.size());
                alert.put("level", avg < 60 ? "严重" : "一般");
                alerts.add(alert);
            }
        }

        // 按平均分升序排序
        alerts.sort((a, b) -> Double.compare(
                ((Number) a.get("avgScore")).doubleValue(),
                ((Number) b.get("avgScore")).doubleValue()));

        return alerts;
    }
}
