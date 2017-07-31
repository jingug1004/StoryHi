package com.hifive.history.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.CodeDDao;
@Service
public class CodeDService implements iService {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CodeDDao codeDDao;
	
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
		return codeDDao.hi_selectList(condition);
	}

}
