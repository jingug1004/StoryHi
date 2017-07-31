<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.Map"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.LoveDto"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.PostDto"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	// 해시태그 잘라서 보여주기
	public String[] split(String str){
		int count = 0;
		for(int i = 0; i < str.length(); ++i){
			if(str.charAt(i)=='#'){
				++count;
			}
		}
		if(count!=0){
			count = count-1;
		}
		String hashString[] = new String[count];
		for(int i = 0; i < hashString.length; ++i){
			hashString[i]="";
		}
		int start = 0;
		for(int i = 1; i < str.length(); ++i){
			if(str.charAt(i)!='#'){
				hashString[start]+=str.charAt(i);
			}else{
				++start;
			}
		}
		return hashString;
	}
%>

<%
	//IP받아오기
	if(session.getAttribute("user")==null){
		String ip = InetAddress.getLocalHost().getHostAddress();
		session.setAttribute("ip", ip);
	}
	// 로그인한 세션정보
	UserDto userDto = (UserDto) session.getAttribute("user");

	// 보여질 블로그 id
	String id		= request.getParameter("id");
	
	Date today = new Date();
	
	// 포스트 내용 1건 보여주기
	PostDto postDto = (PostDto)request.getAttribute("DTO");
	
	//
	String catest = "0";
	catest = (String) request.getAttribute("catest");

	int intTotalCount 	= 0;	// 총글수
	int intTotalCommentCount 	= 0;	// 총댓글수
	int page_num 		= 1;	// 선택된 글 페이지
	int co_page_num 		= 1;	// 선택된 댓글 페이지

	// 포스트 목록 가져오기
	List<HashMap<String, Object>> totalPostList = new ArrayList<HashMap<String, Object>>();
	totalPostList = (ArrayList<HashMap<String, Object>>)request.getAttribute("lists");
	HashMap<String, Object> postCnt = null;

	// 댓글 리스트 가져오기
	List<HashMap<String, Object>> commentList = new ArrayList<HashMap<String, Object>>();
	commentList = (ArrayList<HashMap<String, Object>>)request.getAttribute("commentList");
	HashMap<String, Object> commentCnt = null;

	if(postDto != null){
		String PAGE_NUM = (request.getAttribute("PAGE_NUM").toString() == null) ? "1" : request.getAttribute("PAGE_NUM").toString();	// 선택된 페이지

		String COMMENT_PAGE_NUM = (request.getAttribute("CO_PAGE_NUM").toString() == null) ? "1" : request.getAttribute("CO_PAGE_NUM").toString();	// 선택된 댓글 페이지
		
		page_num  = Integer.parseInt(PAGE_NUM);
		co_page_num  = Integer.parseInt(COMMENT_PAGE_NUM);

		if(totalPostList != null && totalPostList.size() > 0){
			postCnt = totalPostList.get(0);
			intTotalCount = Integer.parseInt(postCnt.get("TOT_CNT").toString());

			if(commentList != null && commentList.size() > 0) {
				commentCnt = commentList.get(0);
				intTotalCommentCount = Integer.parseInt(commentCnt.get("TOT_CNT").toString());
			}
		}	
	} else{
		postDto = new PostDto();
		postDto.setSeq(0);
	}
	
	String ct_seq = request.getParameter("ct_seq");	
	if(ct_seq == null) ct_seq = "0";

	// 공감갯수
	int loveCount = 0;
	List<Map<String, Object>> loveList = (List<Map<String, Object>>)request.getAttribute("loveCount");

	if(loveList != null && loveList.size() >0){
		loveCount = Integer.parseInt(loveList.get(0).get("TOT_CNT")+"");
	}

	//해당 포스트에 공감을 했는지 체크
	LoveDto loveCheck = (LoveDto)request.getAttribute("loveCheck");
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
	String THEME;
	// 테마 색깔 
	if(blogdto.getTheme().equals("DEFAULT_THEME")){
		THEME = "#747474";
	}else{
		THEME = blogdto.getTheme();
	}
%>    


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <!-- jquery -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">

