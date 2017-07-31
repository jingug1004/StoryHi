package com.hifive.history.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.hifive.history.model.BlogDto;
import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.FollowDto;
import com.hifive.history.model.PostDto;
import com.hifive.history.model.UserDto;
import com.hifive.history.model.iDto;
import com.hifive.history.service.BlogService;
import com.hifive.history.service.CategoryService;
import com.hifive.history.service.FollowService;
import com.hifive.history.service.PostService;
import com.hifive.history.service.VisitService;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class GraphControl {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BlogService blogService;
	@Autowired
	PostService postService;
	@Autowired
	VisitService visitService;
	@Autowired
	FollowService followService;
	
	Logger loger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping("chart/visit.hi")
	public ModelAndView visit(HttpServletRequest request, HttpSession session) throws Exception {
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		ModelAndView mav = new ModelAndView("chart/visit");
		
		Date date = new Date();
		Date tmp  = new Date();		
		
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		date.setDate(date.getDate()+1);
		tmp.setDate(tmp.getDate()+1);
		
		String enddate = sd.format(date);
		
		
		if(request.getParameter("enddate")!=null){
			String nddate = sd.format(tmp);
			
			
			enddate  = request.getParameter("enddate");
			
			Date end = sd.parse(enddate);
			Date nd  = sd.parse(enddate);
			
			end.setDate(end.getDate()+1);
			nd.setDate(end.getDate()-1);
			
			enddate = sd.format(end);
			nddate = sd.format(nd);
			
			mav.addObject("enddate", nddate);
		}
		loger.debug("enddate");
		loger.debug(enddate);
		loger.debug(enddate);
		
		HashMap<String,String> dto = new HashMap<>();
		dto.put("id", user.getId());
		dto.put("enddate", enddate);
		
		List<Map<String,Object>> visitList = visitService.hi_getTodayVisit(dto);
		mav.addObject("visitList", visitList);			
		
		
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		mav.addObject("blogdto", blogdto);
		
		return mav;
	}
	@RequestMapping("chart/visitdown.hi")
	public ModelAndView visitdown(HttpServletRequest request, HttpSession session) throws Exception {
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		
		ModelAndView mav = new ModelAndView("chart/visitdown");
		List<Map<String,Object>> excelList = visitService.getExcel(user.getId());
		mav.addObject("excelList", excelList);
		return mav;
	}
	@RequestMapping("chart/age.hi")
	public ModelAndView age(HttpServletRequest request, HttpSession session) throws Exception {
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		
		ModelAndView mav = new ModelAndView("chart/age");
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		date.setDate(date.getDate()+1);
		String enddate = sd.format(date);
		date.setDate(date.getDate()-6);
		String startdate = sd.format(date);
		
		
		if(request.getParameter("enddate")!=null){
			startdate = request.getParameter("startdate");
			enddate = request.getParameter("enddate");
		}
		
		HashMap<String,String> dto = new HashMap<>();
		dto.put("id", user.getId());
		dto.put("startday", startdate);
		dto.put("endday", enddate);
		
		List<Map<String,Object>> visitAgeList = visitService.hi_getAgeVisit(dto);
		mav.addObject("visitAgeList", visitAgeList);
		mav.addObject("comment2", startdate);
		mav.addObject("comment1", enddate);
		
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		mav.addObject("blogdto", blogdto);
		
		return mav;
	}
	
	/*
	 * 이웃 증감 
	 * Based on  : 조윤행
	 * Commented : 박성우
	 * date		 : 17. 4. 6(목)
	 * code		 : followService.hi_getFollowList
	 * 			 : followDao.hi_getFollowList
	 * params	 : "state", "0"/"1"(증/감)
	 * return	 : List<Map<String, Object>>
	 * xml		 : com.hifive.history.repository.mappers.followCode .hi_getFollowList 
	 */
	@RequestMapping("chart/follow.hi")
	public ModelAndView follow(HttpServletRequest request, HttpSession session) throws Exception {
		
		loger.debug("----------------------------------------------------------");
		loger.debug("<<S..<<T..<<A..<<R..<<T..<<.. REQUEST: chart/follow.hi");	
		
		
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		loger.debug("session.getAttribute(user)  ->  " + user);
		
		ModelAndView mav = new ModelAndView("chart/follow");
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		date.setDate(date.getDate()+1);
		String enddate = sd.format(date);
		loger.debug("String enddate              ->  " + enddate);
		
		if(request.getParameter("enddate")!=null){
			enddate = request.getParameter("enddate");
		}
		loger.debug("String enddate               ->  " + enddate);
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("id", user.getId());
		map.put("enddate", enddate);
		map.put("state", "0");
		List<Map<String, Object>> followIncList = followService.hi_getFollowList(map);
		loger.debug("List followIncList          ->  " + followIncList);
		
		HashMap<String,String> map2 = new HashMap<String,String>();
		map2.put("id", user.getId());
		map2.put("enddate", enddate);
		map2.put("state", "1");
		List<Map<String, Object>> followDecList = followService.hi_getFollowList(map2);
		loger.debug("List followDecList          ->  " + followDecList);
		
		mav.addObject("followIncList", followIncList);
		mav.addObject("followDecList", followDecList);
		
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		mav.addObject("blogdto", blogdto);
		
		
		loger.debug("<<E..<<N..<<D..<<.. REQUEST: chart/follow.hi");
		loger.debug("----------------------------------------------------------");
		
		return mav;
	}
	@RequestMapping("chart/menu.hi")
	public String menu() {
		return "/chart/menu";
	}
	@RequestMapping("chart/neighbor.hi")
	public ModelAndView neighbor(HttpServletRequest request, HttpSession session) throws Exception {
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		if(request.getParameter("addordel")!=null){
			if(request.getParameter("addordel").equals("add")){
				FollowDto dto = new FollowDto();
				dto.setMy_id(user.getId());
				dto.setYou_id(request.getParameter("id"));
				dto.setFdate("SYSDATE");
				dto.setSex(user.getSex());
				dto.setArea(user.getArea());
				dto.setBirth(user.getBirth());
				dto.setState("0");
				
				followService.hi_insert(dto);
				
			}else if(request.getParameter("addordel").equals("del")){
				Map<String,String> condition = new HashMap<>();
				condition.put("myid", request.getParameter("id"));
				condition.put("youid", user.getId());
				followService.blockFollow(condition);
			}
		}
		
		
		String PAGE_NUM = "1";
		if(request.getParameter("PAGE_NUM")!=null){
			PAGE_NUM = request.getParameter("PAGE_NUM");
		}
		ModelAndView mav = new ModelAndView("chart/neighbor");
		
		HashMap<String,String> map = new HashMap<>();
		map.put("id", user.getId());
		map.put("PAGE_SIZE", "5");
		map.put("PAGE_NUM", PAGE_NUM);
		
		List<Map<String, Object>> neighborList = followService.hi_getNeighborList(map);
		mav.addObject("neighborList", neighborList);
		
		//내가 팔로우하는 사람들
		Map<String, Object> condition = new HashMap<>();
		condition.put("SEARCH_CON", "ifollow");
		condition.put("id", user.getId());
		condition.put("PAGE", "notpage");
		
		List<Map<String, Object>> followList = followService.hi_selectList(condition);
		mav.addObject("followList", followList);
		
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		mav.addObject("blogdto", blogdto);
		
		return mav;
		
	}
	@RequestMapping(value="chart/lovepost.hi", method = RequestMethod.GET)
	public ModelAndView lovepost(HttpServletRequest request, HttpSession session) throws Exception {
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		
		String PAGE_NUM = "1";
		if(request.getParameter("PAGE_NUM")!=null){
			PAGE_NUM = request.getParameter("PAGE_NUM");
		}
		ModelAndView mav = new ModelAndView("chart/lovepost");
		
		HashMap<String,String> map = new HashMap<>();
		map.put("id", user.getId());
		map.put("PAGE_SIZE", "5");
		map.put("PAGE_NUM", PAGE_NUM);
		
		List<Map<String, Object>> lovepostList = postService.getLovePost(map);
		mav.addObject("lovepostList", lovepostList);
		
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		mav.addObject("blogdto", blogdto);
		
		return mav;
		
	}
	@RequestMapping("chart/love.hi")
	public ModelAndView love(HttpServletRequest request, HttpSession session) throws Exception{
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		
		ModelAndView mav = new ModelAndView();
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		String startdate = "2017-03-01";
		date.setDate(date.getDate()+1);
		String enddate = sd.format(date);
		
		// 전체조회
		HashMap<String,String> map = new HashMap<>();
		map.put("ID", user.getId());
		map.put("START_DAY", startdate);
		map.put("END_DAY", enddate);
		
		List<HashMap<String, Object>> loveRank = postService.hi_selectLoveRank(map);
		mav.setViewName("chart/love");
		mav.addObject("loveRank", loveRank);
		
		// 기간조회
		HashMap<String,String> map2 = new HashMap<>();
		
		if(request.getParameter("startdate")!=null){
			startdate = request.getParameter("startdate");
			enddate = request.getParameter("enddate");			
		}
		map2.put("ID", user.getId());
		map2.put("START_DAY", startdate );
		map2.put("END_DAY", enddate );
		List<HashMap<String, Object>> loveSelectRank = postService.hi_selectLoveRank(map2);
				
		mav.addObject("loveSelectRank", loveSelectRank);
		
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		mav.addObject("blogdto", blogdto);
		
		return mav;
	}
	@RequestMapping("chart/comment.hi")
	public ModelAndView comment(HttpServletRequest request, HttpSession session) {
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}
		
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		date.setDate(date.getDate()+1);
		
		String startdate = "2017-03-01";
		String enddate = sd.format(date);
		
		ModelAndView mav = new ModelAndView();
		// 전체 조회
		List<HashMap<String, Object>> postList = postService.hi_selectCommentRank(user.getId());
		mav.setViewName("chart/comment");
		mav.addObject("postList", postList);
		
		// 부분 조회
		
		if(request.getParameter("startdate")!=null){
			startdate = request.getParameter("startdate");
			enddate = request.getParameter("enddate");			
		}
		HashMap<String,String> map = new HashMap<>();
		map.put("id", user.getId());
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		
		List<HashMap<String, Object>> postTodayList = postService.hi_selectTodayCommentRank(map);
		mav.addObject("postTodayList", postTodayList);
		
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		mav.addObject("blogdto", blogdto);
		
		return mav;
	}
	@RequestMapping("chart/control.hi")
	public ModelAndView chartMenu(HttpServletRequest request, HttpSession session){
		UserDto user = new UserDto();;
		if(session.getAttribute("user")!=null){
			user = (UserDto)session.getAttribute("user");
		}		
		ModelAndView mav = new ModelAndView();
		if(request.getParameter("cateseq")!=null){
			String cateseq  = request.getParameter("cateseq");
			String catename = request.getParameter("catename");
			String catestate = request.getParameter("catestate").equals("true")?"0":"1";
			Map<String, String> map = new HashMap<>();
			map.put("cateseq", cateseq);
			map.put("catename", catename);
			map.put("catestate", catestate);	
			
			
			if(request.getParameter("btn").equals("mod")){
				categoryService.updateCategory(map);
				
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("UserId", user.getId());
				data.put("cateseq", cateseq);
				data.put("catename", catename);
				data.put("catestate", catestate);
				
				postService.hi_updatePostState(data);				
				
				
			}else if(request.getParameter("btn").equals("del")){
				categoryService.hi_delete(Integer.parseInt(cateseq));
				
				HashMap<String, String> data = new HashMap<String, String>();
				data.put("UserId", user.getId());
				data.put("cateseq", cateseq);
				data.put("catename", catename);
				data.put("catestate", catestate);
				
				postService.hi_updatePostState(data);		
				
			}else{
				
			}
		}		
		
		
		//카테고리 불러오기(전체)
		Map<String, String> dto = new HashMap<>();
		dto.put("id",user.getId());
		dto.put("isAll", "true");
		List<CategoryDto> categoryBefore = categoryService.hi_selectCategory(dto);
		boolean b = true;
		if(request.getParameter("cateUpdate")!=null){
			
		}
		
		if(request.getParameter("name")!=null){
			String name = request.getParameter("name");
			String state = request.getParameter("state").equals("true")?"0":"1";
			for(int i = 0 ; i < categoryBefore.size();++i){
				if(categoryBefore.get(i).getName().equals(name)){
					b = false;
					break;
				}
			}
			if(b){
				CategoryDto dto2 = new CategoryDto();
				dto2.setId(user.getId());
				dto2.setName(name);
				dto2.setState(state);
				
			}			
		}
		
		//블로그 타이틀 바꾸기
		if(request.getParameter("title")!=null){
			String title = request.getParameter("title");
			String theme = request.getParameter("theme");
			BlogDto bdto = new BlogDto(user.getId(), title, theme);
		}
		//블로그 타이틀
		BlogDto blogdto = blogService.getMyBlog(user.getId());
		//카테고리 목록 뿌리기
		List<CategoryDto> categoryList = categoryService.hi_selectCategory(dto);		
		mav.setViewName("chart/control");
		mav.addObject("categoryList", categoryList);
		mav.addObject("blogdto", blogdto);
		
		return mav;
	}
}
