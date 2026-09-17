package com.ruoyi.manage.service;

import java.util.List;
import com.ruoyi.manage.domain.Student;

/**
 * 学生信息（学生个人信息）Service接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
public interface IStudentService 
{
    /**
     * 新增方法：根据课程ID查询选了该课程的学生
     * @param courseId 课程ID
     * @return 选课学生列表
     */
    List<Student> selectStudentsByCourseId(Long courseId);

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
     * 批量删除学生信息（学生个人信息）
     * 
     * @param ids 需要删除的学生信息（学生个人信息）主键集合
     * @return 结果
     */
    public int deleteStudentByIds(Long[] ids);

    /**
     * 删除学生信息（学生个人信息）信息
     * 
     * @param id 学生信息（学生个人信息）主键
     * @return 结果
     */
    public int deleteStudentById(Long id);
}