<title><%=blogdto.getTitle()%></title>

<style type="text/css">
	.mydiv{						/* 왼쪽 메뉴 영역  */
		width:20%;
		margin-right:0.5%;
		border-radius: 15px;
	}
	.mydiv2{					/* 블로그 내용 영역 */
		width:78%;
		margin-left:0.5%;
		border-radius: 15px;
	}
	table,th{					/* 테이블 내 가운데 정렬 */
		text-align: center;
	}
	.tbList,#commentTable{		/* 글 목록의 글자크기 */
		font-size: 13px;
	}
</style>

<script type="text/javascript">
// 페이징
function do_search_page(url, page_num)
{
	  console.log(url+"\t"+page_num);
	 
	  var frm = document.postForm;
	  frm.PAGE_NUM.value = page_num;
	  frm.action = url;
	  frm.submit();
}

function do_comment_page(url, co_page_num) {
	console.log(url+"\t"+co_page_num);

	var frm = document.commentForm;
	frm.CO_PAGE_NUM.value = co_page_num;
	frm.action = url;
	frm.submit();
}
</script>

<script type="text/javascript">
/* 글 수정 */
function go_update(){
	var frm = document.postUdateForm;
	
	
	
	
	
	
	
	
	frm.submit();
}

/* 글 삭제 */ 
function go_delete(){
	
	var frm = document.postDeleteForm;
	if (confirm("정말 삭제할꺼임???????") == true){  
		frm.submit();
	}
}

</script>


</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->




