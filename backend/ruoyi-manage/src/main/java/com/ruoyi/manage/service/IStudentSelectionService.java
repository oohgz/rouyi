package com.ruoyi.manage.service;

import java.util.List;
import com.ruoyi.manage.domain.StudentSelection;

/**
 * 学生选课Service接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
public interface IStudentSelectionService 
{
    /**
     * 查询学生选课
     * 
     * @param id 学生选课主键
     * @return 学生选课
     */
    public StudentSelection selectStudentSelectionById(Long id);

    /**
     * 查询学生选课列表
     * 
     * @param studentSelection 学生选课
     * @return 学生选课集合
     */
    public List<StudentSelection> selectStudentSelectionList(StudentSelection studentSelection);

    /**
     * 新增学生选课
     * 
     * @param studentSelection 学生选课
     * @return 结果
     */
    public int insertStudentSelection(StudentSelection studentSelection);

    /**
     * 修改学生选课
     * 
     * @param studentSelection 学生选课
     * @return 结果
     */
    public int updateStudentSelection(StudentSelection studentSelection);

    /**
     * 批量删除学生选课
     * 
     * @param ids 需要删除的学生选课主键集合
     * @return 结果
     */
    public int deleteStudentSelectionByIds(Long[] ids);

    /**
     * 删除学生选课信息
     * 
     * @param id 学生选课主键
     * @return 结果
     */
    public int deleteStudentSelectionById(Long id);
}
