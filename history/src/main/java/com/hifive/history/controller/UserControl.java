package com.hifive.history.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hifive.history.model.BlogDto;
import com.hifive.history.model.CategoryDto;
import com.hifive.history.model.UserDto;
import com.hifive.history.service.*;
import com.hifive.history.util.EmailSenderUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
@SessionAttributes("user")
public class UserControl {

	@Autowired
	UserService userService;

	@Autowired
	BlogService blogService;

	@Autowired
	CodeDService codeDService;

	@Autowired
	FollowService followService;

	@Autowired
	CategoryService categoryService;
	
	@Autowired
	EmailSenderUtil emailSenderUtil;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = "user/join.hi", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView join(HttpServletRequest request, @RequestParam(value="profileImg", required=false) MultipartFile imageFile, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		// 회원 가입 버튼 클릭해서 넘어왔을 시
		if (request.getParameter("do_join") != null) {
			final String rootPath = request.getSession().getServletContext().getRealPath("/");
			final String resourcePath = "http://hi-history.com/resources/uploadImages/";
			final String defaultImage = "http://hi-history.com/resources/image/girl.png";

			String pw = passwordEncoder.encode(request.getParameter("password"));

			// 회원 추가
			UserDto userDto = new UserDto();
			userDto.setId(request.getParameter("id"));
			userDto.setName(request.getParameter("name"));
			userDto.setPassword(pw);
			userDto.setEmail(request.getParameter("email"));
			userDto.setArea(request.getParameter("area"));
			userDto.setBirth(request.getParameter("birth"));
			userDto.setSex(request.getParameter("sex"));
			if (request.getParameter("profileCon").equals(""))
				userDto.setPf_content("안녕하세요.");
			else
				userDto.setPf_content(request.getParameter("profileCon"));
			if (imageFile.getOriginalFilename().equals(""))
				userDto.setPf_image(defaultImage);
			else
				userDto.setPf_image(resourcePath + saveFile(imageFile, userDto.getId(), rootPath));

			mav.setViewName("redirect:/");

			userService.hi_insert(userDto);

			// 블로그 추가
			BlogDto blogDto = new BlogDto();
			blogDto.setId(request.getParameter("id"));
			blogDto.setTitle(request.getParameter("id") + "님의 블로그");
			blogService.hi_insert(blogDto);

			// 카테고리 추가
			CategoryDto categoryDto = new CategoryDto();
			categoryDto.setId(request.getParameter("id"));
			categoryDto.setName("기본 카테고리");
			categoryDto.setState("0");
			categoryService.hi_insert(categoryDto);

			// 세션에 로그인정보 추가
			userDto.setPassword(request.getParameter("password"));
			userDto = (UserDto) userService.hi_login(userDto);
			model.addAttribute("user", userDto);
			mav.setViewName("redirect:/");

		} else {
			// 지역 리스트 가져오기
			List<Map<String, Object>> areaMapList = new ArrayList<Map<String, Object>>();
			Map<String, Object> condition = new HashMap<>();
			List<String> code_list = new ArrayList<String>();
			code_list.add("120");
			condition.put("code_list", code_list);
			try {
				areaMapList = codeDService.hi_selectList(condition);
			} catch (Exception e) {
				e.printStackTrace();
			}
			List<String> areaList = new ArrayList<String>();
			for (int i = 0; i < areaMapList.size(); i++)
				areaList.add((String) areaMapList.get(i).get("CD_D_NM"));

			mav.addObject("areaList", areaList);
			mav.setViewName("/user/join");
		}

		return mav;
	}

	private String saveFile(MultipartFile file, String userId, String rootPath) throws Exception {
		byte bytes[] = file.getBytes();
		String imageDir = "resources/uploadImages/";
		String originalFileName = file.getOriginalFilename();
		String saveFileName = userId + "_profile." + originalFileName.substring(originalFileName.lastIndexOf('.' ) + 1).toLowerCase();
		String savePath = rootPath + imageDir + saveFileName;

		/* 파일 쓰기 */
		BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(savePath));
		bos.write(bytes);
		bos.flush();
		bos.close();

