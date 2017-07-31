package com.hifive.history.repository;

import java.util.HashMap;
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
public class VisitDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.visitCode";
	
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
		logger.debug("dto.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
	public int hi_getToday(String id){
		String statement = namespace +".hi_getToday";
		logger.debug("statement"+statement);
		logger.debug("id = " + id);
		return sqlSession.selectOne(statement,id);
	}
	
	public int hi_getTotal(String id){
		String statement = namespace +".hi_getTotal";
		logger.debug("statement"+statement);
		logger.debug("id = " + id);
		return sqlSession.selectOne(statement,id);
	}
	
	public List<Map<String,Object>> hi_getTodayVisit(HashMap<String, String> dto) throws Exception {
		String statement = namespace +".hi_getTodayVisit";
		logger.debug("statement"+statement);
		logger.debug("dto = " + dto);
		return sqlSession.selectList(statement,dto);
	}
	public List<Map<String,Object>> hi_getAgeVisit(HashMap<String, String> dto) throws Exception {
		String statement = namespace +".hi_getAgeVisit";
		logger.debug("statement"+statement);
		logger.debug("dto = " + dto);
		return sqlSession.selectList(statement,dto);
	}
	public int hi_upsert(HashMap<String, String> dto) throws Exception{
		String statement = namespace +".hi_upsert";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.insert(statement,dto);
	}
	public List<Map<String,Object>> getExcel(String id){
		String statement = namespace +".getExcel";
		logger.debug("statement"+statement);
		logger.debug("id = " + id);
		return sqlSession.selectList(statement,id);
	}
}
