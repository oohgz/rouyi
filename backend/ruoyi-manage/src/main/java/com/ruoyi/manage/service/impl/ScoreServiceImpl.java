package com.ruoyi.manage.service.impl;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.exception.ServiceException; // 用于权限异常提示
import com.ruoyi.manage.domain.Course;
import com.ruoyi.manage.domain.Student;
import com.ruoyi.manage.domain.Teacher;
import com.ruoyi.manage.mapper.CourseMapper;
import com.ruoyi.manage.mapper.StudentMapper;
import com.ruoyi.manage.mapper.TeacherMapper;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.manage.mapper.ScoreMapper;
import com.ruoyi.manage.domain.Score;
import com.ruoyi.manage.service.IScoreService;

/**
 * 学生成绩Service业务层处理
 *
 * @author hgz
 * @date 2025-10-22
 */
@Service
public class ScoreServiceImpl implements IScoreService
{
    @Autowired
    private ScoreMapper scoreMapper;

    // 新增依赖：用于关联用户与学生/教师信息、查询课程
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private ISysUserService sysUserService;

    /**
     * 查询单个成绩（加权限校验：学生只能看自己的，教师只能看自己课程的）
     */
    @Override
    public Score selectScoreById(Long id)
    {
        // 1. 获取当前登录用户信息
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long currentUserId = loginUser.getUserId();
        List<String> roles = sysUserService.selectRoleKeysByUserId(currentUserId);

        // 2. 查询目标成绩信息
        Score targetScore = scoreMapper.selectScoreById(id);
        if (targetScore == null) {
            return null; // 成绩不存在
        }

        // 3. 学生角色：只能查看自己的成绩
        if (roles.contains("student")) {
            // 通过当前用户ID查询对应的学生信息
            Student currentStudent = studentMapper.selectStudentByUserId(currentUserId);
            if (currentStudent == null) {
                throw new ServiceException("当前用户未关联学生信息");
            }
            // 校验：目标成绩的studentId必须等于当前学生的ID
            if (!targetScore.getStudentId().equals(currentStudent.getId())) {
                throw new ServiceException("无权查看该成绩");
            }
        }
        // 4. 教师角色：只能查看自己课程的成绩
        else if (roles.contains("teacher")) {
            // 通过当前用户ID查询对应的教师信息
            Teacher currentTeacher = teacherMapper.selectTeacherByUserId(currentUserId);
            if (currentTeacher == null) {
                throw new ServiceException("当前用户未关联教师信息");
            }
            // 查询该教师的所有课程ID
            Course courseQuery = new Course();
            courseQuery.setTeacherId(currentTeacher.getId()); // 教师ID关联课程
            List<Course> teacherCourses = courseMapper.selectCourseList(courseQuery);
            List<Long> teacherCourseIds = teacherCourses.stream()
                    .map(Course::getId)
                    .collect(Collectors.toList());
            // 校验：目标成绩的courseId必须在教师的课程ID列表中
            if (!teacherCourseIds.contains(targetScore.getCourseId())) {
                throw new ServiceException("无权查看该成绩");
            }
        }
        // 5. 管理员角色：无限制（直接返回）

        return targetScore;
    }

    /**
     * 查询成绩列表（加角色过滤：学生只看自己的，教师只看自己课程的）
     */
    @Override
    public List<Score> selectScoreList(Score score)
    {
        // 1. 获取当前登录用户信息
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long currentUserId = loginUser.getUserId();
        List<String> roles = sysUserService.selectRoleKeysByUserId(currentUserId);

        // 2. 学生角色：过滤自己的成绩（设置studentId）
        if (roles.contains("student")) {
            Student currentStudent = studentMapper.selectStudentByUserId(currentUserId);
            if (currentStudent != null) {
                score.setStudentId(currentStudent.getId()); // 强制过滤：只查自己的成绩
            }
        }
        // 3. 教师角色：过滤自己课程的成绩（设置courseIds列表）
        else if (roles.contains("teacher")) {
            Teacher currentTeacher = teacherMapper.selectTeacherByUserId(currentUserId);
            if (currentTeacher != null) {
                // 查询教师的所有课程ID
                Course courseQuery = new Course();
                courseQuery.setTeacherId(currentTeacher.getId());
                List<Course> teacherCourses = courseMapper.selectCourseList(courseQuery);
                List<Long> teacherCourseIds = teacherCourses.stream()
                        .map(Course::getId)
                        .collect(Collectors.toList());
                score.setCourseIds(teacherCourseIds); // 强制过滤：只查自己课程的成绩
            }
        }
        // 4. 管理员角色：无过滤（不设置条件）

        return scoreMapper.selectScoreList(score);
    }

    // 以下新增、修改、删除方法无需修改（若需限制权限，可参考上述逻辑补充校验）
    @Override
    public int insertScore(Score score)
    {
        try {
            // 尝试插入成绩
            return scoreMapper.insertScore(score);
        } catch (RuntimeException e) {
            // 遍历异常链，查找唯一约束异常
            Throwable cause = e;
            while (cause != null) {
                if (cause instanceof SQLIntegrityConstraintViolationException) {
                    SQLIntegrityConstraintViolationException sqlEx =
                            (SQLIntegrityConstraintViolationException) cause;
                    // 匹配“course_id+student_id”组合的唯一约束（uk_course_student）
                    if (sqlEx.getMessage().contains("uk_course_student")) {
                        return -6; // 返回-6标识“该学生在该课程中已有成绩”
                    }
                }
                cause = cause.getCause();
            }
            // 非重复异常，继续抛出
            throw e;
        }
    }

    @Override
    public int updateScore(Score score)
    {
        return scoreMapper.updateScore(score);
    }

    @Override
    public int deleteScoreByIds(Long[] ids)
    {
        return scoreMapper.deleteScoreByIds(ids);
    }

    @Override
    public int deleteScoreById(Long id)
    {
        return scoreMapper.deleteScoreById(id);
    }

    // 新增：统计成绩分布（用于ECharts）
    @Override
    public Map<String, Integer> getScoreDistribution() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long currentUserId = loginUser.getUserId();
        List<String> roles = sysUserService.selectRoleKeysByUserId(currentUserId);

        Score scoreQuery = new Score();
        // 教师角色：仅统计自己课程的成绩
        if (roles.contains("teacher")) {
            Teacher teacher = teacherMapper.selectTeacherByUserId(currentUserId);
            if (teacher != null) {
                // 复用已有逻辑：查询教师的课程ID列表
                Course courseQuery = new Course();
                courseQuery.setTeacherId(teacher.getId());
                List<Course> courses = courseMapper.selectCourseList(courseQuery);
                List<Long> courseIds = courses.stream().map(Course::getId).collect(Collectors.toList());
                scoreQuery.setCourseIds(courseIds);
            }
        }
        // 管理员：统计所有成绩；学生：不开放此功能（图表不显示）

        // 调用Mapper统计数据
        List<Map<String, Object>> statList = scoreMapper.statScoreDistribution(scoreQuery);

        // 初始化分数段（确保无数据的分数段也显示，图表更完整）
        Map<String, Integer> result = new LinkedHashMap<>();
        result.put("0-60分", 0);
        result.put("60-70分", 0);
        result.put("70-80分", 0);
        result.put("80-90分", 0);
        result.put("90-100分", 0);

        // 填充统计结果
        for (Map<String, Object> map : statList) {
            String range = (String) map.get("score_range");
            Integer count = Integer.parseInt(map.get("student_count").toString());
            result.put(range, count);
        }
        return result;
    }

}