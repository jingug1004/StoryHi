<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%
	List<Map<String, Object>> neighborList = new ArrayList<>();
	neighborList = (List<Map<String, Object>>)request.getAttribute("neighborList");
	
	List<Map<String, Object>> followList = new ArrayList<>();
	followList = (List<Map<String, Object>>)request.getAttribute("followList");
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
%>
<%!
	private static boolean checkFollow(String id, List<Map<String, Object>> followList){
		boolean flag = true;
		for(int i = 0 ; i < followList.size(); ++i){
			if(followList.get(i).get("ID").equals(id)){
				flag = false;
			}
		}
		return flag;
	}
%>
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>블로그 관리/통계</title>
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
<script>
function do_add(id) {
	//var id = $("#neighbor").find("td").eq(1).text();
	if(confirm(id + "을 이웃으로 추가 하시겠습니까?")){
		$("#addid").val(id);
		var frm = document.addForm;
		frm.submit();
	}
}
function do_cancel(id) {
	//var id = $("#neighbor").find("td").eq(1).text();
	if(confirm(id + "을 이웃에서 삭제 하시겠습니까?")){
		$("#addid").val(id);
		var frm = document.addForm;
		frm.submit();
	}
}
function do_del(id) {
	//var id = $("#neighbor").find("td").eq(1).text();
	if(confirm(id + "님을 정말로 차단하시겠습니까?")){
		$("#delid").val(id);
		var frm = document.delForm;
		frm.submit();
	}
}
</script>
</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->


<!-- 중간 START -->
   <br><br><br><br>
   <div class="container" >
		<form name="addForm" action="neighbor.hi" method="post">
			<input type="hidden" name="id" id="addid" value=""> <input
				type="hidden" name="addordel" value="add">
		</form>
		<form name="delForm" action="neighbor.hi" method="post">
			<input type="hidden" name="id" id="delid" value=""> <input
				type="hidden" name="addordel" value="del">
		</form>
		<div class="col-xs-2 mydiv" style="background-color: <%=blogdto.getTheme() %>; border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: <%=blogdto.getTheme() %>;">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10" style="margin-top: 20px; margin-bottom : 20px; background-color: #FCFCFC;min-height: 500px">
		        <!-- 나의 팔로우 보기  -->
		        <div class="col-xs-12" style="background-color: white; padding-top: 20px;">
<!-- 		 			<p style="font-size: 25px; margin-top: 20px">나의 팔로우 보기</p> -->
		 					 			<fieldset><legend>
		       	<i class="icon-group"></i> 나의 팔로우 보기</legend></fieldset>
					<table class="table table-hover" style="margin-top: 20px" id="neighbor">
					<tr class="info">
						<th>No</th>
						<th>ID [ 닉네임 ]</th>
						<th>블로그타이틀</th>
						<th style="text-align: center;">상태</th>
					</tr>
					<%
						if(neighborList!=null && neighborList.size()!=0){
							for(int i = 0; i < neighborList.size(); ++i){
					%>
						<tr class="default">
							<td><%=i+1 %></td>
							<td><a href="/post/main.hi?id=<%=neighborList.get(i).get("MY_ID")%>">
							<%=neighborList.get(i).get("MY_ID")+" "%> [ <%=neighborList.get(i).get("NAME")+" "%> ]</a>
							</td>
							<td><%=neighborList.get(i).get("TITLE") %></td>
							<td style="text-align: center;">
							<%
								if( checkFollow( (neighborList.get(i).get("MY_ID")).toString(),followList) ){
							%>
									<button type="button" class="btn-xs btn-info" id="addNeighbor" onclick="do_add('<%=neighborList.get(i).get("MY_ID")%>')">이웃추가</button>
							<%
								}else{
							%>
									<button type="button" class="btn-xs btn-info" id="addNeighbor" onclick="do_cancel('<%=neighborList.get(i).get("MY_ID")%>')">이웃취소</button>
							<%
								}
							%>
									<button type="button" class="btn-xs btn-danger" id="delNeighbor" onclick="do_del('<%=neighborList.get(i).get("MY_ID")%>')">차단</button>
							</td>
						</tr>
					<%
							}	//for end
					%>
						</table>
							<center>
							
<!-- 페이징 -->
							<ul class="pagination pagination-sm" >
							<li class="disabled"><a href="#">&laquo;</a></li>
							<%
							int tot = Integer.parseInt(neighborList.get(0).get("TOT_CNT").toString())/5+1;
							if(request.getParameter("PAGE_NUM")==null){
								for(int i = 1; i<= tot; ++i){
									if(i==1){
								%>
									<li class="active"><a href="neighbor.hi?PAGE_NUM=<%=i %>"><%=i %></a></li>
								<%
									}else{
								%>
									<li><a href="neighbor.hi?PAGE_NUM=<%=i %>"><%=i %></a></li>
								<%
									}
								}
							}else{
								for(int i = 1; i<= tot; ++i){
								%>
									<li <%if((Integer.parseInt(request.getParameter("PAGE_NUM"))==i)){%>class="active"<%} %>><a href="neighbor.hi?PAGE_NUM=<%=i %>">
									<%=i %></a></li>
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
						<td colspan="4" style="text-align: center;">회원님을 팔로우하는 회원이 없습니다.</td> 
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