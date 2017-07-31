package com.hifive.history.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.hifive.history.model.PostDto;
import com.hifive.history.model.iDto;
import com.hifive.history.repository.IBox;
import com.hifive.history.repository.PostDao;
import com.hifive.history.util.CommonUtils;
import com.hifive.history.util.FileUtils;

@Service
public class PostService implements IPostService {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private PostDao postDao;
	
	@Autowired
	private IBox boxDao;
	
	@Resource(name="fileUtils")
    private FileUtils fileUtils;
	
	static String FILE_URL = "";	//저장할 경로
	static final String SAVE_URL = "http://hi-history.com/resources/uploadImages";	// 불러올 경로
	
	public PostService() {
	}
	
	@SuppressWarnings("resource")
	@Override
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile file) throws Exception {
		FILE_URL = request.getSession().getServletContext().getRealPath("/")+"resources/uploadImages/";
		String originalFileExtension = null;
		String storedFileName = null;
		
		OutputStream out = null;
		PrintWriter printWriter = null;	
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String originalFileName = file.getOriginalFilename();
		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
		
		byte[] bytes = file.getBytes();
		String uploadPath = FILE_URL + storedFileName; //저장 경로
		
		System.out.println(uploadPath);
		out = new FileOutputStream(new File(uploadPath));
		out.write(bytes);
		String callback = request.getParameter("CKEditorFuncNum");
		
		printWriter = response.getWriter();
		String fileUrl = SAVE_URL + "/" +storedFileName; //url 경로
		
		printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
	               + callback
	               + ",'"
	               + fileUrl
	               + "','이미지를 업로드 하였습니다.'"
	               + ")</script>");
	       printWriter.flush();
	       
	       
	}

	@Override
	public int hi_insert(iDto dto) {
		logger.debug("PostService.dto.toString() = "+dto.toString());
		return postDao.hi_insert(dto);
	}
	
	@Transactional
	@Override
	public int hi_insertMap(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int flag = postDao.hi_insertMap(map);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
        
		if(list != null && list.size() != 0){
			hi_insertList(list);	//첨부파일 인설트 (트랜잭션 미적용)
		}
	
		return flag;
	}
	
	@Override
	public int hi_update(iDto dto) {
		logger.debug("PostService.dto.toString() = "+dto.toString());
		
		return postDao.hi_update(dto);
	}
	
	@Transactional
	@Override
	public int hi_updateBoardnFile(Map<String, Object> map, HttpServletRequest request) throws Exception{
		int flag = postDao.hi_updateBoardnFile(map);
		
		boxDao.hi_deleteFileList(map);
		List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(map, request);
	    Map<String,Object> tempMap = null;
	    for(int i=0, size=list.size(); i<size; i++){
	        tempMap = list.get(i);
	        if(tempMap.get("IS_NEW").equals("Y")){
	        	boxDao.hi_insertMap(tempMap);
	        }
	        else{
	        	boxDao.hi_updateFile(tempMap);
	        }
	    }
		return flag;
	}

	@Override
	public iDto hi_detail(iDto dto) {
		logger.debug("PostService.dto.toString() = "+dto.toString());
		PostDto postDto = (PostDto)postDao.hi_detail(dto);
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (postDto != null) {
			map.put("IDX", postDto.getSeq());
			try{
				postDto.setFileList(boxDao.hi_selectList(map));
			}catch(Exception e){
				e.getMessage();
			}
		}
		
		return postDto;
	}

	@Override
	public int hi_delete(int cnt) {
		logger.debug("PostService.cnt = "+cnt);
		return postDao.hi_delete(cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		logger.debug("PostService.condition.toString() = "+condition.toString());
		return postDao.hi_selectList(condition);
	}
	@Override
	public List<Map<String, Object>> hi_bloggerRankList() {
		return postDao.hi_bloggerRankList();
	}
	@Override
	public List<HashMap<String, Object>> hi_selectCommentRank(String id){
		return postDao.hi_selectCommentRank(id);
	}
	@Override
	public List<HashMap<String, Object>> hi_selectTodayCommentRank(HashMap<String, String> map){
		return postDao.hi_selectTodayCommentRank(map);
	}
	@Override
	public List<HashMap<String, Object>> hi_selectLoveRank(HashMap<String, String> map) throws Exception{
		return postDao.hi_selectLoveRank(map);
	}
	@Override
	public List<Map<String, Object>> hi_selectFollowerList(Map<String, Object> condition) throws Exception {
		logger.debug("dto.toString() = "+condition.toString());
		return postDao.hi_selectFollowerList(condition);
	}
	@Override
	public List<Map<String, Object>> hi_selectThemeList(Map<String, Object> condition) throws Exception {
		logger.debug("dto.toString() = "+condition.toString());
		return postDao.hi_selectThemeList(condition);
	}
	@Override
	public List<Map<String, Object>> hi_selectSearchList(Map<String, Object> condition) throws Exception {
		logger.debug("dto.toString() = "+condition.toString());
		return postDao.hi_selectSearchList(condition);
	}
	@Override
	public List<Map<String, Object>> hi_hashtagSearchList(Map<String, Object> condition) throws Exception {
		logger.debug("dto.toString() = "+condition.toString());
		return postDao.hi_hashtagSearchList(condition);
	}
	
	@Transactional
	@Override
	public int hi_insertList(List<Map<String, Object>> boxList) throws SQLException{
		int flagCnt = 0;
		for(Map<String, Object> map:boxList){
			int flag = boxDao.hi_insertMap(map);
			flagCnt += flag;
		}
		return flagCnt;
	}
	@Override
	public List<Map<String, Object>> getLovePost(Map<String, String> dto)throws SQLException{
	      return postDao.getLovePost(dto);
	}
	@Override
	public List<Map<String, Object>> getHashTag()throws SQLException{
		return postDao.getHashTag();
	}
	
	public Map<String, Object> hi_isFollower(Map<String, Object> map){
		return postDao.hi_isFollower(map);
	}
	
	public int hi_updatePostState(Map<String, String> data) {
		return postDao.hi_updatePostState(data);
	}
	
	
}
