package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.LoveDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoveService implements iService{
	
	@Autowired
	private LoveDao loveDao;

	@Override
	public int hi_insert(iDto dto) {
		return loveDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		return loveDao.hi_update(dto);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		return loveDao.hi_selectList(condition);
	}
	@Override
	public iDto hi_detail(iDto dto) {
		return loveDao.hi_detail(dto);
	}
	
	@Override
	public int hi_delete(int cnt) {
		return loveDao.hi_delete(cnt);
	}	
}