		return saveFileName;
	}

	@RequestMapping(value = "user/idCheck.hi", method = RequestMethod.POST)
	@ResponseBody
	public String idCheck(HttpServletRequest request) {
		Map<String, Object> condition = new HashMap<>();
		condition.put("SEARCH_CON", "idcheck");
		condition.put("id", request.getParameter("id"));
		int flag = userService.hi_usercheck(condition);

		JsonObject jobj = new JsonObject();

		if(flag < 1)
			jobj = new JsonParser().parse("{\"msg\":\"true\"}").getAsJsonObject();
		else
			jobj = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
		Gson gson = new Gson();
		return gson.toJson(jobj);
	}

	// 사용자 요청에 의한 인증번호 발송
	@RequestMapping(value = "user/generated.hi", method = RequestMethod.POST)
	@ResponseBody
	public String generatedFive_digit(HttpServletRequest request) {

		// 이메일을 받는다
		String email = request.getParameter("email");

		// 5자리 난수 생성 부분
		int generatedDigit = (int)(Math.random() * 90000) + 10000;

		// 이메일을 보낸다
		int flag = emailSenderUtil.five_digitSender(email, generatedDigit);

		JsonObject jobj = new JsonObject();
		if(flag > 0) {
			jobj = new JsonParser().parse("{\"msg\":\"true\",\"digit\":\"" + generatedDigit + "\"}").getAsJsonObject();
		} else {
			jobj = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
		}

		Gson gson = new Gson();
		return gson.toJson(jobj);
	}


	@RequestMapping(value = "user/followSearch.hi", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String followSearch(HttpServletRequest request) {
		String PAGE_SIZE = (request.getParameter("PAGE_SIZE") == null) ? "10" : request.getParameter("PAGE_SIZE");
		String PAGE_NUM = (request.getParameter("PAGE_NUM") == null
				|| request.getParameter("PAGE_NUM").equals("")) ? "1" : request.getParameter("PAGE_NUM");
		String PAGE = (request.getParameter("PAGE") == null
				|| request.getParameter("PAGE").equals("")) ? "page" : request.getParameter("PAGE");
		Map<String, Object> condition = new HashMap<>();
		condition.put("SEARCH_CON", "ifollow");
		condition.put("id", request.getParameter("id"));
		condition.put("PAGE_SIZE", PAGE_SIZE);
		condition.put("PAGE_NUM", PAGE_NUM);
		condition.put("PAGE", PAGE);

		List<Map<String, Object>> followList = new ArrayList<>();
		try {
			followList = followService.hi_selectList(condition);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Gson gson = new Gson();
		return gson.toJson(followList);
	}

	@RequestMapping(value = "user/update.hi", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView update(HttpServletRequest request, @RequestParam(value="profileImg", required=false) MultipartFile imageFile, Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();

		// 수정 버튼 클릭해서 넘어왔을 시
		if (request.getParameter("do_update") != null) {
			UserDto loginUser = (UserDto)session.getAttribute("user");

			final String rootPath = request.getSession().getServletContext().getRealPath("/");
			final String resourcePath = "http://hi-history.com/resources/uploadImages/";
			final String defaultImage = loginUser.getPf_image();


			String pw = passwordEncoder.encode(request.getParameter("password"));

			// 회원 추가
			UserDto userDto = new UserDto();
			userDto.setId(request.getParameter("id"));
			userDto.setName(request.getParameter("name"));
			userDto.setPassword(pw);
			userDto.setEmail(request.getParameter("email"));
			userDto.setArea(request.getParameter("area"));
			userDto.setBirth(request.getParameter("birth"));
			userDto.setSex(request.getParameter("sex"));
			userDto.setPf_content(request.getParameter("profileCon"));
			if (request.getParameter("grade") == null)
				userDto.setGrade(request.getParameter("grade"));
			else
				userDto.setGrade(loginUser.getGrade());

			if (imageFile.getOriginalFilename().equals(""))
				userDto.setPf_image(defaultImage);
			else
				userDto.setPf_image(resourcePath + saveFile(imageFile, userDto.getId(), rootPath));
			userService.hi_update(userDto);


			// 세션에 로그인정보 추가
			userDto.setPassword(request.getParameter("password"));
			userDto = (UserDto) userService.hi_login(userDto);
			model.addAttribute("user", userDto);
			mav.setViewName("redirect:/");

		} else {
			// 지역 리스트 가져오기
			List<Map<String, Object>> areaMapList = new ArrayList<Map<String, Object>>();
			Map<String, Object> condition = new HashMap<>();
			List<String> code_list = new ArrayList<String>();
			code_list.add("120");
			condition.put("code_list", code_list);
			try {
				areaMapList = codeDService.hi_selectList(condition);
			} catch (Exception e) {
				e.printStackTrace();
			}
			List<String> areaList = new ArrayList<String>();
			for (int i = 0; i < areaMapList.size(); i++)
				areaList.add((String) areaMapList.get(i).get("CD_D_NM"));
			mav.addObject("areaList", areaList);
			mav.setViewName("/user/update");
		}

		return mav;
	}
}
