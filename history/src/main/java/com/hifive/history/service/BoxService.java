package com.hifive.history.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.BoxDao;

@Service
public class BoxService implements iService {

	@Autowired
	private BoxDao boxDao;


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
		return boxDao.hi_selectList(condition);
	}
	
	public Map<String, Object> hi_selectFileInfo(Map<String, Object> map) throws Exception {
	    return boxDao.hi_selectFileInfo(map);
	}

}
