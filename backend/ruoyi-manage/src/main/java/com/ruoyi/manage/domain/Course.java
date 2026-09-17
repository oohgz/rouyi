package com.ruoyi.manage.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 课程信息对象 tb_course
 * 
 * @author hgz
 * @date 2025-10-22
 */
public class Course extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 课程ID（主键） */
    private Long id;

    // 新增：授课教师名称（关联tb_teacher的teacher_name）
    private String teacherName;

    // getter和setter
    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    /** 课程编码（如JSJ001） */
    @Excel(name = "课程编码", readConverterExp = "如=JSJ001")
    private String courseCode;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String courseName;

    /** 授课教师ID（关联tb_teacher.id） */
    @Excel(name = "授课教师ID", readConverterExp = "关=联tb_teacher.id")
    private Long teacherId;

    /** 最大选课人数 */
    @Excel(name = "最大选课人数")
    private Long maxStudents;

    /** 状态（0-正常，1-停用） */
    @Excel(name = "状态", readConverterExp = "0=-正常，1-停用")
    private Long status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setCourseCode(String courseCode) 
    {
        this.courseCode = courseCode;
    }

    public String getCourseCode() 
    {
        return courseCode;
    }

    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }

    public void setTeacherId(Long teacherId) 
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId() 
    {
        return teacherId;
    }

    public void setMaxStudents(Long maxStudents) 
    {
        this.maxStudents = maxStudents;
    }

    public Long getMaxStudents() 
    {
        return maxStudents;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("courseCode", getCourseCode())
            .append("courseName", getCourseName())
            .append("teacherId", getTeacherId())
            .append("maxStudents", getMaxStudents())
            .append("status", getStatus())
            .toString();
    }
}
