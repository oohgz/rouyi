package com.ruoyi.manage.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import java.util.List;

/**
 * 学生选课对象 tb_student_selection
 * 
 * @author hgz
 * @date 2025-10-22
 */
public class StudentSelection extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    /** 课程名称 */
    private String courseName;
    /** 学生名称 */
    private String studentName;
    /** 学院（关联学生表） */
    private String college;
    /** 班级（关联学生表） */
    private String className;
    /** 年级（关联学生表） */
    private String grade;

    /** 选课ID（主键） */
    private Long id;

    private List<Long> courseIds; // 用于教师角色：过滤自己授课的课程ID

    /** 课程ID（关联tb_course.id） */
    @Excel(name = "课程ID", readConverterExp = "关=联tb_course.id")
    private Long courseId;

    /** 学生ID（关联tb_student.id） */
    @Excel(name = "学生ID", readConverterExp = "关=联tb_student.id")
    private Long studentId;

    /** 状态（0-已选，1-已退） */
    @Excel(name = "状态", readConverterExp = "0=-已选，1-已退")
    private Long status;

    /** 选课时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "选课时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date selectTime;

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

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setSelectTime(Date selectTime) 
    {
        this.selectTime = selectTime;
    }

    public Date getSelectTime() 
    {
        return selectTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("courseId", getCourseId())
            .append("studentId", getStudentId())
            .append("status", getStatus())
            .append("selectTime", getSelectTime())
            .toString();
    }

    // getter和setter
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

    public List<Long> getCourseIds() {
        return courseIds;
    }

    public void setCourseIds(List<Long> courseIds) {
        this.courseIds = courseIds;
    }
}
