package com.hifive.history.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.iDto;

/**
 * Created by Admin on 2017-03-24.
 */
@Repository
public class CategoryDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.categoryCode";
	
	@Autowired
	private SqlSessionTemplate sqlSession; 

	@Override
	public int hi_insert(iDto dto) {
		String statement = namespace +".hi_insert";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.insert(statement,dto);
	}

	@Override
	public int hi_update(iDto dto) {
		String statement = namespace +".hi_update";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.update(statement,dto);
	}

	@Override
	public iDto hi_detail(iDto dto) {
		String statement = namespace +".hi_detail";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.selectOne(statement,dto);
	}

	@Override
	public int hi_delete(int cnt) {
		String statement = namespace +".hi_delete";
		logger.debug("statement"+statement);
		logger.debug("cnt = "+cnt);
		return sqlSession.update(statement,cnt);
	}
	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> map) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+map.toString());
		return sqlSession.selectList(statement,map);
	}
	public List<CategoryDto> hi_selectCategory(Map<String, String> map){
		String statement = namespace +".hi_selectCategory";
		logger.debug("statement"+statement);
		logger.debug("dto.toSting() = " + map.toString());
		return sqlSession.selectList(statement,map);
	}
	public int updateCategory(Map<String, String> map){
		String statement = namespace +".updateCategory";
		logger.debug("statement"+statement);
		logger.debug("map.toString() = "+map.toString());
		return sqlSession.update(statement,map);
	}
	public List<HashMap<String, Object>> getCategoryCount(Map<String, String> map){
		String statement = namespace +".getCategoryCount";
		logger.debug("statement"+statement);
		logger.debug("map.toString() = "+map.toString());
		return sqlSession.selectList(statement,map);
	}
	
	public String getCategoryRange(int selected) {
		String statement = namespace +".getCategoryRange";
		logger.debug("statement"+statement);
		logger.debug("selected = "+selected);
		return sqlSession.selectOne(statement, selected);
	}
}
