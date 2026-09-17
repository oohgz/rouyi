package com.ruoyi.manage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
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

    // 新增：获取成绩分布（用于ECharts）
    @GetMapping("/statDistribution")

    // 复用成绩查看权限，无需新增
    public AjaxResult getScoreDistribution() {
        // 1. 获取当前登录用户的角色（和你之前获取角色判断数据权限的代码一样）
        LoginUser loginUser = SecurityUtils.getLoginUser(); // 这行你肯定熟悉，之前用过
        String roleKey = loginUser.getUser().getRoles().get(0).getRoleKey(); // 获取角色标识（manage/teacher）

        // 2. 只允许manage和teacher访问（和你限制老师看自己信息的判断逻辑类似）
        if (!"manage".equals(roleKey) && !"teacher".equals(roleKey) && !"admin".equals(roleKey)){
            return AjaxResult.error("没有权限访问"); // 非这两个角色，返回无权限
        }

        // 3. 有权限，返回图表数据（和你之前返回数据的逻辑一样）
        Map<String, Integer> chartData = new HashMap<>();
        return AjaxResult.success(scoreService.getScoreDistribution());
    }

    /**
     * 查询学生成绩列表
     */
    @PreAuthorize("@ss.hasPermi('manage:score:list')")
    @GetMapping("/list")
    public TableDataInfo list(Score score)
    {
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
