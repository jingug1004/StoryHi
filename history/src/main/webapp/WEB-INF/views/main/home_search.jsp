<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%!
/**
 * 모든 HTML 태그를 제거하고 반환한다.
 * 
 * @param html
 * @throws Exception  
 */
	public String removeTag(String content) throws Exception {
	Pattern SCRIPTS = Pattern.compile("<script([^'\"]|\"[^\"]*\"|'[^']*')*?</script>",Pattern.DOTALL);
	Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);
//		Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
	Pattern TAGS = Pattern.compile("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>");
	Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
	Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
	Pattern WHITESPACE = Pattern.compile("\\s\\s+");		

	Matcher m;
			
	m = SCRIPTS.matcher(content);
	content = m.replaceAll("");
	m = STYLE.matcher(content);
	content = m.replaceAll("");
	m = TAGS.matcher(content);
	content = m.replaceAll("");
	m = ENTITY_REFS.matcher(content);
	content = m.replaceAll("");
	m = WHITESPACE.matcher(content);
	content = m.replaceAll(" "); 		

	return content;
	}

	public String get_img(String content){
		Pattern p = Pattern.compile("\\<img(.*?)\\>");
		Matcher m = p.matcher(content);
		while(m.find()){
			
			
			int start = m.group(1).indexOf("src=")+5;
			int end = m.group(1).indexOf("\"", start+1);
			String result = m.group(1).substring(start, end);
			return result;
		}
		return null;
	}

%>

<%
	response.setHeader("Pragma", "no-cache"); //11
	response.setHeader("Cache-Control", "no-cache");//22페이지 캐쉬를 사용하도록 처리하여 브라우저에게 해당 페이지 내용을 매번 새로 요청하지 않고 캐싱하여 페이지를 볼수 있도록 지시한다. 

	List<Map<String, Object>> searchList = (List<Map<String, Object>>)request.getAttribute("searchList");
	String search_word = (String)request.getAttribute("search_word");
	String PAGE_NUM = "1"; //페이지NUM	
	PAGE_NUM = request.getAttribute("PAGE_NUM").toString();
	int page_num = 1; //선택된 페이지
	int page_size = 10; //페이지 사이즈
	int intTotalCount = 0; //총 글수
	Map<String, Object> dataCnt = null;
	if (searchList != null && searchList.size() > 0) {
		dataCnt = searchList.get(0);
		intTotalCount = Integer.parseInt(dataCnt.get("TOT_CNT").toString());
	}
	
	int pageCount = intTotalCount / page_size; // 페이지수
	if (intTotalCount % page_size != 0)
		pageCount++;
	if (PAGE_NUM != null && PAGE_NUM != "")
		page_num = Integer.parseInt(PAGE_NUM);
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="No-Cache"> 
<meta http-equiv="Pragma" content="No-Cache"> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title> ★ hiStory ★ </title>
    <!-- Bootstrap CSS -->
    
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style type="text/css">
/* 	.table-filter {
	background-color: #fff;
	border-bottom: 1px solid #eee;
} */
/* .table-filter tbody tr td {
	vertical-align: middle;
	border-top-color: #eee;
}
.table-filter tbody tr.selected td {
	background-color: #eee;
}
.table-filter tr td:first-child {
	width: 38px;
} 
.table-filter tr td:nth-child(2) {
	width: 35px;
}
.table-filter .media-photo {
	width: 35px;
} */
.table-filter .media-body {
    display: block;
    /* Had to use this style to force the div to expand (wasn't necessary with my bootstrap version 3.3.6) */
}
.table-filter .media-meta {
	font-size: 10px;
	color: #999;
}
.table-filter .media .title {
	color: #2BBCDE;
	font-size: 10px;
	font-weight: bold;
	line-height: normal;
}
/* .table-filter .media .title span {
	font-size: .8em;
	margin-right: 20px;
} */
.table-filter .media .title span.pagado {
	color: #5cb85c;
}
.table-filter .media .title span.pendiente {
	color: #f0ad4e;
}
.table-filter .media .title span.cancelado {
	color: #d9534f;
}
.table-filter .media .summary {
	font-size: 13px;
}
	</style>
</head>
<body>

<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->
	
<!-- 검색하기 -->
<form name="do_search" method="post" action="/main/do_search.hi">
<input type="hidden" name="PAGE_NUM" value="">
<div class="col-xs-2"></div>
<div class="col-xs-8">
	<div class="form-group">
	  <div class="input-group"> 	
	    <span class="input-group-addon input-lg"><i class="glyphicon glyphicon-search"></i></span>
	     <input type="text" class="form-control input-lg" id="search_word" name="search_word" size=20 value="<%= search_word%>">
	    <span class="input-group-btn">
	     <input type="button" id="search_sumit" class="btn btn-primary btn-lg" value="조 회">
	    </span>
	    
	  </div>
	</div>  
</div> 
<div class="col-xs-2"></div>
</form>
<br>

<!-- HISTORY START -->

<br><br>
<div class="col-xs-12" >
<hr style="border-color: #F361A6; border-width: 10px">
<h3 style="color: #F361A6"> :: HISTORY 검색결과 :: </h3>
<table class="table table-hover">

