package com.ruoyi.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.manage.domain.SelectionException;
import com.ruoyi.manage.service.ISelectionExceptionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 选课异常记录Controller
 * 
 * @author hgz
 * @date 2025-10-22
 */
@RestController
@RequestMapping("/manage/exception")
public class SelectionExceptionController extends BaseController
{
    @Autowired
    private ISelectionExceptionService selectionExceptionService;

    /**
     * 查询选课异常记录列表
     */
    @PreAuthorize("@ss.hasPermi('manage:exception:list')")
    @GetMapping("/list")
    public TableDataInfo list(SelectionException selectionException)
    {
        startPage();
        List<SelectionException> list = selectionExceptionService.selectSelectionExceptionList(selectionException);
        return getDataTable(list);
    }

    /**
     * 导出选课异常记录列表
     */
    @PreAuthorize("@ss.hasPermi('manage:exception:export')")
    @Log(title = "选课异常记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SelectionException selectionException)
    {
        List<SelectionException> list = selectionExceptionService.selectSelectionExceptionList(selectionException);
        ExcelUtil<SelectionException> util = new ExcelUtil<SelectionException>(SelectionException.class);
        util.exportExcel(response, list, "选课异常记录数据");
    }

    /**
     * 获取选课异常记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('manage:exception:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(selectionExceptionService.selectSelectionExceptionById(id));
    }

    /**
     * 新增选课异常记录
     */
    @PreAuthorize("@ss.hasPermi('manage:exception:add')")
    @Log(title = "选课异常记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SelectionException selectionException)
    {
        return toAjax(selectionExceptionService.insertSelectionException(selectionException));
    }

    /**
     * 修改选课异常记录
     */
    @PreAuthorize("@ss.hasPermi('manage:exception:edit')")
    @Log(title = "选课异常记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SelectionException selectionException)
    {
        return toAjax(selectionExceptionService.updateSelectionException(selectionException));
    }

    /**
     * 删除选课异常记录
     */
    @PreAuthorize("@ss.hasPermi('manage:exception:remove')")
    @Log(title = "选课异常记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(selectionExceptionService.deleteSelectionExceptionByIds(ids));
    }
}
