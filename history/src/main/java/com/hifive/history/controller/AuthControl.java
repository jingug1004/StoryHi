package com.hifive.history.controller;

import com.hifive.history.model.TokenDto;
import com.hifive.history.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

@Controller
public class AuthControl {	
			
	@Autowired
	UserService userService;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "verified/{id}/{token}.hi", method = RequestMethod.GET)
	public ModelAndView join(@PathVariable("id") String id, 
								@PathVariable("token") String token) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
//			String decodeResult = URLDecoder.decode("222", "UTF-8");
//			logger.debug("[[[decodeURLResult  ]] "+decodeResult);
			
			String idValue 	  = URLDecoder.decode(id, "UTF-8");
			String tokenValue = URLDecoder.decode(token, "UTF-8");
			logger.debug("[[[idValue     ]] "+idValue);	
			logger.debug("[[[tokenValue  ]] "+tokenValue);		
			
			// 토큰 복호화
			String decoded = tokenValue;
			
			// 토큰 value 탐색
			TokenDto dto = (TokenDto) userService.hi_searchToken(idValue);
			
			// 일치 불일치
			if(dto.getToken().equals(decoded)) {
				/*
				 *  id lock 해제
				 *  ex) grade : -1 -> 0 이런식으로
				 */
				userService.hi_unlockId(idValue);
				
				// db에 저장되어 있는 토큰은 삭제할지 말지 생각해본다
				
				mav.setViewName("/auth/complete");
				
			} else {
				
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}		
		
		return mav;
	}
}

// for commit