<!-- 메인내용 START -->
   <br><br><br><br>
   <div class="container">
   
   <!--좌측 메뉴 START  -->
      <div class="col-xs-2 mydiv" style="background-color: <%=THEME %>; border-radius: 15px">
         <jsp:include page="/post/menu.hi"/>
      </div>
   <!--좌측 메뉴 END  -->
   
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: <%=THEME %>">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10" style="background-color: #FCFCFC; margin-top:20px; margin-bottom: 20px; border-radius: 15px;min-height: 1200px">
	        
	        
<!-- 글 내용 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★-->
		        <form name="postUdateForm" action="updateDetail.hi" method="get">			<!-- 글수정 -->
			        <input type="hidden" name="seq" value="<%=postDto.getSeq()%>">
			        <input type="hidden" name="id" value="<%=id%>">
			        <input type="hidden" name="postst" value="<%=postDto.getState() %>" />
			        <input type="hidden" name="catest" value="<%=catest%>">
		        </form>
		        <form name="postDeleteForm" action="delete.hi" method="get">				<!-- 글삭제 -->
			        <input type="hidden" name="seq" value="<%=postDto.getSeq()%>">
			        <input type="hidden" name="id" value="<%=id%>">
		        </form>
		        <form name="postForm" action="main.hi" method="get">						<!-- 페이지 열릴때, 페이지 새로고침할때  -->
			        <input type="hidden" name="PAGE_NUM" value="">
			        <input type="hidden" name="id" value="<%=id%>">
			        <input type="hidden" name="ct_seq" value="<%=ct_seq%>">
			        <input type="hidden" name="seq" value="<%=postDto.getSeq()%>">
		        </form>
		        <form name="commentForm" action="main.hi" method="get">						<!-- 댓글 누를때  -->
			        <input type="hidden" name="PAGE_NUM" value="<%=page_num%>">
			        <input type="hidden" name="CO_PAGE_NUM" value="">
			        <input type="hidden" name="id" value="<%=id%>">
			        <input type="hidden" name="seq" value="<%=postDto.getSeq()%>">
		        </form>
				<%
				if(postDto.getSeq() == 0){	// 글 내용 없을때
				%>
					<div class="col-xs-12">
							<br><br><br><br><br><br><br><br><br><br><br><br>
							<center><h3>해당 카테고리에 포스트가 없습니다.</h3>
							<h6 style="color: #050099">{비밀글이거나 이웃공개 글일수 있습니다}</h6>
							</center>
					</div>
		        <%}else if(postDto.getState().equals("1") && userDto == null ||
				            postDto.getState().equals("1") && !userDto.getId().equals(postDto.getId())){ //비공개 글일때 %>
			        <div class="col-xs-12">
				        <br><br><br><br><br>
				        <center><h3>해당 포스트는 비공개 포스트입니다.</h3></center>
				        <!-- 이건 실행이 안되는데 왜 넣은거야?? 어떻게 실행시킬수 있어?? 방법은??   -->
			        </div>
		        <%}else{  %>

		        <div class="col-xs-12" style="word-wrap:break-word;word-break:break-all;">
		        <table width="100%" >
		        <tr>
<!-- 포스트 제목 -->
		        <td width="80%" align="left" >
		        <h2 style="word-wrap:break-word;word-break:break-all;"><%=postDto.getTitle() %></h2>
		        </td>
		        
		        
		        
		        <td width="20%" rowspan="2" >
<!--공감하기  -->
		        <%
		       	 	if (loveCheck != null) {
		        %>
		        	<button class="btn btn-default btn-sm" style="color: red" id="postLove">♥ (<span id="postLoveCount"><%=loveCount %></span>)공감취소</button>
		        	<input type="hidden" id="loveState" value="loveDelete.hi">
		        <%
		       	 	}else{
		        %>
		       	 	<button class="btn btn-default btn-sm" style="color: red" id="postLove">♡ (<span id="postLoveCount"><%=loveCount %></span>)공감</button>
		       	 	<input type="hidden" id="loveState" value="loveInsert.hi">
		        <%} %>
<!--글 수정/삭제 버튼  -->
				<%if (userDto != null && id.equals(userDto.getId())) {%>
			        <br>
			        <button class="btn btn-danger btn-sm" onclick="javascript:go_update();" style="margin-top: 5px">글수정</button> 
			        <button class="btn btn-danger btn-sm" onclick="javascript:go_delete();" style="margin-top: 5px">글삭제</button>
				<%} %>
		        </td>		        
		        </tr>
		        
<!-- 포스트 작성일 -->
		        <tr>
		        <td align="left"><h6><%=postDto.getWdate() %></h6></td>
		        <td></td>
		        </tr>
		        </table>
		        
				<hr>		        
<!-- 포스트 내용 -->
				<div style="min-height: 100px"><%=postDto.getContent() %></div>
				</div>

		        <% if (postDto.getFileList() != null && postDto.getFileList().size() > 0) { %>
				<!-- 첨부파일 -->
				<div class="col-xs-12" style="word-wrap : break-word;" >
					<table class="board_view">
						<colgroup>
							<col width="25%"/>
							<col width="35%"/>
							<col width="10%"/>
							<col width="30%"/>
						</colgroup>
				        <tr>
		                <th scope="row">첨부파일</th>
		                <td colspan="3">
			                <form name="download" method="post">
				                <%
					                for(Map<String, Object> map : ((PostDto)postDto).getFileList()){
				                %>
				                <input type="hidden" name="IDX" id="IDX" value="<%=map.get("POST_SEQ")%>">
				                <a href="#" name="file"><%=map.get("ORI_NAME")%></a>
				                (<%=map.get("FILE_SIZE")%>kb)

				                <%
					                }
				                %>
			                </form>
		                </td>
		            	</tr>
	            	</table>
            	</div>
		        <% } %>

				<!-- 해시태그 부분 -->
				<div class="col-xs-12" style="margin-bottom: 10px;">
					<hr>
					<table align="left">
					<tr>
					<td>
						<button type="button" class="btn btn-default btn-sm disabled">
							<span class="glyphicon glyphicon-tags"></span> 태그
		                </button>
	               </td>
		        		<%
		        			if (postDto.getHashtag() != null) {
		        				String str[] = split(postDto.getHashtag());
		        				for(int i = 0; i < str.length; ++i){
		        		%>
		        		<td nowrap="nowrap" style="padding-left: 10px">
		        					<form name="search_hashtag" method="post" action="">
		        					<input type="hidden" name="search_word" value="<%=str[i]%>">
		        					<input type="hidden" name="only_hashtag" value="yes">
		        					<a href="#" name="hashtag"><%="#" + str[i] %></a>
		        					</form>
		        		</td>
		        		<%
		        				}
		        			}
		        		%>
        		
        		</tr>
        			</table>
				</div>
				
				<!-- 댓글 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★-->
				<div class="col-xs-12">
				<%
				if(postDto.getCo_state().equals("1")){
				%>
					<h5>댓글비허용</h5>
					<br>
					<hr>
					</div>
				<%}else{ %>
					<h5>댓글허용</h5>

					<!-- 댓글이 나올 테이블 -->
					<table class="table table-condensed" id="commentTable">
						<%
							if (commentList != null) {
									for (int i = 0; i < commentList.size(); i++) {
										HashMap<String, Object> commentdata = (HashMap<String, Object>) (commentList.get(i));
						%>
						<tr name="commentParentCode">
							<%
								// 댓글, 대댓글 구분
								if (!commentdata.get("PARENT").toString().equals(commentdata.get("SEQ").toString())) {
							%>
									<!--대댓글  -->
									<td style="width: 1%"><span class="glyphicon glyphicon-arrow-right"></span></td>
									<td width=10%>
							<%
								} else {
							%>
									<!--댓글-->
									<td width=11% colspan=2 align="left">
							<%
								}
							%>
									<!-- 사진  -->
									<img src="<%=commentdata.get("PF_IMAGE")%>"
								          width="40px" height="40px" onerror="src='/resources/image/noimg.png'">
									</td>
							<%
								// 내용부분 시작
								// 정상일 때
								if (commentdata.get("STATE").equals("0")) {
							%>
								<!-- 작성자/작성일 -->
								<td width="69%" style="text-align: left;" name="contentsTd">
									<a href="/post/main.hi?id=<%=commentdata.get("ID")%>"> <%=commentdata.get("NAME")%></a>
									<%=commentdata.get("WDATE")%><br>
									<!-- 댓글내용 -->
									<span name="contentsSpan" style="word-wrap:break-word;word-break:break-all;"><%=commentdata.get("CONTENT")%></span>
									<span name="contentsInput" hidden="hidden">
										<textarea rows="2" class="form-control" style="resize: none"><%=commentdata.get("CONTENT")%></textarea>
									</span>
								</td>
							<%
								// 댓글, 대댓글 부분 끝
								// 비밀글일때
							} else if (commentdata.get("STATE").equals("1")) {
									// 내용이 보이는 사람일 때
									if (userDto != null && userDto.getId().equals(commentdata.get("ID"))
											|| userDto != null && userDto.getId().equals(id)) {
							%>
											<!-- 작성자/작성일 -->
											<td width="69%" style="text-align: left;" name="contentsTd">
												<a href="#"> <%=commentdata.get("NAME")%></a>
												<%=commentdata.get("WDATE")%><br>
												<!-- 댓글내용 -->
												<span class="glyphicon glyphicon-lock" name="lockImg"></span>
												<span name="contentsSpan" style="word-wrap:break-word;word-break:break-all;"><%=commentdata.get("CONTENT")%></span>
												<%--댓글 수정시 나타나야할 textarea--%>
												<span name="contentsInput" hidden="hidden">
													<textarea rows="2" class="form-control" style="resize: none"><%=commentdata.get("CONTENT")%></textarea>
												</span>
											</td>
							<%
									} else {
							%>
									<td align="left" style="color: #8C8C8C;">
										<span class="glyphicon glyphicon-lock"></span>
										비밀글입니다
									</td>
							<%
									}
								// 삭제된 글일때
							} else if (commentdata.get("STATE").equals("2")) { //if end
							%>
								<td align="left" style="color: #BDBDBD;">
									<span class="glyphicon glyphicon-fire"></span>
									삭제된 댓글입니다
								</td>
							<%
							} // 내용부분 끝
							// 버튼부분 시작
							%>
							<td width="20%" align="right" id="<%=commentdata.get("SEQ")%>" name="buttonsTd">
								<!-- 로그인정보 없으면 안보임 -->
								<% if (userDto != null) { %>
								<% if ( commentdata.get("PARENT").toString().equals(commentdata.get("SEQ").toString())) {
									if ( commentdata.get("STATE").equals("0")
											|| commentdata.get("STATE").equals("1") && userDto.getId().equals(commentdata.get("ID"))
											|| commentdata.get("STATE").equals("1") && userDto.getId().equals(id)) { %>
								<button class="btn btn-default btn-xs" style="font-size: 12px" name="pAdd">답글</button>
								<% }} %>
								<% if (commentdata.get("STATE").equals("0") && userDto.getId().equals(commentdata.get("ID"))
										|| commentdata.get("STATE").equals("1") && userDto.getId().equals(commentdata.get("ID"))) { %>
								<button class="btn btn-default btn-xs" style="font-size: 12px" name="pUp" value="<%=commentdata.get("STATE")%>">수정</button>
								<button class="btn btn-default btn-xs" style="font-size: 12px" name="pDel">삭제</button>
								<% } %>
								<% } %>
								<div name="updateButtons" hidden="hidden" style="text-align: center;">
									<input type="checkbox" name="secretUpdate" value="<%=commentdata.get("STATE")%>" <%if(commentdata.get("STATE").equals("1")){%>checked<%}%>> 비밀글<br>
									<button type="button" name="updateButton" class="btn btn-warning" value="<%=commentdata.get("SEQ")%>">수정</button>
								</div>
							</td>
							<%--버튼부분 끝--%>
						</tr>
						<%--for문 닫음--%>
						<% } %>
					<%--if문 닫음--%>
					<% } %>
					</table>


					<%--댓글페이징--%>
					<%
						if (intTotalCommentCount != 0) {
					%>
					<center>
						<!-- Paging Area Start -->
						<%=PagingUtil.renderPaging(intTotalCommentCount, co_page_num, 5, 5, "main.hi", "do_comment_page")%>
						<!-- Paging Area end //--> 					<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->
					</center>
					<%
						}
					%>

					<!-- 로그인 정보 없으면 댓글창 안보여줌 -->
					<c:set var='login' value="${sessionScope.user}" />
					<c:if test="${!empty login}">
						<table class="table table-condensed">
							<!-- 기본 댓글 입력창(맨아래) -->
							<tr>
								<td width="11%" align="left">
									<img src="${sessionScope.user.pf_image}" width="40px" height="40px" onerror="src='/resources/image/noimg.png'">
								</td>
								<td width="69%">
									<textarea rows="2" class="form-control" style="resize: none" id="commentParentText"></textarea>
								</td>
								<td width="20%" align="left">
									<input type="checkbox" id="STATE" name="STATE" value="1">비밀글<br>
									<button type="button" id="commentParentSubmit" name="commentParentSubmit" class="btn btn-danger">댓글입력</button>
								</td>
							</tr>
						</table>
					</c:if>
				</div>
		        <%} //if end %>

<%} %>


				<!--글 목록 보여주기 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ -->
				

					<%
						if (totalPostList != null) {
					%>
					<div class="col-xs-12">
					<table class="table table-hover tbList">
					<tr class="warning">
						<th width="80%" >제목 <span style="font-size: 10px">(댓글갯수)</span></th>
						<th width="20%">작성일</th>
					</tr>
					<%
							for (int i = 0; i < totalPostList.size(); i++) {
					
								HashMap<String, Object> mapdatas = (HashMap<String, Object>) (totalPostList.get(i));
								String wdate = ((mapdatas.get("WDATE")).toString()).substring(0, 10);
					%>
					<tr>
						<%-- <td><%=i+1 %></td> --%>
						<td align="left">
						<div style="word-wrap:break-word;word-break:break-all;">
							<a href="/post/main.hi?seq=<%=mapdatas.get("SEQ") %>&id=<%=id%>&PAGE_NUM=<%=page_num%>"> <%=mapdatas.get("TITLE") %></a>
							<span style="color: #212121; font-weight: bold; font-size: 10px"> (<%=mapdatas.get("CO_CNT") %>)</span>

							<%
							if(mapdatas.get("STATE").toString().equals("1")){	// 비밀글
							%>
							<span class="label label-default">비밀</span>
							 <%}else if(mapdatas.get("STATE").toString().equals("3")){ %>
							 <span class="label label-primary">이웃공개</span>
							 <%} %>
						</div></td>
						<td><%=wdate %></td>
					</tr>
					
					<%} //FOR END%>
					</table>
					
					<center>
						<!-- Paging Area Start -->
						<%=PagingUtil.renderPaging(intTotalCount, page_num, 5, 5, "main.hi", "do_search_page")%>
						<!-- Paging Area end //--> 					<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->	
					</center>
					</div>
					
					<%} // IF END%>					
					
	  		</div>
	  		<div class="col-xs-1"></div>
  		</div>
