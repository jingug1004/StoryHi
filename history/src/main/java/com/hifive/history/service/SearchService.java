package com.hifive.history.service;

import com.hifive.history.model.iDto;
import com.hifive.history.repository.SearchDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class SearchService implements iService {

	@Autowired
	private SearchDao searchDao;

	@Override
	public int hi_insert(iDto dto) {
		return searchDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		return 0;
	}

	@Override
	public iDto hi_detail(iDto dto) {
		return null;
	}

	@Override
	public int hi_delete(int cnt) {
		return 0;
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		return searchDao.hi_selectList(condition);
	}
	
	public List<Map<String, Object>> hi_selectRankList(){
		return searchDao.hi_selectRankList();
	}
}
