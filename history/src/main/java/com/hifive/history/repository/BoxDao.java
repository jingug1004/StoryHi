package com.hifive.history.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hifive.history.model.iDto;

@Repository
public class BoxDao implements IBox {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.boxCode";
	
	@Autowired
	private SqlSessionTemplate sqlSession; 
	
	@Override
	public int hi_insertMap(Map<String, Object> map) {
		String statement = namespace +".hi_insertMap";
	
		return sqlSession.insert(statement,map);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> dto) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.selectList(statement,dto);
	}
	
	@Override
	public Map<String, Object> hi_selectFileInfo(Map<String, Object> map) throws Exception{
		String statement = namespace +".hi_selectFileInfo";
		
		return sqlSession.selectOne(statement, map);
	}

	@Override
	public void hi_deleteFileList(Map<String, Object> map) throws Exception{
		String statement = namespace +".hi_deleteFileList";
		sqlSession.update(statement, map);
	}
	
	@Override
	public void hi_updateFile(Map<String, Object> map) throws Exception{
		String statement = namespace +".hi_updateFile";
		sqlSession.update(statement, map);
	}

}
