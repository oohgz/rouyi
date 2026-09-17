package com.ruoyi.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.manage.domain.Course;
import com.ruoyi.manage.domain.Teacher;
import com.ruoyi.manage.mapper.CourseMapper;
import com.ruoyi.manage.mapper.TeacherMapper;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.manage.domain.Student;
import com.ruoyi.manage.service.IStudentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学生信息（学生个人信息）Controller
 * 
 * @author hgz
 * @date 2025-10-22
 */
@RestController
@RequestMapping("/manage/student")
public class StudentController extends BaseController
{
    @Autowired
    private IStudentService studentService;
    // 新增注入（权限校验和课程查询用）
    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private ISysUserService sysUserService;



    /**
     * 新增接口：根据课程ID查询选了该课程的学生（供成绩添加页面使用）
     */
    @GetMapping("/listByCourse/{courseId}")
    public AjaxResult listByCourse(@PathVariable("courseId") Long courseId) {
        // 1. 权限校验：仅教师、管理员、教务员可访问
        LoginUser loginUser = SecurityUtils.getLoginUser();
        List<String> roles = sysUserService.selectRoleKeysByUserId(loginUser.getUserId());
        if (!roles.contains("teacher") && !roles.contains("admin") && !roles.contains("manage")) {
            return AjaxResult.error("无权限访问");
        }

        // 2. 教师额外校验：只能查询自己授课课程的学生（防止跨课程查询）
        if (roles.contains("teacher")) {
            Teacher teacher = teacherMapper.selectTeacherByUserId(loginUser.getUserId());
            Course course = courseMapper.selectCourseById(courseId);
            // 校验课程是否属于当前教师
            if (course == null || !course.getTeacherId().equals(teacher.getId())) {
                return AjaxResult.error("无权查询该课程的学生");
            }
        }

        // 3. 调用Service查询该课程的选课学生
        List<Student> studentList = studentService.selectStudentsByCourseId(courseId);
        return AjaxResult.success(studentList);
    }

    /**
     * 查询学生信息（学生个人信息）列表
     */
    @PreAuthorize("@ss.hasPermi('manage:student:list')")
    @GetMapping("/list")
    public TableDataInfo list(Student student)
    {
        startPage();
        List<Student> list = studentService.selectStudentList(student);
        return getDataTable(list);
    }

    /**
     * 导出学生信息（学生个人信息）列表
     */
    @PreAuthorize("@ss.hasPermi('manage:student:export')")
    @Log(title = "学生信息（学生个人信息）", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Student student)
    {
        List<Student> list = studentService.selectStudentList(student);
        ExcelUtil<Student> util = new ExcelUtil<Student>(Student.class);
        util.exportExcel(response, list, "学生信息（学生个人信息）数据");
    }

    /**
     * 获取学生信息（学生个人信息）详细信息
     */
    @PreAuthorize("@ss.hasPermi('manage:student:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(studentService.selectStudentById(id));
    }

    /**
     * 新增学生信息（学生个人信息）
     */
    @PreAuthorize("@ss.hasPermi('manage:student:add')")
    @Log(title = "学生信息（学生个人信息）", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Student student)
    {
        int result = studentService.insertStudent(student);
        if (result == -4) {
            // 学号重复：返回成功状态，前端显示友好提示
            return AjaxResult.error("您输入的学号已存在，请更换学号");
        } else {
            // 正常新增：沿用原有逻辑
            return toAjax(result);
        }
    }

    /**
     * 修改学生信息（学生个人信息）
     */
    @PreAuthorize("@ss.hasPermi('manage:student:edit')")
    @Log(title = "学生信息（学生个人信息）", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Student student)
    {
        return toAjax(studentService.updateStudent(student));
    }

    /**
     * 删除学生信息（学生个人信息）
     */
    @PreAuthorize("@ss.hasPermi('manage:student:remove')")
    @Log(title = "学生信息（学生个人信息）", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(studentService.deleteStudentByIds(ids));
    }
}
