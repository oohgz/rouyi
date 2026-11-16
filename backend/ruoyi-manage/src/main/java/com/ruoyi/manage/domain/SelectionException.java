package com.ruoyi.manage.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 选课异常记录对象 tb_selection_exception
 * 
 * @author hgz
 * @date 2025-10-22
 */
public class SelectionException extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 课程名称 */
    private String courseName;

    /** 学生名称 */
    private String studentName;

    /** 学院 */
    private String college;

    /** 班级 */
    private String className;

    /** 年级 */
    private String grade;

    public String getCollege() { return college; }
    public void setCollege(String college) { this.college = college; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    // 生成 getter 和 setter 方法
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

    /** 异常ID（主键） */
    private Long id;

    /** 课程ID（关联tb_course.id） */
    @Excel(name = "课程ID", readConverterExp = "关=联tb_course.id")
    private Long courseId;

    /** 学生ID（关联tb_student.id） */
    @Excel(name = "学生ID", readConverterExp = "关=联tb_student.id")
    private Long studentId;

    /** 异常类型（1-重复选课，2-超员选课） */
    @Excel(name = "异常类型", readConverterExp = "1=-重复选课，2-超员选课")
    private Long exceptionType;

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

    public void setExceptionType(Long exceptionType) 
    {
        this.exceptionType = exceptionType;
    }

    public Long getExceptionType() 
    {
        return exceptionType;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("courseId", getCourseId())
            .append("studentId", getStudentId())
            .append("exceptionType", getExceptionType())
            .append("createTime", getCreateTime())
            .toString();
    }
}
