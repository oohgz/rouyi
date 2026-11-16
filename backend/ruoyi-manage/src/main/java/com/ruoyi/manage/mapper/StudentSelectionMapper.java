package com.ruoyi.manage.mapper;

import java.util.List;
import com.ruoyi.manage.domain.StudentSelection;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 学生选课Mapper接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Mapper
public interface StudentSelectionMapper 
{
    /**
     * 新增方法：查询某课程的所有已选学生ID（状态为0-已选，未删除）
     * @param courseId 课程ID
     * @return 学生ID列表
     */
    List<Long> selectStudentIdsByCourseId(@Param("courseId") Long courseId);

    /**
     * 查询多个课程的所有已选学生ID
     */
    List<Long> selectStudentIdsByCourseIds(@Param("courseIds") List<Long> courseIds);

    /**
     * 查询课程当前已选人数（状态为0-已选）
     */
    int countSelectedByCourseId(Long courseId);

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
     * 删除学生选课
     * 
     * @param id 学生选课主键
     * @return 结果
     */
    public int deleteStudentSelectionById(Long id);

    /**
     * 批量删除学生选课
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteStudentSelectionByIds(Long[] ids);

}
