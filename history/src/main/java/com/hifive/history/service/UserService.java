package com.hifive.history.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hifive.history.model.TokenDto;
import com.hifive.history.model.UserDto;
import com.hifive.history.model.iDto;
import com.hifive.history.repository.UserDao;

/**
 * Created by Admin on 2017-03-24.
 */
@Service
public class UserService implements iService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UserDao userDao;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public int hi_insert(iDto dto) {
		return userDao.hi_insert(dto);
	}

	@Override
	public int hi_update(iDto dto) {
		return userDao.hi_update(dto);
	}

	@Override
	public iDto hi_detail(iDto dto) {
		return userDao.hi_detail(dto);
	}

	public int hi_usercheck(Map<String, Object> condition) {
		return userDao.hi_usercheck(condition);
	}

	@Override
	public int hi_delete(int cnt) {
		return userDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		return userDao.hi_selectList(condition);
	}

	public iDto hi_login(iDto dto) {
		//등업 충족여부 확인
		HashMap<String, Object> map 
			= (HashMap<String, Object>)userDao.checkGradeCondition(((UserDto)dto).getId());
		//등급나누기
		if(map!=null){
			if( Integer.parseInt( (map.get("CNT")).toString() ) >= 15 ){
				Map<String, String> condition = new HashMap<>();
				condition.put("id", ((UserDto)dto).getId());
				condition.put("grade", "2");
				userDao.upGrade(condition);
			}else if( Integer.parseInt( (map.get("CNT")).toString() ) >= 10 ){
				Map<String, String> condition = new HashMap<>();
				condition.put("id", ((UserDto)dto).getId());
				condition.put("grade", "1");
				userDao.upGrade(condition);
			}
		}

		logger.debug("user service에서 bcryptpasswordencoder 선언 전");
		logger.debug("user service에서 bcryptpasswordencoder 선언 후");

		String rawPassword = ((UserDto) dto).getPassword();
		UserDto checkUserDto = (UserDto)userDao.hi_login(dto);

		logger.debug("user service에서 matches 호출 전");
		if (checkUserDto != null && passwordEncoder.matches(rawPassword, checkUserDto.getPassword())) {
			logger.debug("user service에서 matches 호출 후");
			return checkUserDto;
		} else
			return null;
	}
	
	
	public int hi_throwToken(iDto dto, String token) {		
		
		UserDto  us = (UserDto) dto;
		TokenDto tk = new TokenDto();
		
		// id와 token을 TokenDto 형식으로 넘겨준다
		tk.setId(us.getId());
		tk.setToken(token);		
		
		return userDao.hi_throwToken(tk);
	}
	
	public iDto hi_searchToken(String id) {	
		
		return userDao.hi_searchToken(id);
	}
	
	public int hi_unlockId(String id) {
		
		return userDao.hi_unlockId(id);
	}
	
}
