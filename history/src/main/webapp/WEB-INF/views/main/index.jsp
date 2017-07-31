<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%!
/**
 * 모든 HTML 태그를 제거하고 반환한다.
 * 
 * @param html
 * @throws Exception  
 */
	public String removeTag(String html) throws Exception {
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	//포스트 내용에서 이미지 하나 추출 함수
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
	String PAGE_NUM = "1"; //페이지NUM
	String PAGE_SIZE = "5"; //페이지SIZE
	int page_num = 1; //선택된 페이지
	int page_size = 5; //페이지 사이즈
	int intTotalCount = 0; //총 글수
	int pageCount = 0; //페이지 수
	Map<String, Object> dataCnt = null;
	List<Map<String, Object>> followList = null;
	List<Map<String, Object>> searchRank = (List<Map<String, Object>>)request.getAttribute("searchRank");
	List<Map<String, Object>> themeList = (List<Map<String, Object>>)request.getAttribute("themeList");
	List<Map<String, Object>> bloggerRank = (List<Map<String, Object>>)request.getAttribute("bloggerRank");
	
	List<Map<String, Object>> themeCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 100
	
	themeCode = (List<Map<String, Object>>)request.getAttribute("themeCode");
	
	if(session.getAttribute("user") != null){
		followList = (List<Map<String, Object>>)request.getAttribute("followList");
		
		PAGE_NUM = request.getAttribute("PAGE_NUM").toString();
		PAGE_SIZE = request.getAttribute("PAGE_SIZE").toString();
		
		if (followList != null && followList.size() > 0) {
			dataCnt = followList.get(0);
			intTotalCount = Integer.parseInt(dataCnt.get("TOT_CNT").toString());
		}
		pageCount = intTotalCount / page_size; // 페이지수
		
		if (intTotalCount % page_size != 0)
			pageCount++;
		if (PAGE_NUM != null && PAGE_NUM != "")
			page_num = Integer.parseInt(PAGE_NUM);
		if (PAGE_SIZE != null && PAGE_SIZE != "")
			page_size = Integer.parseInt(PAGE_SIZE);
		
	}	 
	int total = 0;
	for(int i = 0; i < searchRank.size(); ++i){
		total += Integer.parseInt((searchRank.get(i).get("CNT")).toString());
	}
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title> ★ hiStory ★ </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">

	<!-- Custom CSS  (이미지 동그란 모양으로 보이기)-->
    <link href="/resources/css/round-about.css" rel="stylesheet">
	  <script src="http://phuonghuynh.github.io/js/bower_components/jquery/dist/jquery.min.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/d3/d3.min.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/d3-transform/src/d3-transform.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/extarray.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/misc.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/micro-observer.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/microplugin/src/microplugin.js"></script>
	  <script src="/resources/js/bubble-chart.js"></script>
	  <script src="/resources/js/central-click.js"></script>
	  <script src="/resources/js/lines.js"></script>
	
 <!-- 해시태그 스타일 --> 
  <style type="text/css">
    .bubbleChart {
      min-width: 100px;
      max-width: 500px;
      height: 500px;
      margin: 0 auto;
    }
    .bubbleChart svg{
      background: #ffffff;
    }
  </style>
  
  <!-- 블로그 주제별 보기 스타일 -->
  <style type="text/css">
/* generic css */

.view {
  float: left; 
  overflow: hidden;
  position: relative;
  text-align: center;
  cursor: default;
}

.view .mask,
.view .content {
  width: 100%;
  height: 100%; 
  position: absolute;
  overflow: hidden;
  top: 0; 
  left: 0;
}

.view img {
  display: block; 
  position: relative
}

.view h2 {
  text-transform: uppercase;
  color: #fff;
  text-align: center;
  position: relative;
  font-size: 17px;
  padding: 10px;
  /* font-family: 'Hanna', sans-serif; */
  /*background: rgba(0, 0, 0, 0.8);*/
  margin: 20px 0 0 0
}

.view p {
  font-style: italic;
  font-size: 14px;
  position: relative;
  color: #fff;
  padding: 0px 20px 0px;
  text-align: center
}

.view a.info {
  display: inline-block;
  text-decoration: none;
  padding: 7px 14px;
  background: #000;
  color: #fff;
  /* font-family: 'Hanna', sans-serif; */
  text-transform: uppercase;
  box-shadow: 0 0 1px #000
}

.view a.info:hover {
  box-shadow: 0 0 5px #000
}
  

.view-first img {
  /*1*/
  transition: all 0.2s linear;
  width: 100%; 
  height: 70%;
}

.view-first .mask {
  opacity: 0;
  /* background-color: rgba(58, 1, 132, 0.44); */
  background-color: rgba(243, 97, 166, 0.44);
  transition: all 0.4s ease-in-out;
}

.view-first h2 {
  transform: translateY(-100px);
  opacity: 0;
/* font-family: 'Hanna', sans-serif; */
  transition: all 0.2s ease-in-out;
}

.view-first p {
  transform: translateY(100px);
  opacity: 0;
  transition: all 0.2s linear;
}

.view-first a.info {
  opacity: 0;
  transition: all 0.2s ease-in-out;
}


/* */

.view-first:hover img {
  transform: scale(1.4);
}

.view-first:hover .mask {
  opacity: 1;
}

.view-first:hover h2,
.view-first:hover p,
.view-first:hover a.info {
  opacity: 1;
  transform: translateY(0px);
}

.view-first:hover p {
  transition-delay: 0.1s;
}

.view-first:hover a.info {
  transition-delay: 0.2s;
}

</style>

</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
<br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->


<!-- 검색하기 -->
<form name="do_search" method="post" action="/main/do_search.hi">
<div class="col-xs-2"></div>
<div class="col-xs-8">
	<div class="form-group">
	  <div class="input-group"> 	
	    <span class="input-group-addon input-lg"><i class="glyphicon glyphicon-search"></i></span>
	     <input type="text" class="form-control input-lg" placeholder="검색어를 입력하세요" max="20" name="search_word" size=20>
	    <span class="input-group-btn">
	     <input type="button" class="btn btn-primary btn-lg" value="조 회" onclick="javascript:submit()">
	    </span>
	    
	  </div>
	</div>  
</div> 
<div class="col-xs-2"></div>
</form>
<br>

<!-- 사이즈 조절해서 사용하세요  -->
<!-- 해시태그 START -->
<script type="text/javascript">
$(document).ready(function () {
     var bubbleChart = new d3.svg.BubbleChart({
       supportResponsive: true,
       //container: => use @default
       size: 600,
       //viewBoxSize: => use @default
       innerRadius: 600 / 3.5,
       //outerRadius: => use @default
       radiusMin: 50,
       //radiusMax: use @default
       //intersectDelta: use @default
       //intersectInc: use @default
       //circleColor: use @default
       data: {
         items: [
            //데이터 받아오기
            <%
            if(searchRank != null){
	            for(int i=0; i<searchRank.size(); ++i){
	            %>
	                {text: '<%=searchRank.get(i).get("SEARCH_WORD") %>', count: '<%=searchRank.get(i).get("CNT") %>'},
	            <%
	            }
            }
            %>
         ],
         eval: function (item) {return item.count/<%=total%>*100;},
         classed: function (item) {return item.text.split(" ").join("");}
       },
       plugins: [
         {
           name: "central-click",
           options: {
             text: "(See more detail)",
             style: {
               "font-size": "12px",
               "font-style": "italic",
               "text-anchor": "middle",
               "fill": "white"
             },
             attr: {dy: "65px"},
             centralClick: function() {
             }
           }
         },
         {
           name: "lines",
           options: {
             format: [
               {// Line #0
                 textField: "count",
                 classed: {count: true},
                 style: {
                   "font-size": "28px",
                   "text-anchor": "middle",
                   fill: "white"
                 },
                 attr: {
                   dy: "0px",
                   x: function (d) {return d.cx;},
                   y: function (d) {return d.cy;}
                 }
               },
               {// Line #1
                 textField: "text",
                 classed: {text: true},
                 style: {
                   "font-size": "14px",
                   "text-anchor": "middle",
                   fill: "white"
                 },
                 attr: {
                   dy: "20px",
                   x: function (d) {return d.cx;},
                   y: function (d) {return d.cy;}
                 }
               }
             ],
             centralFormat: [
               {// Line #0
                 style: {"font-size": "50px"},
                 attr: {}
               },
               {// Line #1
                 style: {"font-size": "30px"},
                 attr: {dy: "40px"}
               }
             ]
           }
         }]
     });



   });
</script>
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 Start -->
<form name="do_searchTag" method="post" action="">
<input type="hidden" id="search_word" name="search_word" value="">
</form>
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 End -->
<div class="bubbleChart"></div>
<!-- 해시태그 END -->


<br><br><br><br>
<!-- 테마별보기 START -->
<div class="row" style="background-color: #F6F6F6; border-radius: 15px">
<div class="col-xs-12">
<center>
<div style="background-color: #F7F9F9;border-radius: 15px;padding-top: 1px;padding-bottom: 5px;margin-top: 10px">
 <h3 class="text-primary"><i class="icon-coffee"></i> 테마별보기</h3>  
  <%if(themeCode != null) {%>
  <ul class="nav nav-pills">
    <li class="active" style="width: 110px">
    <a data-toggle="pill" href="#menu1" style="font-weight: bold;margin-left: 15px">
    <%=themeCode.get(0).get("CD_D_NM") %></a></li>
    
<!-- 테마 목록 -->
    <%for(int i=1; i<themeCode.size(); ++i){ %>
  	  <li style="width: 110px"><a data-toggle="tab" href="#menu<%=i+1%>" style="font-weight: bold;">
  	  <%=themeCode.get(i).get("CD_D_NM") %></a></li>
    <%} %>
  </ul>
	</div>
<!-- 테마 선택시 내용보이기 -->
  <div class="tab-content">
    <br>
	
    <%for(int i=0; i<themeCode.size(); ++i){
    	if(i==0) {%>
    		<div id="menu<%=i+1 %>" class="tab-pane fade in active">
    	<%}else{ %>
    		<div id="menu<%=i+1 %>" class="tab-pane fade" style="cursor:pointer;">
    	<%}
    		int k = 0;
    		for(int j=0; j<themeList.size(); ++j){
    			if(themeList.get(j).get("FIELD").equals(themeCode.get(i).get("CD_D_NM"))){%>
    				<%k++;
    				  if(k<=3){ %>
    					<a href="/post/main.hi?id=<%=themeList.get(j).get("ID") %>&seq=<%=themeList.get(j).get("SEQ") %>">
	    				<div class="view view-first col-xs-4" style="padding-bottom: 15px; cursor: pointer;">
	    				
	    				<img src="<%=get_img(themeList.get(j).get("CONTENT")+"") %>" onerror='this.src="/resources/image/life.jpg"'
	    				style="height: 230px"/>
	    				
	    				<div class="mask" style="padding-bottom: 15px;">
	      				<h2>
	      				<%
	      					String title = themeList.get(j).get("TITLE")+"";
	      					if(title.length() >15){
	      						title = title.substring(0,15) + "...";
	      					} %>
	      					<%=title %> 
	 					</h2>
	      				<p>
	      					<%
	      					String tempContent = removeTag(themeList.get(j).get("CONTENT")+"");
	      					String content = tempContent;
	      					if(tempContent.length() >25){
		      					content = tempContent.substring(0,25) + "...";
	      					} %>
	      					<%=content %> 
	      				</p>
	      				<p><%=themeList.get(j).get("NAME") %></p>
	      				<p><%=themeList.get(j).get("BLOG_TITLE") %></p>
	    				</div>
	    				</div> 
	    				
    					</a>
    					
    				<%}else{%>
    					<a href="/post/main.hi?id=<%=themeList.get(j).get("ID") %>&seq=<%=themeList.get(j).get("SEQ") %>">
    					<div class="view view-first col-xs-4" style="padding-top: 15px; cursor: pointer;">
	    				<img src="<%=get_img(themeList.get(j).get("CONTENT")+"") %>" onerror='this.src="/resources/image/noimg.png"'
	    				style="height: 230px"/>
	    				<div class="mask" style="padding-top: 15px">
	      				<h2>
	      				<%
	      					String title = themeList.get(j).get("TITLE")+"";
	      					if(title.length() >15){
	      						title = title.substring(0,15) + "...";
	      					} %>
	      					<%=title %> 
						</h2>
	      				<p>
	      					<%
	      					String tempContent = removeTag(themeList.get(j).get("CONTENT")+"");
	      					String content = tempContent;
	      					if(tempContent.length() >25){
		      					content = tempContent.substring(0,25) + "...";
	      					} %>
	      					<%=content %> 
	      				</p>
	      				<p><%=themeList.get(j).get("NAME") %></p>
	      				<p><%=themeList.get(j).get("BLOG_TITLE") %></p>
	    				</div>
	    				</div>
	    				 
	    				</a>
    				<%	
    				  }
    				%>
	  				
    	<%			
    			}
    		}
    	%>
    	
    	</div>
    <%}//THEME별로 사진넣을 프레임 구분 %>
    
	</div>
	
	<%} //if(themeCode != null)끝%>	
	
	</div><!-- 탭컨텐츠 -->

	</center>
	<br>
	<div class="clearfix"></div><br>
</div>
<!-- 테마별보기 END -->


<!-- 이웃새글 START -->
<!-- 로그인전 =============================================================================== -->
<%
	if (session.getAttribute("user") == null) {
%>
		<br><br>
		<div class="row" style="background-color: #F6F6F6; border-radius: 15px">
		<div class="col-xs-12">
		<!-- 로그인후 =============================================================================== -->
<%
	} else {
%>
		<br><br>
		<div class="row" style="background-color: #F6F6F6	; border-radius: 15px">
		<div class="col-xs-12">
		<div style="background-color: #F9FFF7;border-radius: 15px;padding-top: 1px;padding-bottom: 5px;margin-top: 10px">
		 <h3 style="text-align: center;" class="text-success"><i class="icon-bullhorn"></i>  이웃새글</h3>
		 </div>
		 <div class="clearfix"></div><br>
		
		<table class="table table-hover" id="followTable">
			<tbody>
		<% if(followList != null && followList.size() != 0) {
			for(int i=0; i<followList.size(); ++i) { %>
				<tr name="follow_detail" style="cursor:pointer;">
					<td id="<%=followList.get(i).get("ID")%>" width="15%">
						<div>
							<a href="#" class="pull-left">
							<img src="<%=get_img(followList.get(i).get("CONTENT")+"") %>" width="130px" height="90px" onerror='src="/resources/image/noimg.png"'>
							</a>
						</div>
					</td>
					<td valign="top" id="<%=followList.get(i).get("SEQ")%>"  width="65%">
						<div style="word-wrap:break-word;word-break:break-all;">
							<h5 class="title">
<%								String tempTitle = followList.get(i).get("TITLE")+"";
								String title = tempTitle;
								if(tempTitle.length() > 40 ) {
									title = tempTitle.substring(0,40) + "...";
								}
%>
							<%= title%>
							</h5>
<%								String tempContent = removeTag(followList.get(i).get("CONTENT")+"");
								String content = tempContent;
								if(tempContent.length() > 100) {
									content = tempContent.substring(0,100) + "...";
								}
%>
							<p class="summary" style="word-wrap:break-word;word-break:break-all;font-size: 12px;"> <%= content%></p>
						</div>
					</td>
					<td align="right" valign="middle" width="10%" style="font-size: 12px">
						<%=followList.get(i).get("NAME") %>
					</td>
					<td align="right" valign="top" width="10%" style="font-size: 12px;color:#747474 ">
						<div style="display: block;">
							<%=followList.get(i).get("WDATE") %>
						</div>
					</td>
				</tr>
			</tbody>
<%		}%>
<%	} else {%>
			<tr>
				<td align="center">:::이웃의 새 글이 없습니다:::</td>
			</tr>
<%	} %>
		</table>
		
		<center> 
		<!-- 총글수, 현제page_no,페이지 사이즈, 10 --> 
		<table id="pageTable">
			<tbody>
				<tr>
					<td style="text-align: center;">
						<%=PagingUtil.renderPaging(intTotalCount, page_num, page_size, 5, "/main/followPost.hi", "do_search_page")%>
					</td>
				</tr>
			</tbody>
		</table>
		</center>
<%
}
%> 


</div>
</div>
<!-- 디테일 클릭시 해당 ID, SEQ 들고 폼전송 구간 Start -->
<form name="do_detail" method="get" action="">
<input type="hidden" id="id" name="id" value="">
<input type="hidden" id="seq" name="seq" value="">
</form>
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 End -->
<!-- 이웃새글 END -->
<script type="text/javascript">
$(document).ready(function () {
	$("[name=follow_detail]").click(function(){
		var frm = document.do_detail;
		frm.id.value = $(this).eq(0).find("td").eq(0).attr('id');	//id
		frm.seq.value = $(this).eq(0).find("td").eq(1).attr('id');	//seq
		console.log("frm.id.value=" + frm.id.value);
		console.log("frm.seq.value=" + frm.seq.value);
		frm.action = "/post/main.hi";
		frm.submit();
		
	});
	
	 $(document).on("click","[name=follow_detail]", function() {
		 var frm = document.do_detail;
		frm.id.value = $(this).eq(0).find("td").eq(0).attr('id');	//id
		frm.seq.value = $(this).eq(0).find("td").eq(1).attr('id');	//seq
		console.log("frm.id.value=" + frm.id.value);
		console.log("frm.seq.value=" + frm.seq.value);
		frm.action = "/post/main.hi";
		frm.submit();
	 });

 });

function do_search_page(url, page_num) {
	console.log(url + "\t" + page_num);
	<c:if test="${!empty sessionScope.user.id }">
    	var id = "${sessionScope.user.id}";
	</c:if>
	$.ajax({
		type : "POST",
		url : url,
		dataType : "html",
		data :{
			"PAGE_NUM" : page_num,
			"id": id
		},
		success : function(data){
			var followList = $.parseJSON(data);
			$( '#followTable > tbody').empty();
			$( '#pageTable > tbody').empty();
			if (followList.length == 0) {
				$('#followTable > tbody:last').append('<tr><td>::글이없습니다::</td></tr>');
            } else {
            	var html="";
                for (var i = 0; i < followList.length-1; i++) {
                	html +="<tr name=\"follow_detail\" style=\"cursor:pointer;\">";
                    html +="<td id=\"" +followList[i].ID +"\" width=\"15%\">";
        			html +="<div>";
        			html +="<a href=\"#\" class=\"pull-left\">";
        				var post_img = get_img(followList[i].CONTENT);
        			html +="<img src=\""+post_img+ "\" width=\"130px\" height=\"90px\" onerror='src=" +"\"/resources/image/noimg.png\"'>";
        			html +="</a>";
        			html +="</div>";
        			html +="</td>";
        			html +="<td valign=\"top\" id=\""+followList[i].SEQ+"\" width=\"65%\">";
        			html +="<div style=\"word-wrap:break-word;word-break:break-all;\">";
        			html +="<h5 class=\"title\">";	
        			
	        			var tempTitle = followList[i].TITLE;
	        			var title = tempTitle;
	        			if(tempTitle.length >50){
	        				title = tempTitle.substring(0,50) + "...";
	        			} 
        			html += title;        				
        			html +="</h5>";
        			
	        			var tempContent = removeTag(followList[i].CONTENT);
	        			var content = tempContent;
	        			if(tempContent.length >150){
	        				content = tempContent.substring(0,150) + "...";
	        			}
	        		html +="<p class=\"summary\" style=\"word-wrap:break-word;word-break:break-all;font-size: 12px\">"+ content + "</p>";
	        		html +="</div>";
	        		html +="</td>";
	        		html +="<td align=\"right\" valign=\"middle\" width=\"10%\" style=\"font-size: 12px\">";
        			html += followList[i].NAME;
      				html +="</td>";
        			html +="<td align=\"right\" valign=\"top\" width=\"10%\" style=\"font-size: 12px\">";
        			html +="<div style=\"display: block;\">";
        			html +=followList[i].WDATE;
        			html +="</div></td></tr>";
      			
                }
                $('#followTable > tbody:last').append(html);
                var pageHtml ="";
                
                pageHtml +="<tr><td style=\"text-align: center;\">";
                pageHtml += renderPaging(followList[0].TOT_CNT, followList[followList.length-1].PAGE_NUM, 5, 5, "/main/followPost.hi", "do_search_page");
                pageHtml +="</td></tr>";
                $('#pageTable > tbody:last').append(pageHtml);
                
               
            } 
		},
		complete : function(data){		
			
		},
		error : function(xhr, status, error) {
			alert("에러발생");
		}
	});
    function get_img(content){
    	start = parseInt(content.indexOf("src=")+5);
    	end = parseInt(content.indexOf("\"", start+1));
    	
    	return content.substring(start, end);	
    }
    
	function removeTag( html ) {
		return html.replace(/(<([^>]+)>)/gi, "");
	}
	
	function renderPaging(maxNum_i, currPageNoIn_i, rowsPerPage_i, bottomCount_i,
			url_i, scriptName_i) {
		var maxNum = parseInt("0"); // 총 갯수
		var currPageNo = parseInt("1"); // 현재 페이지 번호 : page_num
		var rowPerPage = parseInt("10"); // 한페이지에 보여질 행수 : page_size
		var bottomCount = parseInt("10"); // 바닥에 보여질 페이지 수: 10

		maxNum = parseInt(maxNum_i);
		currPageNo = parseInt(currPageNoIn_i);
		rowPerPage = parseInt(rowsPerPage_i);
		bottomCount = parseInt(bottomCount_i);

		var url = url_i; // 호출 URL
		var scriptName = scriptName_i; // 호출 자바스크립트

		// alert("maxNum " + maxNum +", currPageNo " + currPageNo+", rowPerPage " + rowPerPage+", bottomCount " + bottomCount);
		var maxPageNo   = parseInt((maxNum - 1) / rowPerPage) + 1;
		var startPageNo = parseInt((currPageNo - 1) / bottomCount) * bottomCount + 1;
		var endPageNo   = parseInt((currPageNo - 1) / bottomCount + 1) * bottomCount;	
		var nowBlockNo  = parseInt((currPageNo - 1) / bottomCount) + 1;
		var maxBlockNo  = parseInt((maxNum - 1) / bottomCount) + 1;		
		
		// alert("maxPageNo " + maxPageNo + ", startPageNo" + startPageNo + ", endPageNo" + endPageNo + ", nowBlockNo" + nowBlockNo + ", maxBlockNo" + maxBlockNo);
		
		var inx = parseInt("0");
		var html = "";
		if (currPageNo > maxPageNo) {
			return "";
		}

		html +="<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">";
		html +="<tr>";
		html +="<td class=\"list_num\">";
		html +="<ul class=\"pagination pagination-sm\"> 	                                                ";
		// <<
		if (nowBlockNo > 1 && nowBlockNo <= maxBlockNo) {
			html +="<li><a href=\"javascript:" + scriptName + "( '" + url+ "', 1 );\">  ";
			html +="&laquo;   ";
			html +="</a></li>      ";
		}

		// <
		if (startPageNo > bottomCount) {
			html +="<li><a href=\"javascript:" + scriptName + "( '" + url + "'," + (startPageNo - 1)+ ");\"> ";
			html +="<        ";
			html +="</a></li>     ";
		}

		// 1 2 3 ... 10	(숫자보여주기)
		for (inx = startPageNo; inx <= maxPageNo && inx <= endPageNo; inx++) {
			if (inx == currPageNo) {
				html +="<li class='active'><a href='#'>" + inx	+ "</a></li>";
				
			} else {
				html +="<li><a href=\"javascript:" + scriptName + "('" + url + "'," + inx+ ");\" class=\"num_text\">" + inx + "</a></li> ";
			}
		}
		
		// >
		if (maxPageNo >= inx) {
			html +="<li><a href=\"javascript:" + scriptName + "('" + url + "',"+ ((nowBlockNo * bottomCount) + 1) + ");\"> ";
			html +=">                       ";
			html +="</a></li>              ";
		}

		// >>
		if (maxPageNo >= inx) {
			html +="<li><a href=\"javascript:" + scriptName + "('" + url + "'," + maxPageNo+ ");\">      ";
			html +="&raquo;     ";
			html +="</a></li>    ";
		}
		html +="</ul>		";
		html +="</td>  	";
		html +="</tr>  	";
		html +="</table>   ";

		return html;
	}
}
</script>

<!-- BEST 블로거 START -->
<br><br>
<div class="row" style="background-color: #F6F6F6; border-radius: 15px">
<%
	if(bloggerRank != null){
%>
<div class="col-xs-12">
            <div style="background-color: #FCF8F7;border-radius: 15px;padding-top: 1px;padding-bottom: 5px;margin-top: 10px">
                <h3 style="text-align: center;" class="text-danger"><i class="icon-thumbs-up"></i> BEST 블로거 </h3>
            </div>
            <br>
<%
			for(int i=0; i<bloggerRank.size(); ++i){
%>

			<div class="col-xs-3 text-center">
                <center>
                <a href="post/main.hi?id=<%=bloggerRank.get(i).get("ID")%>">
                <img height="100px" width="100px"  class="img-circle img-center" src="<%=bloggerRank.get(i).get("PF_IMAGE") %>" onerror='src="/resources/image/girl.png"'>
                </a>
                </center>
                
                <h4><%=bloggerRank.get(i).get("NAME") %>
                    <br><small><%=bloggerRank.get(i).get("TITLE") %></small>
                </h4>
                <p style="word-wrap:break-word;word-break:break-all;"><%=bloggerRank.get(i).get("PF_CONTENT") %></p>
            </div>
<%
			}
%>
</div>
<%
	}
%>
</div>
</div>
</div>
</div>
<!-- BEST 블로거 END -->
</div><!-- 컨테이너 -->

<!--내용 END -->



<!--푸터 START -->
<jsp:include page="footer.jsp"/>
<!--푸터 START -->

</body>
</html>












