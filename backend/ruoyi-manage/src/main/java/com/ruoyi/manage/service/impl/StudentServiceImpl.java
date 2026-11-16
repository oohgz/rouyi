package com.ruoyi.manage.service.impl;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collections;
import java.util.List;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.manage.mapper.StudentSelectionMapper;
import com.ruoyi.system.service.ISysUserService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.manage.mapper.StudentMapper;
import com.ruoyi.manage.domain.Student;
import com.ruoyi.manage.service.IStudentService;

/**
 * 学生信息（学生个人信息）Service业务层处理
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Service
public class StudentServiceImpl implements IStudentService 
{
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private ISysUserService sysUserService;
    // 新增注入：学生选课表Mapper（用于关联课程和学生）
    @Autowired
    private StudentSelectionMapper studentSelectionMapper;

    /**
     * 新增实现：根据课程ID查询选了该课程的学生
     */
    @Override
    public List<Student> selectStudentsByCourseId(Long courseId) {
        // 1. 从选课表查询：该课程下所有已选学生的ID（过滤已删除、无效状态）
        // 依赖 StudentSelectionMapper 新增的 selectStudentIdsByCourseId 方法
        List<Long> studentIds = studentSelectionMapper.selectStudentIdsByCourseId(courseId);

        // 2. 无学生选该课程，返回空列表（前端会提示“暂无学生选课”）
        if (studentIds == null || studentIds.isEmpty()) {
            return Collections.emptyList();
        }

        // 3. 根据学生ID列表，查询学生详情（姓名、ID等，供前端下拉框显示）
        // 依赖 StudentMapper 新增的 selectStudentsByIds 方法
        return studentMapper.selectStudentsByIds(studentIds);
    }

    /**
     * 查询学生信息（学生个人信息）
     * 
     * @param id 学生信息（学生个人信息）主键
     * @return 学生信息（学生个人信息）
     */
    @Override
    public Student selectStudentById(Long id)
    {
        // 1. 获取当前登录用户的ID和角色
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long currentUserId = loginUser.getUserId();
        List<String> roles = sysUserService.selectRoleKeysByUserId(currentUserId);

        // 2. 学生角色：只能查看自己的信息
        if (roles.contains("student")) {
            // 先查询目标学生信息
            Student targetStudent = studentMapper.selectStudentById(id);
            // 校验：目标学生不存在，或目标学生的userId != 当前用户ID → 无权查看
            if (targetStudent == null || !targetStudent.getUserId().equals(currentUserId)) {
                throw new ServiceException("无权查看该学生信息"); // 抛异常提示，也可返回null
            }
            return targetStudent;
        }

        // 3. 管理员/教师角色：直接查询（无限制）
        return studentMapper.selectStudentById(id);
    }

    /**
     * 查询学生信息（学生个人信息）列表
     * 
     * @param student 学生信息（学生个人信息）
     * @return 学生信息（学生个人信息）
     */
    @Override
    public List<Student> selectStudentList(Student student)
    {
        // 获取当前登录用户ID和角色
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long currentUserId = loginUser.getUserId();
        List<String> roles = sysUserService.selectRoleKeysByUserId(currentUserId);

        // 学生角色：只能看自己的信息（通过userId关联）
        if (roles.contains("student")) {
            student.setUserId(currentUserId); // 设置当前用户的userId，强制过滤
        }

        // 注意：上面 selectRoleKeysByUserId 这个查询会消耗掉 Controller 里 startPage() 设置的分页，
        // 所以这里必须在主查询之前重新启动分页，否则会返回全部数据不分页
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        if (pageNum != null && pageSize != null) {
            PageHelper.startPage(pageNum, pageSize);
        }

        return studentMapper.selectStudentList(student);
    }

    /**
     * 新增学生信息（学生个人信息）
     * 自动创建登录账号：用户名=学号，初始密码=123456，自动分配学生角色(role_id=101)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertStudent(Student student)
    {
        // 1. 先插入学生业务记录
        try {
            int rows = studentMapper.insertStudent(student);
            if (rows <= 0) {
                return 0;
            }
        } catch (Exception e) {
            if (e.getCause() instanceof SQLIntegrityConstraintViolationException) {
                SQLIntegrityConstraintViolationException sqlEx =
                        (SQLIntegrityConstraintViolationException) e.getCause();
                if (sqlEx.getMessage().contains("tb_student.student_no")) {
                    return -4; // 学号重复
                }
            }
            throw e;
        }

        // 2. 自动创建系统登录账号（用户名=学号，初始密码=123456）
        SysUser sysUser = new SysUser();
        sysUser.setUserName(student.getStudentNo());        // 登录名=学号
        sysUser.setNickName(student.getStudentName());      // 昵称=学生姓名
        sysUser.setPassword(SecurityUtils.encryptPassword("123456")); // 默认密码
        sysUser.setDeptId(1L);                               // 默认部门
        sysUser.setStatus("0");                              // 正常状态
        sysUser.setRoleIds(new Long[]{101L});                // 学生角色 role_id=101

        sysUserService.insertUser(sysUser);                  // 插入后自动回填 userId
        Long newUserId = sysUser.getUserId();

        // 3. 把新账号ID回写到 tb_student.user_id（绑定业务学生和登录账号）
        student.setUserId(newUserId);
        studentMapper.updateStudent(student);

        return 1;
    }

    /**
     * 修改学生信息（学生个人信息）
     * 
     * @param student 学生信息（学生个人信息）
     * @return 结果
     */
    @Override
    public int updateStudent(Student student)
    {
        return studentMapper.updateStudent(student);
    }

    /**
     * 批量删除学生信息（学生个人信息）
     * 
     * @param ids 需要删除的学生信息（学生个人信息）主键
     * @return 结果
     */
    @Override
    public int deleteStudentByIds(Long[] ids)
    {
        return studentMapper.deleteStudentByIds(ids);
    }

    /**
     * 删除学生信息（学生个人信息）信息
     * 
     * @param id 学生信息（学生个人信息）主键
     * @return 结果
     */
    @Override
    public int deleteStudentById(Long id)
    {
        return studentMapper.deleteStudentById(id);
    }
}
