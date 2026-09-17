package com.ruoyi.manage.service;

import java.util.List;
import java.util.Map;

import com.ruoyi.manage.domain.Score;

/**
 * 学生成绩Service接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
public interface IScoreService 
{
    /**
     * 查询学生成绩
     * 
     * @param id 学生成绩主键
     * @return 学生成绩
     */
    public Score selectScoreById(Long id);

    /**
     * 查询学生成绩列表
     * 
     * @param score 学生成绩
     * @return 学生成绩集合
     */
    public List<Score> selectScoreList(Score score);

    /**
     * 新增学生成绩
     * 
     * @param score 学生成绩
     * @return 结果
     */
    public int insertScore(Score score);

    /**
     * 修改学生成绩
     * 
     * @param score 学生成绩
     * @return 结果
     */
    public int updateScore(Score score);

    /**
     * 批量删除学生成绩
     * 
     * @param ids 需要删除的学生成绩主键集合
     * @return 结果
     */
    public int deleteScoreByIds(Long[] ids);

    /**
     * 删除学生成绩信息
     * 
     * @param id 学生成绩主键
     * @return 结果
     */
    public int deleteScoreById(Long id);

    /**
     * 统计成绩分布（用于ECharts）
     * @return 各分数段的人数统计
     */
    Map<String, Integer> getScoreDistribution();

}
