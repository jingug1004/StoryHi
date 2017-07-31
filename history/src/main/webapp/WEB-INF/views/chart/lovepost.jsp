<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>블로그 관리/통계</title>
<%
	List<Map<String, Object>> lovepostList = new ArrayList<>();
	lovepostList = (List<Map<String, Object>>)request.getAttribute("lovepostList");
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
%>
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
.mydiv{
width:20%;
margin-right:0.5%;
border-radius: 15px;
}
.mydiv2{
width:78%;
margin-left:0.5%;
border-radius: 15px;
}
</style>
</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->

<!-- 중간 START -->
   <br><br><br><br>
   <div class="container" >
      <div class="col-xs-2 mydiv" style="background-color: <%=blogdto.getTheme() %>; border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: <%=blogdto.getTheme()%>;">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10" style="margin-top: 20px; margin-bottom : 20px; background-color: #FCFCFC;min-height: 500px">
		        <!-- 포스트-->
		        <div class="col-xs-12" style="background-color: white; padding-top: 20px;">
		 		<fieldset>
		       	<legend><i class="icon-heart"></i> 내가 공감한 글</legend></fieldset>
		       	
					<table class="table table-hover" style="margin-top: 20px" id="neighbor">
					<tr class="warning">
						<th width="15%" style="text-align: center;">ID</th>
						<th width="70%" style="text-align: center;">글제목</th>
						<th width="15%" style="text-align: center;">공감일</th>
					</tr>
					<%
						if(lovepostList!=null && lovepostList.size()!=0){
							for(int i = 0; i < lovepostList.size(); ++i){
					%>
						<tr class="default">
							<td style="text-align: center;font-weight: bold;"><a href="/post/main.hi?id=<%=lovepostList.get(i).get("ID")%>">
							<%=lovepostList.get(i).get("ID")+" "%></a>
							</td>
							<td style="font-size: 13px"><a href="/post/main.hi?id=<%=lovepostList.get(i).get("ID")%>&seq=<%=lovepostList.get(i).get("POST_SEQ")%>">
							<%=lovepostList.get(i).get("TITLE") %></a>
							</td>
							<td style="font-size: 13px;text-align: center;"><%=lovepostList.get(i).get("LDATE") %></td>
						</tr>
					<%
							}
					%>
						</table>
						<center>
							<ul class="pagination pagination-sm">
							 <li class="disabled"><a href="#">&laquo;</a></li>
							<%
							int tot = Integer.parseInt(lovepostList.get(0).get("TOT_CNT").toString())/5+1;
							if(request.getParameter("PAGE_NUM")==null){
								for(int i = 1; i<= tot; ++i){
									if(i==0){
								%>
									<li class="active"><a href="lovepost.hi?PAGE_NUM=<%=i %>"><%=i %></a></li>
								<%
									}else{
								%>
									<li><a href="lovepost.hi?PAGE_NUM=<%=i %>"><%=i %></a></li>
								<%
									}
								}
							}else{
								for(int i = 1; i<= tot; ++i){
								%>
									<li <%if((Integer.parseInt(request.getParameter("PAGE_NUM"))==i)){%>class="active"<%} %>><a href="lovepost.hi?PAGE_NUM=<%=i %>"><%=i %></a></li>
								<%
								}
							}
								%>
							<li><a href="#">&raquo;</a></li>
							</ul>
						</center>
					<%
						}else{
					%>
						<tr class="active">
						<td colspan="4" style="text-align: center;">회원님이 공감하신 글이 없습니다.</td> 
						</tr>
						</table>
					<%
						}
					%>
					
				</div>
				
	  		</div>
	  		<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>