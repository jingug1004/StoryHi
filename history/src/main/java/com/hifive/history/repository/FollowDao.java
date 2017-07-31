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
public class FollowDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.followCode";
	
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
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("condition.toString() = "+condition.toString());
		return sqlSession.selectList(statement, condition);
	}
	public List<Map<String, Object>> hi_getFollowList(Map<String, String> condition) throws Exception {
		String statement = namespace +".hi_getFollowList";
		logger.debug("statement"+statement);
		logger.debug("condition.toString() = "+condition.toString());
		return sqlSession.selectList(statement, condition);
	}
	public List<Map<String, Object>> hi_getNeighborList(Map<String, String> condition) throws Exception {
		String statement = namespace +".hi_getNeighborList";
		logger.debug("statement"+statement);
		logger.debug("condition.toString() = "+condition.toString());
		return sqlSession.selectList(statement, condition);
	}
	public int blockFollow(Map<String,String> condition){
		String statement = namespace +".blockFollow";
		logger.debug("statement"+statement);
		logger.debug("cnt = "+condition);
		return sqlSession.update(statement,condition);
	}
}
