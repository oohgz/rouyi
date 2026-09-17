package com.ruoyi.manage.service.impl;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collections;
import java.util.List;


import com.ruoyi.manage.domain.Teacher;
import com.ruoyi.manage.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.manage.mapper.CourseMapper;
import com.ruoyi.manage.domain.Course;
import com.ruoyi.manage.service.ICourseService;

/**
 * 课程信息Service业务层处理
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Service
public class CourseServiceImpl implements ICourseService 
{
    @Autowired
    private CourseMapper courseMapper;
    // 新增注入：用于通过教师用户ID查询教师信息
    @Autowired
    private TeacherMapper teacherMapper;

    /**
     * 新增方法：根据教师用户ID查询其教授的课程
     */
    @Override
    public List<Course> selectCourseByTeacherUserId(Long teacherUserId) {
        // 1. 通过教师的用户ID，查询教师表中的教师信息（获取教师ID）
        Teacher teacher = teacherMapper.selectTeacherByUserId(teacherUserId);
        if (teacher == null) {
            return Collections.emptyList(); // 未关联教师信息，返回空列表
        }
        // 2. 根据教师ID查询课程（课程表的teacher_id字段关联教师ID）
        Course queryCondition = new Course();
        queryCondition.setTeacherId(teacher.getId()); // 设置查询条件：教师ID
        return courseMapper.selectCourseList(queryCondition);
    }

    /**
     * 查询课程信息
     * 
     * @param id 课程信息主键
     * @return 课程信息
     */
    @Override
    public Course selectCourseById(Long id)
    {
        return courseMapper.selectCourseById(id);
    }

    /**
     * 查询课程信息列表
     * 
     * @param course 课程信息
     * @return 课程信息
     */
    @Override
    public List<Course> selectCourseList(Course course)
    {
        return courseMapper.selectCourseList(course);
    }

    /**
     * 新增课程信息
     * 
     * @param course 课程信息
     * @return 结果
     */
    @Override
    public int insertCourse(Course course)
    {
        try {
            // 尝试插入课程
            return courseMapper.insertCourse(course);
        } catch (Exception e) {
            // 捕获“课程编码重复”的唯一约束异常
            if (e.getCause() instanceof SQLIntegrityConstraintViolationException) {
                SQLIntegrityConstraintViolationException sqlEx =
                        (SQLIntegrityConstraintViolationException) e.getCause();
                if (sqlEx.getMessage().contains("tb_course.course_code")) {
                    // 课程编码重复：无需插入 tb_selection_exception（因无有效 courseId）
                    // 直接返回 -3 告知前端即可
                    return -3;
                }
            }
            // 其他异常（如外键冲突）仍抛出
            throw e;
        }
    }

    /**
     * 修改课程信息
     * 
     * @param course 课程信息
     * @return 结果
     */
    @Override
    public int updateCourse(Course course)
    {
        return courseMapper.updateCourse(course);
    }

    /**
     * 批量删除课程信息
     * 
     * @param ids 需要删除的课程信息主键
     * @return 结果
     */
    @Override
    public int deleteCourseByIds(Long[] ids)
    {
        return courseMapper.deleteCourseByIds(ids);
    }

    /**
     * 删除课程信息信息
     * 
     * @param id 课程信息主键
     * @return 结果
     */
    @Override
    public int deleteCourseById(Long id)
    {
        return courseMapper.deleteCourseById(id);
    }
}