</div>


<!--메인내용 END -->



























<script type="text/javascript">
	function fn_downloadFile(obj){
		var frm = document.download;
		//var idx = obj.parent().find("#IDX").val();


		frm.action = "downloadFile.hi";

		frm.submit();

	}//파일다운로드
	
$(function(){
	$("[name='hashtag']").on("click", function(e){ //파일 이름
		var frm = $(this).parent();
		frm.attr("action", "/main/do_search.hi");
		frm.submit();
	});
	
	$("[name='file']").on("click", function(e){ //파일 이름
		e.preventDefault();
		fn_downloadFile($(this));
	});
// 글 공감 ajax
	$("#postLove").bind("click", function() {
		 
		var loveState = document.getElementById('loveState').value;
		var postLoveCount = Number($('#postLoveCount').text());
		console.log("postLoveCount = "+$('#postLoveCount').text());

		$.ajax({
			type:"POST",
			url:loveState,			// 컨트롤러에 보낼 이름
			dataType:"html",
			data:{
				"seq" 	: <%=postDto.getSeq()%>
				
			},
			success:function(data){
				console.log("data"+data);
				var flag = $.parseJSON(data);

				if (flag.msg=="intrue") {
					document.getElementById('postLove').innerHTML ="♥ (<span id=\"postLoveCount\">"+(postLoveCount+1)+"</span>) 공감취소";
					document.getElementById('loveState').value = "loveDelete.hi";
				}else if(flag.msg=="deltrue") {
					document.getElementById('postLove').innerHTML ="♡ (<span id=\"postLoveCount\">"+(postLoveCount-1)+"</span>) 공감";
					document.getElementById('loveState').value = "loveInsert.hi";
				}

			},
			complete : function(data) {
				// 실패, 성공 상관없이 무조건 수행
			},
			error:function(){
				 alert("로그인이 필요하다아아아~~!!!");
			}
		});  
		
	});

       
//제일 하단에 있는 depth1의 댓글을 다는 이벤트=========================================================
    $("#commentParentSubmit").click(function( event ) {
           
        var pText = $("#commentParentText");
        // true면 비밀글임(상태 1로 넣어야 함)
        var stateYN = $("input[name='STATE']").is(":checked")==true;   
           
        console.log("true면 비밀글임 stateYN = " + stateYN);
        
        if($.trim(pText.val())==""){
            alert("내용을 입력하세요.");
            pText.focus();
            return;
        }
		var d = new Date();
		var today =    d.getFullYear() + "-" +
					("00" + (d.getMonth() + 1)).slice(-2) + "-" +
					("00" + d.getDate()).slice(-2) +
	 				("00" + d.getHours()).slice(-2) + ":" +
					("00" + d.getMinutes()).slice(-2) + ":" +
					("00" + d.getSeconds()).slice(-2)					
					
        // 댓글로 들어갈 내용
        var commentParentText = '<tr id="r1" name="commentParentCode">'+
                                '<td colspan=2 width=11% align="left">'+
                                '<img src="${sessionScope.user.pf_image}" width="40px" height="40px">'+
                                '</td>'+
                                '<td width="69%" style="text-align: left;" name="contentsTd">'+
                                '</span> <a href="#">${sessionScope.user.name}</a> '+today+' <br> '+
                                pText.val().replace(/\n/g, "<br>")+'</td>'+
                                '<td width="20%" align="right">'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pAdd">답글</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pUp">수정</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pDel">삭제</button>'+
                                '</td>'+
                                '</tr>';
           
        $.ajax({
			type:"POST",
			url:"replyInsert.hi",			// 컨트롤러에 보낼 이름
			dataType:"html",
			data:{
				"POST_SEQ" 	: <%=postDto.getSeq()%>,
 				"STATE"	 	: stateYN,
				"CONTENT" 	: pText.val()
			},
			success:function(data){
				console.log("data"+data);
				var flag = $.parseJSON(data);
				
				if (flag.msg=="true") {			// 댓글이 정상적으로 insert되면 화면에 보여주기
			        location.reload();
				} else {
					alert("댓글등록 실패");
				}
			},
			complete : function(data) {
				// 실패, 성공 상관없이 무조건 수행
			},
			error:function(){
				 alert("에러냐아아앙!!! ");
			}
		});  
    });


//댓글의 댓글을 다는 이벤트 ====================================================================================
    $(document).on("click","#commentChildSubmit", function(){
           
    	console.log("댓글부모번호2="+$(this).parent().attr('id'));
    	
        var cText = $("#commentChildText");
        var stateYN = $("input[name='STATE']").is(":checked")==true;   
        
        console.log("true면 비밀글임 stateYN = " + stateYN);
        
        var d = new Date();
		var today =    d.getFullYear() + "-" +
					("00" + (d.getMonth() + 1)).slice(-2) + "-" +
					("00" + d.getDate()).slice(-2) +
					("00" + d.getHours()).slice(-2) + ":" +
					("00" + d.getMinutes()).slice(-2) + ":" +
					("00" + d.getSeconds()).slice(-2)	
           
        if($.trim(cText.val())==""){
            alert("내용을 입력하세요. 대댓글!!");
            cText.focus();
            return;
        }
					
					
        // 대댓글로 들어갈 내용
        var commentChildText = '<tr name="commentChildCode">'+
        						'<td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td> '+
                                '<td width=10% align="left">'+
                                '<img src="${sessionScope.user.pf_image}" width="40px" height="40px">'+
                                '</td>'+
                                '<td width="69%" style="text-align: left;" name="contentsTd">'+
                                '</span> <a href="#">${sessionScope.user.name}</a> '+today+' <br> '+
                                cText.val().replace(/\n/g, "<br>")+'</td>'+
                                '<td width="20%" align="right">'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pUp">수정</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pDel">삭제</button>'+
                                '</td>'+
                                '</tr>';
                                
                                
        
        $.ajax({
			type:"POST",
			url:"rereInsert.hi",			// 컨트롤러에 보낼 이름
			dataType:"html",
			data:{
				"POST_SEQ" 	: <%=postDto.getSeq()%>,
				"PARENT"	: $(this).parent().attr('id'),
 				"STATE"	 	: stateYN,
				"CONTENT" 	: cText.val()
			},
			success:function(data){
				console.log("data"+data);
				var flag = $.parseJSON(data);
				
				if (flag.msg=="true") {			// 댓글이 정상적으로 insert되면 화면에 보여주기
					setTimeout(location.reload.bind(location), 1);
				} else {
					alert("댓글등록 실패");
				}
			},
			complete : function(data) {
				// 실패, 성공 상관없이 무조건 수행
			},
			error:function(){
				 alert("에러냐아아앙!!! ");
			}
		});                                
           
           
    });

    // 댓글 수정
	$("[name=updateButton]").on("click", function () {
		var content = $(this).parent().parent().parent().find("[name=contentsInput]").find("textarea").val();
		var secret = "0";
		if ($(this).parent().find("[name=secretUpdate]").is(":checked")==true)
			secret = "1";
		var commentSeq = $(this).val();


		$.ajax({
			type: "POST",
			url: "replyUpdate.hi",
			datatype: "html",
			data: {
				"commentSeq" : commentSeq,
				"STATE" : secret,
				"content" : content
			},
			success: function (data) {
				var flag = $.parseJSON(data);
				if (flag.msg=="true") {
					location.reload();
				} else {
					alert("댓글 수정 실패");
				}
			},
			error: function () {
				alert("에러남");
			}
		});
	});
       
    //답글 눌렀을때 에디터 창을 뿌려주는 이벤트, 삭제링크를 눌렀을때 해당 댓글을 삭제하는 이벤트
    $(document).on("click","table#commentTable button", function(){//동적으로 버튼이 생긴 경우 처리 방식

        if($(this).attr("name")=="pDel"){
        	console.log("댓글번호"+$(this).parent().attr('id'));
        	
            if (confirm("정말 삭제하시겠습니까?") == true){    //확인
                   
                var delComment = $(this).parent().parent();
                var nextTr = delComment.next();
                var delTr;
                
                $.ajax({
        			type:"POST",
        			url:"replyDelete.hi",			// 컨트롤러에 보낼 이름
        			dataType:"html",
        			data:{
        				"seq" 	: $(this).parent().attr('id')
        			},
        			success:function(data){
        				console.log("data"+data);
        				var flag = $.parseJSON(data);
        				
        				if (flag.msg=="true") {			// 댓글이 정상적으로 insert되면 화면에 보여주기
					        location.reload();
        				} else {
        					alert("댓글삭제 실패");
        				}
        			},
        			complete : function(data) {
        				// 실패, 성공 상관없이 무조건 수행
        			},
        			error:function(){
        				 alert("에러냐아아앙!!! ");
        			}
        		});  
                
            }else{   //취소
                return;
            }
        }else if($(this).attr("name")=="pAdd"){
             //자기 부모의 tr을 알아낸다.
            var parentElement = $(this).parent().parent();
            
            console.log("댓글부모번호 ="+$(this).parent().attr('id'));
            
            //댓글달기 창을 없앤다.
            $("#commentEditor").remove();
            	
            //부모의 하단에 댓글달기 창을 삽입
            var commentEditor = '<tr id="commentEditor">'+
                                '<td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td>'+
                                '<td style="width:10%">'+
                                '<img src="${sessionScope.user.pf_image}" width="40px" height="40px" onerror="src=\'/resources/image/noimg.png\'"></td>'+
                                '<td width="69%">'+
                                '<textarea rows="2" class="form-control" style="resize: none" id="commentChildText"></textarea>'+
                                '</td>'+
                                '<td width="20%" align="left" id="'+$(this).parent().attr('id')+'">'+
                                '<input type="checkbox" id="STATE" name="STATE" value="1"> 비밀글<br>'+
                                '<button type="button" id="commentChildSubmit" name="commentChildSubmit" class="btn btn-warning">답글입력</button>'+
                                '</td>'+
                                '</tr>';
                                   
            parentElement.after(commentEditor); 
        }else if($(this).attr("name")=="pUp"){
	        var already = $(this).html();

	        // 모든 글을 원래대로
	        $("[name=pUp]").html("수정");
	        $("[name=lockImg]").show();
	        $("[name=contentsSpan]").show();
	        $("[name=pAdd]").show();
	        $("[name=contentsInput]").hide();
	        $("[name=updateButtons]").hide();

	        if( already == "수정취소") return;

	        // 수정 버튼 누른 tr 변경
	        var parentTr = $(this).parent().parent();
	        parentTr.find("[name=contentsTd]").find("[name=lockImg]").hide();
	        parentTr.find("[name=contentsTd]").find("[name=contentsSpan]").hide();
	        $(this).parent().find("[name=pAdd]").hide();
	        parentTr.find("[name=contentsTd]").find("[name=contentsInput]").show();
	        parentTr.find("[name=buttonsTd]").find("[name=updateButtons]").show();
	        $(this).html("수정취소");

        }

    });
       
});
</script>

<span id="commentUpdateForm">

</span>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>