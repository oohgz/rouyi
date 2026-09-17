package com.ruoyi.manage.service;

import java.util.List;
import com.ruoyi.manage.domain.SelectionException;

/**
 * 选课异常记录Service接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
public interface ISelectionExceptionService 
{
    /**
     * 查询选课异常记录
     * 
     * @param id 选课异常记录主键
     * @return 选课异常记录
     */
    public SelectionException selectSelectionExceptionById(Long id);

    /**
     * 查询选课异常记录列表
     * 
     * @param selectionException 选课异常记录
     * @return 选课异常记录集合
     */
    public List<SelectionException> selectSelectionExceptionList(SelectionException selectionException);

    /**
     * 新增选课异常记录
     * 
     * @param selectionException 选课异常记录
     * @return 结果
     */
    public int insertSelectionException(SelectionException selectionException);

    /**
     * 修改选课异常记录
     * 
     * @param selectionException 选课异常记录
     * @return 结果
     */
    public int updateSelectionException(SelectionException selectionException);

    /**
     * 批量删除选课异常记录
     * 
     * @param ids 需要删除的选课异常记录主键集合
     * @return 结果
     */
    public int deleteSelectionExceptionByIds(Long[] ids);

    /**
     * 删除选课异常记录信息
     * 
     * @param id 选课异常记录主键
     * @return 结果
     */
    public int deleteSelectionExceptionById(Long id);
}
