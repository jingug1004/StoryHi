package com.hifive.history.service;

import com.hifive.history.model.CommentDto;
import com.hifive.history.model.iDto;
import com.hifive.history.repository.CommentDao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService implements iService {

	@Autowired
	private CommentDao commentDao;

	@Override
	public int hi_insert(iDto dto) {
		return commentDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		return commentDao.hi_update(dto);
	}



	@Override
	public int hi_delete(int cnt) {
		return commentDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		return commentDao.hi_selectList(condition);
	}
	
	public int hi_insertRe(iDto dto) {
		return commentDao.hi_insertRe(dto);
		
	}
	
//= 사용안함=======================================	
	@Override
	public iDto hi_detail(iDto dto) {
		return null;
	}
}
