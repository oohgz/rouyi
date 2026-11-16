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
    @Excel(name = "学号")
    private String studentNo;

    /** 学生姓名 */
    @Excel(name = "学生姓名")
    private String studentName;

    /** 性别 */
    @Excel(name = "性别")
    private String gender;

    /** 手机号 */
    @Excel(name = "手机号")
    private String phone;

    /** 专业 */
    @Excel(name = "专业")
    private String major;

    /** 学院 */
    @Excel(name = "学院")
    private String college;

    /** 班级 */
    @Excel(name = "班级")
    private String className;

    /** 年级（如2023） */
    @Excel(name = "年级")
    private String grade;

    /** 关联系统用户ID（对应sys_user.id） */
    private Long userId;

    /** 教师角色：只查选了自己课程的学生ID列表 */
    private java.util.List<Long> studentIds;

    public java.util.List<Long> getStudentIds() { return studentIds; }
    public void setStudentIds(java.util.List<Long> studentIds) { this.studentIds = studentIds; }

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

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getMajor() { return major; }
    public void setMajor(String major) { this.major = major; }

    public String getCollege() { return college; }
    public void setCollege(String college) { this.college = college; }

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    public void setUserId(Long userId) { this.userId = userId; }
    public Long getUserId() { return userId; }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("studentNo", getStudentNo())
            .append("studentName", getStudentName())
            .append("gender", getGender())
            .append("phone", getPhone())
            .append("major", getMajor())
            .append("college", getCollege())
            .append("className", getClassName())
            .append("grade", getGrade())
            .append("userId", getUserId())
            .toString();
    }
}
