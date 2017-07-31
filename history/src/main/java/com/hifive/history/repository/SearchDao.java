package com.hifive.history.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hifive.history.model.iDto;
 
/**
 * Created by Admin on 2017-03-24.
 */
@Repository
public class SearchDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.searchCode";
	
	@Autowired
	private SqlSessionTemplate sqlSession; 

	@Override
	public int hi_insert(iDto dto) {
		String statement = namespace +".hi_insert";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		int flag = sqlSession.insert(statement, dto); 
		logger.debug("flag = "+flag);
		return flag;
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
	public List<Map<String, Object>> hi_selectList(Map<String, Object> dto) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.selectList(statement,dto);
	}
	
	public List<Map<String, Object>> hi_selectRankList(){
		String statement = namespace +".hi_selectRankList";
		
		return sqlSession.selectList(statement);
	}
}
