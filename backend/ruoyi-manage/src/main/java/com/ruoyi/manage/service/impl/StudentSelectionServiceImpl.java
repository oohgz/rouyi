package com.ruoyi.manage.service.impl;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 新增事务注解
import com.ruoyi.manage.mapper.StudentSelectionMapper;
import com.ruoyi.manage.domain.StudentSelection;
import com.ruoyi.manage.service.IStudentSelectionService;
import com.ruoyi.manage.mapper.StudentMapper;
import com.ruoyi.manage.mapper.TeacherMapper;
import com.ruoyi.manage.mapper.CourseMapper;
import com.ruoyi.manage.domain.Student;
import com.ruoyi.manage.domain.Teacher;
import com.ruoyi.manage.domain.Course;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.common.exception.ServiceException;
import com.github.pagehelper.PageHelper;
import com.ruoyi.manage.service.ISelectionExceptionService; // 新增导入
import com.ruoyi.manage.domain.SelectionException; // 新增导入
import java.sql.SQLIntegrityConstraintViolationException; // 新增导入
/**
 * 学生选课Service业务层处理
 *
 * @author hgz
 * @date 2025-10-22
 */
@Service
public class StudentSelectionServiceImpl implements IStudentSelectionService
{
    // 注入系统用户服务（用于查询角色）
    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private StudentSelectionMapper studentSelectionMapper;

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private CourseMapper courseMapper;
    // 新增：注入选课异常Service（直接复用已有服务）
    @Autowired
    private ISelectionExceptionService selectionExceptionService;




    /**
     * 查询学生选课
     *
     * @param id 学生选课主键
     * @return 学生选课
     */
    @Override
    public StudentSelection selectStudentSelectionById(Long id)
    {
        return studentSelectionMapper.selectStudentSelectionById(id);
    }

    /**
     * 查询学生选课列表（按角色过滤）
     *
     * @param studentSelection 学生选课
     * @return 学生选课
     */
    @Override
    public List<StudentSelection> selectStudentSelectionList(StudentSelection studentSelection)
    {
        // 1. 获取当前登录用户信息（防护空指针）
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null || loginUser.getUserId() == null) {
            throw new ServiceException("未获取到当前登录用户信息，请重新登录");
        }
        Long currentUserId = loginUser.getUserId();

        // 2. 查询用户的角色编码列表（通过ISysUserService）
        List<String> roles = sysUserService.selectRoleKeysByUserId(currentUserId);
        if (roles == null || roles.isEmpty()) {
            throw new ServiceException("当前用户未分配角色，请联系管理员");
        }

        // 3. 按角色动态过滤数据
        if (roles.contains("student")) {
            // 学生：只查询自己的选课记录
            Student student = studentMapper.selectStudentByUserId(currentUserId);
            if (student == null) {
                throw new ServiceException("当前用户未关联学生信息，请联系管理员");
            }
            studentSelection.setStudentId(student.getId());
        }
        else if (roles.contains("teacher")) {
            // 教师：只查询自己授课的课程选课记录
            Teacher teacher = teacherMapper.selectTeacherByUserId(currentUserId);
            if (teacher == null) {
                throw new ServiceException("当前用户未关联教师信息，请联系管理员");
            }
            // 查询教师授课的所有课程ID
            Course courseQuery = new Course();
            courseQuery.setTeacherId(teacher.getId());
            List<Course> courses = courseMapper.selectCourseList(courseQuery);
            if (courses.isEmpty()) {
                // 若教师未授课，直接返回空列表（避免查询全部）
                return Collections.emptyList();
            }
            List<Long> courseIds = courses.stream()
                    .map(Course::getId)
                    .collect(Collectors.toList());
            studentSelection.setCourseIds(courseIds);
        }
        else if (roles.contains("manage") || roles.contains("admin")) {
            // 教务员/管理员：查询所有记录（不额外过滤）
        }
        else {
            // 其他未授权角色：返回空列表
            return Collections.emptyList();
        }

        // 4. 执行带过滤条件的查询
        // 上面角色查询和权限过滤会消耗掉 Controller 的 startPage()，这里重新启动分页
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        if (pageNum != null && pageSize != null) {
            PageHelper.startPage(pageNum, pageSize);
        }
        return studentSelectionMapper.selectStudentSelectionList(studentSelection);
    }

    /**
     * 新增学生选课（核心修改：捕获重复异常，记录到异常表）
     */
    @Override
    @Transactional(rollbackFor = Exception.class) // 事务保证：异常记录插入成功
    public int insertStudentSelection(StudentSelection studentSelection) {
        // 1. 先检查课程是否超员（新增逻辑）
        Long courseId = studentSelection.getCourseId();
        // 1.1 查询课程信息（获取max_students）
        Course course = courseMapper.selectCourseById(courseId);
        if (course == null) {
            throw new ServiceException("课程不存在，无法选课");
        }
        Long maxStudents = course.getMaxStudents();
        if (maxStudents != null && maxStudents > 0) {
            // 1.2 查询当前已选人数
            int selectedCount = studentSelectionMapper.countSelectedByCourseId(courseId);
            if (selectedCount >= maxStudents.intValue()) {
                // 超员：插入异常记录（exception_type=2）
                SelectionException exception = new SelectionException();
                exception.setCourseId(courseId);
                exception.setStudentId(studentSelection.getStudentId());
                exception.setExceptionType(2L); // 2-超员选课（你的数据库定义）
                selectionExceptionService.insertSelectionException(exception);
                return -2; // 返回-2标识超员
            }
        }

        // 2. 再检查是否重复选课（原有逻辑）
        try {
            return studentSelectionMapper.insertStudentSelection(studentSelection);
        } catch (Exception e) {
            if (e.getCause() instanceof SQLIntegrityConstraintViolationException) {
                SQLIntegrityConstraintViolationException sqlEx = (SQLIntegrityConstraintViolationException) e.getCause();
                if (sqlEx.getMessage().contains("tb_student_selection.uk_course_student")) {
                    // 重复选课：插入异常记录（exception_type=1）
                    SelectionException exception = new SelectionException();
                    exception.setCourseId(courseId);
                    exception.setStudentId(studentSelection.getStudentId());
                    exception.setExceptionType(1L);
                    selectionExceptionService.insertSelectionException(exception);
                    return -1; // 返回-1标识重复
                }
            }
            throw e;
        }
    }

    @Override
    public int updateStudentSelection(StudentSelection studentSelection)
    {
        return studentSelectionMapper.updateStudentSelection(studentSelection);
    }

    @Override
    public int deleteStudentSelectionByIds(Long[] ids)
    {
        return studentSelectionMapper.deleteStudentSelectionByIds(ids);
    }

    @Override
    public int deleteStudentSelectionById(Long id)
    {
        return studentSelectionMapper.deleteStudentSelectionById(id);
    }
}