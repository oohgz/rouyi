package com.ruoyi.manage.service.impl;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.manage.mapper.TeacherMapper;
import com.ruoyi.manage.domain.Teacher;
import com.ruoyi.manage.service.ITeacherService;
import com.ruoyi.system.service.ISysUserService;
/**
 * 教师信息Service业务层处理
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Service
public class TeacherServiceImpl implements ITeacherService 
{
    @Autowired
    private ISysUserService sysUserService; // 关键：注入系统用户服务，与StudentServiceImpl保持一致
    @Autowired
    private TeacherMapper teacherMapper;

    /**
     * 查询教师信息
     * 
     * @param id 教师信息主键
     * @return 教师信息
     */
    @Override
    public Teacher selectTeacherById(Long id)
    {
        return teacherMapper.selectTeacherById(id);
    }

    /**
     * 查询教师信息列表
     * 
     * @param teacher 教师信息
     * @return 教师信息
     */
    @Override
    public List<Teacher> selectTeacherList(Teacher teacher)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long currentUserId = loginUser.getUserId();
        List<String> roles = sysUserService.selectRoleKeysByUserId(currentUserId);

        // 教师角色：只能看自己的信息
        if (roles.contains("teacher")) {
            teacher.setUserId(currentUserId); // 强制过滤当前用户的userId
        }
        // 管理员：可查看所有

        // 角色查询消耗了 Controller 的 startPage()，这里重新启动分页
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        if (pageNum != null && pageSize != null) {
            PageHelper.startPage(pageNum, pageSize);
        }

        return teacherMapper.selectTeacherList(teacher);
    }

    /**
     * 新增教师信息
     * 
     * @param teacher 教师信息
     * @return 结果
     */
    @Override
    public int insertTeacher(Teacher teacher)
    {
        try {
            return teacherMapper.insertTeacher(teacher);
        } catch (RuntimeException e) {
            Throwable cause = e;
            while (cause != null) {
                System.out.println("异常类型：" + cause.getClass().getName());
                System.out.println("异常消息：" + cause.getMessage());
                if (cause instanceof SQLIntegrityConstraintViolationException) {
                    SQLIntegrityConstraintViolationException sqlEx = (SQLIntegrityConstraintViolationException) cause;
                    if (sqlEx.getMessage().contains("tb_teacher.teacher_no")) {
                        System.out.println("命中工号重复分支，返回-5");
                        return -5;
                    }
                }
                cause = cause.getCause();
            }
            throw e;
        }
    }

    /**
     * 修改教师信息
     * 
     * @param teacher 教师信息
     * @return 结果
     */
    @Override
    public int updateTeacher(Teacher teacher)
    {
        return teacherMapper.updateTeacher(teacher);
    }

    /**
     * 批量删除教师信息
     * 
     * @param ids 需要删除的教师信息主键
     * @return 结果
     */
    @Override
    public int deleteTeacherByIds(Long[] ids)
    {
        return teacherMapper.deleteTeacherByIds(ids);
    }

    /**
     * 删除教师信息信息
     * 
     * @param id 教师信息主键
     * @return 结果
     */
    @Override
    public int deleteTeacherById(Long id)
    {
        return teacherMapper.deleteTeacherById(id);
    }
}