<%for(int i=0; i<searchList.size(); ++i){ %>
<tr name="search_detail" style="cursor:pointer;">

<!--이미지  -->
	<td id="<%=searchList.get(i).get("ID")%>" width="10%" align="center">
	<div class="media">
		<a href="#" class="pull-left">
		<img src='<%=get_img(searchList.get(i).get("CONTENT")+"") %>'height="90px" width="100%" onerror="src='/resources/image/noimg.png'">
		</a>
	</div>
	</td>
	
	<td valign="top" id="<%=searchList.get(i).get("SEQ")%>" width="70%" style="word-wrap:break-word;word-break:break-all;">
		<div class="media-body" style="word-wrap:break-word;word-break:break-all;" >
<!--글제목  -->
		<h5 class="title" style="color: #87003A">
		<%String tempTitle = searchList.get(i).get("TITLE")+"";
			String title = tempTitle;
			if(tempTitle.length() >50){
				title = tempTitle.substring(0,50) + "...";
			}
			title = title.replace(search_word, "<b>" + search_word + "</b>");
		%>
		<%= title%>
		</h5>
<!--글내용 -->		
		<%String tempContent = removeTag((String)searchList.get(i).get("CONTENT"));
			String content = tempContent;
			if(tempContent.length() >150){
				content = tempContent.substring(0,150) + "...";
			}
			// 줄바꿈 안되어서 검색어 굵은글씨는 뺐습니다 ㅠ
			//content = content.replace(search_word, "<b>" + search_word + "</b>");
		%>
		<p style="font-size: 12px;word-wrap:break-word;word-break:break-all;"><%= content%></p>
		
		
		
		<%if(searchList.get(i).get("HASHTAG")!=null){ 
			String hashtag = (String)searchList.get(i).get("HASHTAG");
			hashtag = hashtag.substring(0, hashtag.length()-1);
			hashtag = hashtag.replace("#" + search_word, "#" + "<b>" + search_word + "</b>");
			%>
			<!--해시태그  -->
			<div style="color: #2457BD;font-size: 13px"><%= hashtag%></div>
		<%} %>
		</div>
		
	</td>
<!--블로그이름  -->	
	<td align="right" valign="middle" width="10%" style="font-size: 12px">
	<%=searchList.get(i).get("BLOG_TITLE") %>
	</td>
<!-- 작성일 -->	
	<td align="right" valign="top" width="10%">
	<div class="media-body" style="font-size: 12px;color:#747474 ">
	<%=searchList.get(i).get("WDATE") %>
	</div>
	</td>
</tr>

<%} %>
</table>	

<center> 
<!-- 총글수, 현제page_no,페이지 사이즈, 10 --> 
<table><tr><td style="text-align: center;">
<%=PagingUtil.renderPaging(intTotalCount, page_num, page_size, 5, "do_search.hi", "do_search_page")%>
</td></tr>
</table>
</center>


</div>


<!-- 디테일 클릭시 해당 ID, SEQ 들고 폼전송 구간 Start -->
<form name="do_detail" method="get" action="">
<input type="hidden" id="id" name="id" value="">
<input type="hidden" id="seq" name="seq" value="">
</form>
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 End -->

<script type="text/javascript">

$(document).ready(function () {
	$("tr[name=search_detail]").click(function(){
		
		var frm = document.do_detail;
		frm.id.value = $(this).eq(0).find("td").eq(0).attr('id');	//id
		frm.seq.value = $(this).eq(0).find("td").eq(1).attr('id');	//seq
		console.log("frm.id.value=" + frm.id.value);
		console.log("frm.seq.value=" + frm.seq.value);
		frm.action = "/post/main.hi";
		frm.submit();
	});
	

 });
 
$(document).ready(function () {
	$("tr[name=api_search_detail]").click(function(){
		
		url = $(this).eq(0).find("td").eq(0).attr('id');	//link
	
		
		window.open(url);
	});
	
	$("#search_sumit").click(function(){
		var frm = document.do_search;
	   $("#search_word").val(removeSomechar($("#search_word").val()));
	   
	   frm.submit();
	});

 });
 
function removeSomechar( html ) {
	html = html.replace(/`/gi, "&#96;");
	html = html.replace(/'/gi, "&#39;");
	return html;
}
 
function do_search() {
	var frm = document.searchForm;
	frm.submit();
}

function do_search_page(url, page_num) {
	console.log(url + "\t" + page_num);

	var frm = document.do_search;
	frm.PAGE_NUM.value = page_num;
	console.log("frm.page_num.value=" + frm.PAGE_NUM.value);
	frm.action = url;
	frm.submit();

}
</script>
<!--페이징  -->

<!-- HISTORY END -->


<!-- 네이버 검색결과 START -->
<br><br>
<c:set var="item" value="${blogItem }"/>
<c:choose>
	<c:when test="${empty item}">

    </c:when>
	<c:otherwise>
			<div class="col-xs-12">
			<hr style="border-color: #2F9D27; border-width: 10px">
				<h3 style="color: #2F9D27"> :: 네이버 검색결과 :: </h3>
				<table  class="table table-hover">		
					<c:forEach var="item" items="${blogItem}">
					 	<tr name="api_search_detail" style="cursor:pointer;">	
					 		<td valign="top" id="${item.link }" width="80%">
							<div class="media-body">
		
							<h5 class="title" style="color: #003E00">
							${item.title }
							</h5>
							
							<!--내용  -->
							<p class="summary" style="font-size: 12px">${item.description}</p>
							</div>
						
							</td>
							<td align="right" valign="middle" width="10%" style="font-size: 12px">
							${item.bloggername }
							</td>
							<td align="right" valign="top" width="10%">
							<div class="media-body" style="font-size: 12px">
							<fmt:parseDate var="dateString" value="${item.postdate }" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/>
							</div>
							</td>
					 	</tr>
					</c:forEach>
				</table>
				</div>
    </c:otherwise> 
</c:choose>



<!-- 네이버 검색결과 END -->
</div>
<!--푸터 START -->
<jsp:include page="footer.jsp"/>
<!--푸터 START -->
</body>
</html>