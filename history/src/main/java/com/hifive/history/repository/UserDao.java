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
public class UserDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.userCode";
	
	// userCode에서 userAuth로 별도 분리
	private final String tokenspace="com.hifive.history.repository.mappers.userAuth";
	
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

	public int hi_usercheck(Map<String, Object> condition) {
		String statement = namespace +".hi_usercheck";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+condition.toString());
		return sqlSession.selectOne(statement,condition);
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

	public iDto hi_login(iDto dto) {
		String statement = namespace +".hi_login";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.selectOne(statement,dto);
	}
	
	public int hi_throwToken(iDto dto) {	
		String statement = tokenspace +".hi_throwToken";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.insert(statement, dto);
	}
	
	public iDto hi_searchToken(String id) {	
		String statement = tokenspace +".hi_searchToken";
		logger.debug("id"+id);
		return sqlSession.selectOne(statement, id);
	}
	
	public int hi_unlockId(String id) {
		String statement = tokenspace +".hi_unlockId";
		logger.debug("id"+id);
		return sqlSession.update(statement, id);
	}
	public Map<String, Object> checkGradeCondition(String id){
		String statement = namespace +".checkGradeCondition";
		logger.debug("statement"+statement);
		logger.debug("id = " + id);
		return sqlSession.selectOne(statement,id);
	}
	public int upGrade(Map<String, String> condition){
		String statement = namespace +".upGrade";
		logger.debug("statement"+statement);
		logger.debug("condition.toString() = " + condition.toString());
		return sqlSession.update(statement,condition);
	}
}
