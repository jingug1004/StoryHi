package com.hifive.history.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hifive.history.model.PerformDto;
import com.hifive.history.repository.PerformDao;

@Service
public class PerformService implements IPerformService{
	@Autowired
	private PerformDao performDao;
	@Override
	public int hi_insert(PerformDto dto) {
		return performDao.hi_insert(dto);
	}
}
