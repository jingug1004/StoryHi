package com.hifive.history.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.hifive.history.model.iDto;

public interface IPostService {
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile file) throws Exception;
	public int hi_insert(iDto dto);
	public int hi_insertMap(Map<String, Object> map, HttpServletRequest request) throws Exception;
	public int hi_update(iDto dto);
	public int hi_updateBoardnFile(Map<String, Object> map, HttpServletRequest request) throws Exception;
	public iDto hi_detail(iDto dto) ;
	public int hi_delete(int cnt) ;
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception ;
	public List<Map<String, Object>> hi_bloggerRankList();
	public List<HashMap<String, Object>> hi_selectCommentRank(String id);
	public List<HashMap<String, Object>> hi_selectTodayCommentRank(HashMap<String, String> map);
	public List<HashMap<String, Object>> hi_selectLoveRank(HashMap<String, String> map) throws Exception;	
	public List<Map<String, Object>> hi_selectFollowerList(Map<String, Object> condition) throws Exception;
	public List<Map<String, Object>> hi_selectThemeList(Map<String, Object> condition) throws Exception;
	public List<Map<String, Object>> hi_selectSearchList(Map<String, Object> condition) throws Exception;
	public int hi_insertList(List<Map<String, Object>> boxList) throws SQLException;
	public List<Map<String, Object>> getLovePost(Map<String, String> dto)throws SQLException;
	public List<Map<String, Object>> getHashTag()throws SQLException;
	public Map<String, Object> hi_isFollower(Map<String, Object> map);
	public List<Map<String, Object>> hi_hashtagSearchList(Map<String, Object> condition) throws Exception;
}
