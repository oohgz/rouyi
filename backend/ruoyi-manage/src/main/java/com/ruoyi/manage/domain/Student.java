package com.ruoyi.manage.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生信息（学生个人信息）对象 tb_student
 * 
 * @author hgz
 * @date 2025-10-22
 */
public class Student extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 学生ID（主键） */
    private Long id;

    /** 学号（如S2023001） */
    @Excel(name = "学号", readConverterExp = "如=S2023001")
    private String studentNo;

    /** 学生姓名 */
    @Excel(name = "学生姓名")
    private String studentName;

    /** 关联系统用户ID（对应sys_user.id） */
    private Long userId;  // 新增：关联系统用户的ID

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setStudentNo(String studentNo) 
    {
        this.studentNo = studentNo;
    }

    public String getStudentNo() 
    {
        return studentNo;
    }

    public void setStudentName(String studentName) 
    {
        this.studentName = studentName;
    }

    public String getStudentName() 
    {
        return studentName;
    }

    // 新增：userId的getter和setter
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("studentNo", getStudentNo())
            .append("studentName", getStudentName())
            .append("userId", getUserId())  // 新增：打印userId
            .toString();
    }
}
