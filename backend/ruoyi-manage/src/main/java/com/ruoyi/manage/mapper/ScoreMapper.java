package com.ruoyi.manage.mapper;

import java.util.List;
import java.util.Map;

import com.ruoyi.manage.domain.Score;
import org.apache.ibatis.annotations.Mapper;

/**
 * 学生成绩Mapper接口
 * 
 * @author hgz
 * @date 2025-10-22
 */
@Mapper
public interface ScoreMapper 
{
    // 新增：按分数段统计成绩人数（适配角色过滤）
    List<Map<String, Object>> statScoreDistribution(Score score);

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
     * 删除学生成绩
     * 
     * @param id 学生成绩主键
     * @return 结果
     */
    public int deleteScoreById(Long id);

    /**
     * 批量删除学生成绩
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteScoreByIds(Long[] ids);
}
