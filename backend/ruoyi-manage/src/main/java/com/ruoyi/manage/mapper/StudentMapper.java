package com.ruoyi.manage.mapper;

import java.util.List;
import com.ruoyi.manage.domain.Student;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 学生信息（学生个人信息）Mapper接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Mapper
public interface StudentMapper 
{
    /**
     * 新增方法：根据多个学生ID查询学生详情（供下拉框显示）
     * @param studentIds 学生ID列表
     * @return 学生列表（包含id、studentName等字段）
     */
    List<Student> selectStudentsByIds(@Param("studentIds") List<Long> studentIds);

    Student selectStudentByUserId(Long userId);

    /**
     * 查询学生信息（学生个人信息）
     * 
     * @param id 学生信息（学生个人信息）主键
     * @return 学生信息（学生个人信息）
     */
    public Student selectStudentById(Long id);

    /**
     * 查询学生信息（学生个人信息）列表
     * 
     * @param student 学生信息（学生个人信息）
     * @return 学生信息（学生个人信息）集合
     */
    public List<Student> selectStudentList(Student student);

    /**
     * 新增学生信息（学生个人信息）
     * 
     * @param student 学生信息（学生个人信息）
     * @return 结果
     */
    public int insertStudent(Student student);

    /**
     * 修改学生信息（学生个人信息）
     * 
     * @param student 学生信息（学生个人信息）
     * @return 结果
     */
    public int updateStudent(Student student);

    /**
     * 删除学生信息（学生个人信息）
     * 
     * @param id 学生信息（学生个人信息）主键
     * @return 结果
     */
    public int deleteStudentById(Long id);

    /**
     * 批量删除学生信息（学生个人信息）
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteStudentByIds(Long[] ids);
}
