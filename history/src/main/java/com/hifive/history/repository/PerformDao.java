package com.hifive.history.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hifive.history.model.PerformDto;

@Repository
public class PerformDao implements IPerformDao {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.performCode";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int hi_insert(PerformDto dto) {
		String statement = namespace +".hi_insert";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.insert(statement,dto);
	}

}
