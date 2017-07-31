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
public class CodeDDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.codeD";
	
	@Autowired
	private SqlSessionTemplate sqlSession; 
	
	@Override
	public int hi_insert(iDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int hi_update(iDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public iDto hi_detail(iDto dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int hi_delete(int cnt) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}

}
