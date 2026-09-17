package com.ruoyi.manage.mapper;

import java.util.List;
import com.ruoyi.manage.domain.SelectionException;
import org.apache.ibatis.annotations.Mapper;

/**
 * 选课异常记录Mapper接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Mapper
public interface SelectionExceptionMapper 
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
     * 删除选课异常记录
     * 
     * @param id 选课异常记录主键
     * @return 结果
     */
    public int deleteSelectionExceptionById(Long id);

    /**
     * 批量删除选课异常记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSelectionExceptionByIds(Long[] ids);
}
