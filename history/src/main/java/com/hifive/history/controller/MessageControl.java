package com.hifive.history.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.google.gson.Gson;
import com.hifive.history.model.MessageDto;
import com.hifive.history.model.UserDto;
import com.hifive.history.service.MessageService;
import com.hifive.history.service.UserService;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class MessageControl {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	UserService userService;
	
	@Autowired
	private MessageService messageService; 
	
//	@RequestMapping(value="message/pooling.hi", produces = "application/json; charset=utf8")
//	public @ResponseBody String do_pooling(HttpServletRequest res) {
//		
//		Gson gson = new Gson();
//		
//		
//		logger.debug("<<E..<<N..<<D..<<.. REQUEST: message/filtered.hi");
//		logger.debug("----------------------------------------------------------");
//		
//		return gson.toJson("hi");
//	}
	
	// logger debug
	@RequestMapping(value="message/filtered.hi", method=RequestMethod.POST,
			produces = "application/json; charset=utf8")
	public @ResponseBody String do_filtered(HttpServletRequest res) {
		
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/filtered.hi");
				
		
		String condi = res.getParameter("condi");
		String words = res.getParameter("words");
		String id 	 = res.getParameter("id");
		String page  = res.getParameter("page");
		
		if(page != null) {
			
		} else {
			page = "1";
		}
		
		Map<String, Object> search_info = new HashMap<String, Object>();			
		search_info.put("condi", condi);
		search_info.put("words", words);
		search_info.put("id", id);
		search_info.put("PAGE_NUM", page);
		
		logger.debug("[[[condi     ]]] " + condi);
		logger.debug("[[[words     ]]] " + words);
		logger.debug("[[[id	      ]]] " + id);
		logger.debug("[[[PAGE_NUM  ]]] " + page);
		
		List<Map<String, Object>> filteredList = messageService.hi_select_filtered(search_info);
		
		// 내가 입력한 검색어를 넣어보자
		Map<String, Object> inputWords = new HashMap<String, Object>();
		inputWords.put("INPUTWORDS", words);
		logger.debug("[[[INPUTWORDS  ]]] " + inputWords.toString());
		filteredList.add(inputWords);
		
		Gson gson = new Gson();
		
		
		logger.debug("<<E..<<N..<<D..<<.. REQUEST: message/filtered.hi");
		logger.debug("----------------------------------------------------------");
		
		return gson.toJson(filteredList);
	}	
	
	// 주석 확인 필요
	@RequestMapping("message/writeForm.hi")
	public ModelAndView do_write_ready(HttpServletRequest res) {
		
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/writeForm.hi");
		
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = res.getSession(true); 	
		if(session.getAttribute("user") != null) {
			
			UserDto dto = (UserDto) session.getAttribute("user");
			
			// 미확인 쪽지
			int unReadNotes = messageService.hi_unread_note(dto.getId());
			logger.debug("UNREADNOTES	-> " + unReadNotes);
			
		/* 
		 * 사용자로부터 답장(1개 이상) 요청
		 * jsp	: message_list1.jsp 
		 * js	: replyAction()
		 * para : list 
		 * list : ex) (),(),()
		 */
		if(res.getParameter("list") != null) {
			String list = res.getParameter("list");
			logger.debug("답장 보낼 대상	-> "+ list);
			
			String values[] = list.split(",");					
			String ids = "";

			for(int i = 0; i < values.length; i++) {
//				int lastIdx = values[i].indexOf(')');				
//				ids = ids + values[i].substring(1, lastIdx) + ",";
				ids = ids + values[i] + ",";
				
//				logger.debug("VALUES LIST	-> " + values[i].substring(0, lastIdx));
				logger.debug("VALUES LIST	-> " + values[i]);
				logger.debug("IDS LIST	-> " + ids);
			}
			
			ids = ids.substring(0, ids.lastIndexOf(","));
			logger.debug("TAKEID		-> " + ids);
			
			mav.setViewName("/message/writeForm");
			mav.addObject("TAKEID", ids);	
			mav.addObject("UNREADNOTES", unReadNotes);
		
		/*
		 * 사용자로부터 쪽지 쓰기 요청(좌측 메뉴, 헤더)
		 */
		} else {
			String TAKEID ="";
//			String NAME	  ="";
			
			TAKEID = res.getParameter("TAKEID");	
//			NAME   = res.getParameter("NAME");
			
			mav.setViewName("/message/writeForm");
			mav.addObject("TAKEID", TAKEID);
//			mav.addObject("NAME", NAME);
			mav.addObject("UNREADNOTES", unReadNotes);
		}
		} else {
			logger.debug("SESSION.GETATTRIBUTE(USER) -> NULL");
			mav.setViewName("/main/login");
		}
		
		
		logger.debug("<<E..<<N..<<D..<<.. REQUEST: message/writeForm.hi");
		logger.debug("----------------------------------------------------------");

		return mav;
	}
	
	@RequestMapping("message/write.hi")
	public ModelAndView do_write(HttpServletRequest res) {
		
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/write.hi");
		
		
		String SENDID = "";
		String TAKEID = "";
		String note   = "";
		
		SENDID = res.getParameter("SEND_ID");
		TAKEID = res.getParameter("TAKE_ID");		
		note   = res.getParameter("NOTE");
		logger.debug("SENDID -> " + SENDID);
		logger.debug("TAKEID -> " + TAKEID);
		logger.debug("NOTE   -> " + note);
		
		
		ModelAndView mav = new ModelAndView();
		String[] arrIdx = TAKEID.split(",");
		for(int i = 0; i < arrIdx.length; i++) {
			logger.debug("ARRIDX -> " + arrIdx[i]);
		}
		/*
		 * 
		 * 
		 * 
		 */	
		
		StringBuffer blackIds = new StringBuffer();
		int result[] = new int[arrIdx.length];
		
		if(arrIdx.length > 1) {	
			logger.debug("=== 전체  쪽지 ===");
			
			for (int i = 0; i < arrIdx.length; i++) {
				MessageDto dto = new MessageDto();
				dto.setSeq(0);
				dto.setSend_id(SENDID);
				dto.setTake_id(arrIdx[i]);
				dto.setContents(note);
				dto.setWdate("");
				dto.setRdate("");
				dto.setState("");
				dto.setName("");
				dto.setSend_view("");
				dto.setTake_view("");
				
				// 아이디 유효 검사
				Map<String, Object> condition = new HashMap<String, Object>();
				condition.put("SEARCH_CON", "idcheck");
				condition.put("id", arrIdx[i]);
				
				int flag   = userService.hi_usercheck(condition);				
				
				if(flag == 1) {
					// 유효 아이디
					result[i] = messageService.hi_insert(dto);										
				} else {
					result[i] = -1;
					blackIds.append(arrIdx[i]+", ");
				}	
			}	
			
			// 미확인 쪽지
			int unReadNotes = messageService.hi_unread_note(SENDID);
			logger.debug("UNREADNOTES	-> " + unReadNotes);
			
			mav.setView(new RedirectView(("send.hi")));
			for(int i = 0; i < arrIdx.length; i++) {
				if(result[i] == -1) {
					String str = blackIds.toString();
					str = str.substring(0, str.length() - 1);
					
					logger.debug("String str  -> " + str);
					mav.addObject("blackIds", str);				
					mav.addObject("UNREADNOTES", unReadNotes);
					mav.setViewName("/message/writeForm");
					
					logger.debug("BLACKIDS(str)  -> " + str);
					break;
				}					
			}	
		} else {
			logger.debug("=== 단일  쪽지 ===");
			
			MessageDto dto = new MessageDto();
			dto.setSeq(0);
			dto.setSend_id(SENDID);
			dto.setTake_id(TAKEID);
			dto.setContents(note);
			dto.setWdate("");
			dto.setRdate("");
			dto.setState("");
			dto.setName("");
			dto.setSend_view("");
			dto.setTake_view("");
			
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("SEARCH_CON", "idcheck");
			condition.put("id", arrIdx[0]);
			
			int flag   = userService.hi_usercheck(condition);	
			logger.debug("FLAG	->	" + flag);
			
			if(flag == 1) {
				// 유효 아이디
				result[0] = messageService.hi_insert(dto);										
			} else {
				result[0] = -1;
				blackIds.append(arrIdx[0]);
			}	
			
			// 미확인 쪽지
			int unReadNotes = messageService.hi_unread_note(SENDID);
			logger.debug("UNREADNOTES	-> " + unReadNotes);
			
			if(result[0] == 1) {
				mav.setView(new RedirectView(("send.hi")));
				
			} else {
				String str = blackIds.toString();				
				mav.addObject("blackIds", str);				
				mav.addObject("UNREADNOTES", unReadNotes);
				mav.setViewName("/message/writeForm");
				
				logger.debug("BLACKIDS(str)  -> " + str);
			}
		}						
		
		
		logger.debug("<<E..<<N..<<D..<<.. REQUEST: message/write.hi");
		logger.debug("----------------------------------------------------------");
		
		
		return mav;
	}
	
	@RequestMapping("message/read.hi")
	public ModelAndView do_read(HttpServletRequest res,
			@RequestParam(value = "note", required=true) int seq,
			@RequestParam(value = "show", required=true) String bt_yn) {
	
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/read.hi");
		
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = res.getSession(true); 	
		if(session.getAttribute("user") != null) {
			MessageDto dto = new MessageDto();
			dto.setSeq(seq);
			dto.setSend_id("");
			dto.setTake_id("");
			dto.setContents("");
			dto.setWdate("");
			dto.setRdate("");
			dto.setState("");
			dto.setName(bt_yn);
			dto.setSend_view("");
			dto.setTake_view("");
		
			MessageDto note = new MessageDto();
			note = (MessageDto) messageService.hi_detail(dto);
			logger.debug("NOTE	-> ", note);
			
			if(bt_yn.equals("bty")) {
				if(note.getState().equals("0")) {
					messageService.hi_detail_state(note.getSeq(), bt_yn);
				}
			} else {
				
			}
			
			UserDto user = (UserDto) session.getAttribute("user");
		
			// 미확인 쪽지
			int unReadNotes = messageService.hi_unread_note(user.getId());
			logger.debug("UNREADNOTES	-> " + unReadNotes);
			
			mav.setViewName("/message/read");
			mav.addObject("NOTE", note);	
			mav.addObject("BT_YN", bt_yn);
			mav.addObject("UNREADNOTES", unReadNotes);
			
			
			logger.debug("<<E..<<N..<<D..<<.. REQUEST: message/read.hi");
			logger.debug("----------------------------------------------------------");
		
		} else {
			logger.debug("SESSION.GETATTRIBUTE(USER) -> NULL");
			mav.setViewName("/main/login");
		}
		
		return mav;
	}
	
	
	@RequestMapping("message/delete.hi")
	public ModelAndView do_delete(
			@RequestParam(value = "idx", required=true) 
						String paramMap,
			@RequestParam(value = "to", required=true) 
						String to) {
		
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/delete.hi");
				
		logger.debug("paramMap	-> "+paramMap.toString());
		logger.debug("to			-> "+to.toString());
		
		String[] arrIdx = paramMap.split(",");
		for (int i = 0; i < arrIdx.length; i++) {		
			
			MessageDto dto = new MessageDto();
			dto.setSeq(Integer.parseInt(arrIdx[i]));
			dto.setSend_id("");
			dto.setTake_id("");
			dto.setContents("");
			dto.setWdate("");
			dto.setRdate("");
			dto.setState("");
			dto.setName("");
			dto.setSend_view("");
			dto.setTake_view("");
			
			MessageDto note = new MessageDto();
			note = (MessageDto) messageService.hi_detail(dto);
			
			/* to     : 받은 쪽지/보낸 쪽지
			 * select : send_view, take_view 선택
			 * update : 삭제에 영향받지 않는 경우
			 * delete : update할 필요 없이 삭제에 해당하는 경우
			*/ 
			
			if(to.equals("receive")) {
				if(note.getSend_view().equals("-1")) {
					// delete
					int result = messageService.hi_delete(Integer.parseInt(arrIdx[i]));
					
				} else {
					// update
					messageService.hi_update_view(to, Integer.parseInt(arrIdx[i]));
				}				
			} else {
				if(note.getTake_view().equals("-1")) {
					int result = messageService.hi_delete(Integer.parseInt(arrIdx[i]));
					
				} else {
					messageService.hi_update_view(to, Integer.parseInt(arrIdx[i]));
				}
			}			
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setView(new RedirectView((to+".hi")));
		
		
		logger.debug("<<E..<<N..<<D..<<.. REQUEST: message/delete.hi");
		logger.debug("----------------------------------------------------------");
		
		return mav;
	}
	
	// 이건 뭘까 대체?
	@RequestMapping("message/reply.hi")
	public ModelAndView do_reply(
			@RequestParam(value = "idx", required=true) 
						String paramMap,
			@RequestParam(value = "to", required=true) 
			String to) {
		
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: message/reply.hi");
		
		
		logger.debug("paramMap -> "+paramMap.toString());
		String[] arrIdx = paramMap.split(",");
		for (int i = 0; i < arrIdx.length; i++) {
			int result = messageService.hi_delete(Integer.parseInt(arrIdx[i]));
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setView(new RedirectView((to+".hi")));
		
		
		logger.debug("<<E..<<N..<<D..<<.. REQUEST: message/reply.hi");
		logger.debug("----------------------------------------------------------");
		
		return mav;
	}	
	
	@RequestMapping("message/receive.hi")
	public ModelAndView do_search(HttpServletRequest res) {
			
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: receive.hi");
		
			
		ModelAndView mav = new ModelAndView();			
		
		String PAGE_NUM = 
				(res.getParameter("PAGE_NUM") == null || 
					res.getParameter("PAGE_NUM").equals(""))
						?"1":res.getParameter("PAGE_NUM");
		
		HttpSession session = res.getSession(true); 	
		if(session.getAttribute("user") != null) {
			logger.debug("SESSION INFO	-> " + session.toString());
			
			UserDto dto = (UserDto) session.getAttribute("user");
			
			Map<String, Object> search_info = new HashMap<String, Object>();			
			
			search_info.put("PAGE_NUM", PAGE_NUM);
			search_info.put("TAKEID", dto.getId());
			logger.debug("TAKEID			-> " + dto.getId());
			logger.debug("SEARCH_INFO	-> " + search_info.toString());
			
			// 리스트 가져오기
			List<Map<String, Object>> getList = messageService.hi_select_getlist(search_info);		
			logger.debug("GETLIST SIZE	-> " + getList.size());
			
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			
			// 미확인 쪽지
			int unReadNotes = messageService.hi_unread_note(dto.getId());
			logger.debug("UNREADNOTES	-> " + unReadNotes);
			
			mav.setViewName("/message/message_list1");
			mav.addObject("GETLIST", getList);
			mav.addObject("PAGE_NUM", PAGE_NUM);
			mav.addObject("UNREADNOTES", unReadNotes);
			
		} else {
			logger.debug("SESSION.GETATTRIBUTE(USER) -> NULL");
			mav.setViewName("/main/login");
		}	
		
		
		logger.debug("<<E..<<N..<<D..<<.. REQUEST: receive.hi");
		logger.debug("----------------------------------------------------------");
		
		return mav;		
	}

	
	@RequestMapping("message/send.hi")
	public ModelAndView messageList(HttpServletRequest res) {
		
		logger.debug("----------------------------------------------------------");
		logger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: send.hi");
		
		
		ModelAndView mav = new ModelAndView();
		
		String PAGE_NUM = 
				(res.getParameter("PAGE_NUM") == null || 
					res.getParameter("PAGE_NUM").equals(""))
						?"1":res.getParameter("PAGE_NUM");
		
		HttpSession session = res.getSession(true); 
		if(session.getAttribute("user") != null) {
			logger.debug("SESSION INFO	-> " + session.toString());
			
			UserDto dto = (UserDto) session.getAttribute("user");
			
			Map<String, Object> search_info = new HashMap<String, Object>();	
			
			search_info.put("PAGE_NUM", PAGE_NUM);
			search_info.put("SENDID", dto.getId());
			logger.debug("SENDID	 		-> " + dto.getId());
			logger.debug("SEARCH_INFO	-> " + search_info.toString());
			
			// 리스트 가져오기
			List<Map<String, Object>> getList = messageService.hi_select_sendlist(search_info);
			logger.debug("SENDLIST SIZE 	-> " + getList.size());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			logger.debug(getList.toString());
			
			// 미확인 쪽지
			int unReadNotes = messageService.hi_unread_note(dto.getId());
			logger.debug("UNREADNOTES	-> " + unReadNotes);
			
			mav.setViewName("/message/message_list2");
			mav.addObject("GETLIST", getList);
			mav.addObject("PAGE_NUM", PAGE_NUM);
			mav.addObject("UNREADNOTES", unReadNotes);
			
		} else {
			logger.debug("SESSION.GETATTRIBUTE(USER) -> NULL");
			mav.setViewName("/main/login");
		}		
		
		
		logger.debug("<<E..<<N..<<D..<<.. REQUEST: send.hi");
		logger.debug("----------------------------------------------------------");
		
		return mav;	
	}

}


