package com.ruoyi.manage.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教师信息对象 tb_teacher
 * 
 * @author hgz
 * @date 2025-10-22
 */
public class Teacher extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教师ID（主键） */
    private Long id;

    /** 教师工号（如T001） */
    @Excel(name = "教师工号", readConverterExp = "如=T001")
    private String teacherNo;

    /** 教师姓名 */
    @Excel(name = "教师姓名")
    private String teacherName;

    /** 职称（如教授/讲师） */
    @Excel(name = "职称", readConverterExp = "如=教授/讲师")
    private String title;

    private Long userId; // 新增字段

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setTeacherNo(String teacherNo) 
    {
        this.teacherNo = teacherNo;
    }

    public String getTeacherNo() 
    {
        return teacherNo;
    }

    public void setTeacherName(String teacherName) 
    {
        this.teacherName = teacherName;
    }

    public String getTeacherName() 
    {
        return teacherName;
    }

    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }

    // 新增getter/setter
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("teacherNo", getTeacherNo())
            .append("teacherName", getTeacherName())
            .append("title", getTitle())
            .toString();
    }
}
