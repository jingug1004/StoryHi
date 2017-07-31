package com.hifive.history.service;

import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.iDto;
import com.hifive.history.repository.CategoryDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class CategoryService implements iService {

	@Autowired
	private CategoryDao categoryDao;

	@Override
	public int hi_insert(iDto dto) {
		return categoryDao.hi_insert(dto);
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
		return categoryDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	public List<CategoryDto> hi_selectCategory(Map<String, String> map){
		return categoryDao.hi_selectCategory(map);
	}
	public int updateCategory(Map<String, String> map){
		return categoryDao.updateCategory(map);
	}
	public List<HashMap<String, Object>> getCategoryCount(Map<String, String> map){
		return categoryDao.getCategoryCount(map);
	}
	
	public String getCategoryRange(int selected) {
		
		return categoryDao.getCategoryRange(selected);	
	}
}
