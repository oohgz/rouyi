package com.ruoyi.manage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.manage.domain.Teacher;
import com.ruoyi.manage.mapper.TeacherMapper;
import com.ruoyi.manage.service.ICourseService;
import com.ruoyi.manage.domain.Course;
import com.ruoyi.system.service.ISysUserService;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.manage.domain.Score;
import com.ruoyi.manage.service.IScoreService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学生成绩Controller
 * 
 * @author hgz
 * @date 2025-10-22
 */
@RestController
@RequestMapping("/manage/score")
public class ScoreController extends BaseController
{
    @Autowired
    private IScoreService scoreService;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private ICourseService courseService;

    @Autowired
    private ISysUserService sysUserService;

    // 新增：获取成绩分布（用于ECharts）
    @GetMapping("/statDistribution")

    // 复用成绩查看权限，无需新增；courseId 可选：传了则按课程统计分布
    public AjaxResult getScoreDistribution(@RequestParam(value = "courseId", required = false) Long courseId,
                                           @RequestParam(value = "college", required = false) String college,
                                           @RequestParam(value = "className", required = false) String className) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        String roleKey = loginUser.getUser().getRoles().get(0).getRoleKey();

        if (!"manage".equals(roleKey) && !"teacher".equals(roleKey) && !"admin".equals(roleKey)){
            return AjaxResult.error("没有权限访问");
        }

        return AjaxResult.success(scoreService.getScoreDistribution(courseId, college, className));
    }

    /**
     * 查询学生成绩列表
     */
    @PreAuthorize("@ss.hasPermi('manage:score:list')")
    @GetMapping("/list")
    public TableDataInfo list(Score score)
    {
        // 教师角色：只查自己教的课程的成绩
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
                score.setCourseIds(courseIds);
            }
        }
        startPage();
        List<Score> list = scoreService.selectScoreList(score);
        return getDataTable(list);
    }

    /**
     * 导出学生成绩列表
     */
    @PreAuthorize("@ss.hasPermi('manage:score:export')")
    @Log(title = "学生成绩", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Score score)
    {
        List<Score> list = scoreService.selectScoreList(score);
        ExcelUtil<Score> util = new ExcelUtil<Score>(Score.class);
        util.exportExcel(response, list, "学生成绩数据");
    }

    /**
     * 获取学生成绩详细信息
     */
    @PreAuthorize("@ss.hasPermi('manage:score:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(scoreService.selectScoreById(id));
    }

    /**
     * 新增学生成绩
     */
    @PreAuthorize("@ss.hasPermi('manage:score:add')")
    @Log(title = "学生成绩", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Score score)
    {
        int result = scoreService.insertScore(score);
        if (result == -6) {
            // 重复添加：返回提示“该学生在该课程中已有成绩”
            return AjaxResult.error("该学生在该课程中的成绩已存在，请不要重复添加");
        } else {
            return toAjax(result);
        }
    }

    /**
     * 修改学生成绩
     */
    @PreAuthorize("@ss.hasPermi('manage:score:edit')")
    @Log(title = "学生成绩", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Score score)
    {
        return toAjax(scoreService.updateScore(score));
    }

    /**
     * 删除学生成绩
     */
    @PreAuthorize("@ss.hasPermi('manage:score:remove')")
    @Log(title = "学生成绩", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(scoreService.deleteScoreByIds(ids));
    }
}
