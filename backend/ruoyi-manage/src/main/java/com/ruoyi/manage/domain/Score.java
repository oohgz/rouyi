package com.ruoyi.manage.domain;

import java.math.BigDecimal;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生成绩对象 tb_student_score
 *
 * @author hgz
 * @date 2025-10-22
 */

public class Score extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教师课程ID列表（非数据库字段，用于过滤） */
    private List<Long> courseIds;

    /** 成绩ID（主键） */
    private Long id;

    /** 课程ID（关联tb_course.id） */
    @Excel(name = "课程ID")
    private Long courseId;

    /** 学生ID（关联tb_student.id） */
    @Excel(name = "学生ID")
    private Long studentId;

    /** 成绩（如85.5，NULL表示未录入） */
    @Excel(name = "成绩")
    private BigDecimal score;

    /** 课程名称（非数据库字段，关联查询结果） */
    private String courseName;

    /** 学生名称（非数据库字段，关联查询结果） */
    private String studentName;

    /** 学院（非数据库字段，用于统计筛选） */
    private String college;

    /** 班级（非数据库字段，用于统计筛选） */
    private String className;

    /** 年级（非数据库字段，用于统计筛选） */
    private String grade;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }

    public void setCourseId(Long courseId)
    {
        this.courseId = courseId;
    }

    public Long getCourseId()
    {
        return courseId;
    }

    public void setStudentId(Long studentId)
    {
        this.studentId = studentId;
    }

    public Long getStudentId()
    {
        return studentId;
    }

    public void setScore(BigDecimal score)
    {
        this.score = score;
    }

    public BigDecimal getScore()
    {
        return score;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCollege() { return college; }
    public void setCollege(String college) { this.college = college; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    // getter/setter
    public List<Long> getCourseIds() {
        return courseIds;
    }
    public void setCourseIds(List<Long> courseIds) {
        this.courseIds = courseIds;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("courseId", getCourseId())
                .append("studentId", getStudentId())
                .append("score", getScore())
                .append("courseName", getCourseName())
                .append("studentName", getStudentName())
                .append("remark", getRemark())
                .toString();
    }
}