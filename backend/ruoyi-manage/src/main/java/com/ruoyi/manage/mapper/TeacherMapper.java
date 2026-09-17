package com.ruoyi.manage.mapper;

import java.util.List;
import com.ruoyi.manage.domain.Teacher;
import org.apache.ibatis.annotations.Mapper;

/**
 * 教师信息Mapper接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Mapper
public interface TeacherMapper 
{
    Teacher selectTeacherByUserId(Long userId);

    /**
     * 查询教师信息
     * 
     * @param id 教师信息主键
     * @return 教师信息
     */
    public Teacher selectTeacherById(Long id);

    /**
     * 查询教师信息列表
     * 
     * @param teacher 教师信息
     * @return 教师信息集合
     */
    public List<Teacher> selectTeacherList(Teacher teacher);

    /**
     * 新增教师信息
     * 
     * @param teacher 教师信息
     * @return 结果
     */
    public int insertTeacher(Teacher teacher);

    /**
     * 修改教师信息
     * 
     * @param teacher 教师信息
     * @return 结果
     */
    public int updateTeacher(Teacher teacher);

    /**
     * 删除教师信息
     * 
     * @param id 教师信息主键
     * @return 结果
     */
    public int deleteTeacherById(Long id);

    /**
     * 批量删除教师信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTeacherByIds(Long[] ids);
}
