package com.ruoyi.manage.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.manage.mapper.SelectionExceptionMapper;
import com.ruoyi.manage.domain.SelectionException;
import com.ruoyi.manage.service.ISelectionExceptionService;

/**
 * 选课异常记录Service业务层处理
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Service
public class SelectionExceptionServiceImpl implements ISelectionExceptionService 
{
    @Autowired
    private SelectionExceptionMapper selectionExceptionMapper;

    /**
     * 查询选课异常记录
     * 
     * @param id 选课异常记录主键
     * @return 选课异常记录
     */
    @Override
    public SelectionException selectSelectionExceptionById(Long id)
    {
        return selectionExceptionMapper.selectSelectionExceptionById(id);
    }

    /**
     * 查询选课异常记录列表
     * 
     * @param selectionException 选课异常记录
     * @return 选课异常记录
     */
    @Override
    public List<SelectionException> selectSelectionExceptionList(SelectionException selectionException)
    {
        return selectionExceptionMapper.selectSelectionExceptionList(selectionException);
    }

    /**
     * 新增选课异常记录
     * 
     * @param selectionException 选课异常记录
     * @return 结果
     */
    @Override
    public int insertSelectionException(SelectionException selectionException)
    {
        selectionException.setCreateTime(DateUtils.getNowDate());
        return selectionExceptionMapper.insertSelectionException(selectionException);
    }

    /**
     * 修改选课异常记录
     * 
     * @param selectionException 选课异常记录
     * @return 结果
     */
    @Override
    public int updateSelectionException(SelectionException selectionException)
    {
        return selectionExceptionMapper.updateSelectionException(selectionException);
    }

    /**
     * 批量删除选课异常记录
     * 
     * @param ids 需要删除的选课异常记录主键
     * @return 结果
     */
    @Override
    public int deleteSelectionExceptionByIds(Long[] ids)
    {
        return selectionExceptionMapper.deleteSelectionExceptionByIds(ids);
    }

    /**
     * 删除选课异常记录信息
     * 
     * @param id 选课异常记录主键
     * @return 结果
     */
    @Override
    public int deleteSelectionExceptionById(Long id)
    {
        return selectionExceptionMapper.deleteSelectionExceptionById(id);
    }
}
