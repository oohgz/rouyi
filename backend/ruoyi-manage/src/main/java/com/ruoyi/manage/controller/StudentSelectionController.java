package com.ruoyi.manage.controller;

import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.manage.domain.Teacher;
import com.ruoyi.manage.domain.Course;
import com.ruoyi.manage.mapper.TeacherMapper;
import com.ruoyi.manage.service.ICourseService;
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
import com.ruoyi.manage.domain.StudentSelection;
import com.ruoyi.manage.service.IStudentSelectionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学生选课Controller
 * 
 * @author hgz
 * @date 2025-10-22
 */
@RestController
@RequestMapping("/manage/selection")
public class StudentSelectionController extends BaseController
{
    @Autowired
    private IStudentSelectionService studentSelectionService;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private ICourseService courseService;

    @Autowired
    private ISysUserService sysUserService;

    /**
     * 新增学生选课（核心修改：判断重复选课，返回成功状态）
     */
    @PreAuthorize("@ss.hasPermi('manage:selection:add')")
    @Log(title = "学生选课", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody StudentSelection studentSelection) {
        int result = studentSelectionService.insertStudentSelection(studentSelection);
        if (result == -1) {
            return AjaxResult.error("您已选过该课程，系统已记录重复选课异常");
        } else if (result == -2) {
            return AjaxResult.error("该课程已达最大选课人数，系统已记录超员异常");
        } else {
            return toAjax(result); // 正常选课成功，返回默认提示
        }
    }

    /**
     * 查询学生选课列表
     */
    @PreAuthorize("@ss.hasPermi('manage:selection:list')")
    @GetMapping("/list")
    public TableDataInfo list(StudentSelection studentSelection)
    {
        // 教师角色：只查自己教的课程的选课记录
        LoginUser loginUser = SecurityUtils.getLoginUser();
        List<String> roles = sysUserService.selectRoleKeysByUserId(loginUser.getUserId());
        if (roles.contains("teacher") && !roles.contains("admin") && !roles.contains("manage")) {
            Teacher teacher = teacherMapper.selectTeacherByUserId(loginUser.getUserId());
            if (teacher != null) {
                List<Course> myCourses = courseService.selectCourseByTeacherUserId(loginUser.getUserId());
                List<Long> courseIds = myCourses.stream().map(Course::getId).collect(Collectors.toList());
                if (courseIds.isEmpty()) {
                    return getDataTable(new java.util.ArrayList<>());
                }
                studentSelection.setCourseIds(courseIds);
            }
        }
        startPage();
        List<StudentSelection> list = studentSelectionService.selectStudentSelectionList(studentSelection);
        return getDataTable(list);
    }

    /**
     * 导出学生选课列表
     */
    @PreAuthorize("@ss.hasPermi('manage:selection:export')")
    @Log(title = "学生选课", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, StudentSelection studentSelection)
    {
        List<StudentSelection> list = studentSelectionService.selectStudentSelectionList(studentSelection);
        ExcelUtil<StudentSelection> util = new ExcelUtil<StudentSelection>(StudentSelection.class);
        util.exportExcel(response, list, "学生选课数据");
    }

    /**
     * 获取学生选课详细信息
     */
    @PreAuthorize("@ss.hasPermi('manage:selection:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(studentSelectionService.selectStudentSelectionById(id));
    }

    /**
     * 修改学生选课
     */
    @PreAuthorize("@ss.hasPermi('manage:selection:edit')")
    @Log(title = "学生选课", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody StudentSelection studentSelection)
    {
        return toAjax(studentSelectionService.updateStudentSelection(studentSelection));
    }

    /**
     * 删除学生选课
     */
    @PreAuthorize("@ss.hasPermi('manage:selection:remove')")
    @Log(title = "学生选课", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(studentSelectionService.deleteStudentSelectionByIds(ids));
    }
}
