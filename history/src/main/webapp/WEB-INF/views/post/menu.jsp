<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String id = request.getParameter("id");
	// 해당블로그 유저id 받아오기
	
	String ct_seq = request.getParameter("ct_seq");	
	if(ct_seq == null) ct_seq = "0";
	
	String state = request.getParameter("state");
	
	List<CategoryDto> categoryList = (List<CategoryDto>)request.getAttribute("categoryList");

	// 로그인 유저
	UserDto loginuser = (UserDto)session.getAttribute("user");

	// 블로그 주인
	UserDto userDto = (UserDto)request.getAttribute("userDto");
	
	// 등급 보여주기
	String user_grade = userDto.getGrade();
	String grades[] = {"몽땅연필", "색연필", "만년필"};
	
	Map<String, Integer> visit = new HashMap<>();
	visit = (Map<String, Integer>)request.getAttribute("visit");
	// 방문자 정보
	List<Map<String, Object>> visitList = (List<Map<String, Object>>)request.getAttribute("visitList");

	boolean follow = (Boolean)request.getAttribute("follow");
	List<HashMap<String, Object>> cateCount = (List<HashMap<String, Object>>)request.getAttribute("cateCount");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- 이웃추가버튼 스타일 -->
	<style type="text/css">
	.btn-glyphicon {
		padding: 5px;
		background: #ffffff;
		margin-right: 4px;
	}

/* 	.icon-btn {
		padding: 1px 15px 3px 2px;
		border-radius: 50px;
	} */
	</style>

	<script type="text/javascript">
		function delete_follow(loginId, blogId) {
            var my_id = loginId;
            var you_id = blogId;
            var command = "delete";
            $.ajax({
                type: "POST",
                url: "/followInsert.hi",
                datatype: "html",
                data: {
                    my_id: my_id,
                    you_id: you_id,
                    command: command
                },
                success: function () {
                    alert("이웃 삭제 되었습니다.");
                    location.reload();
                },
                error: function () {
                }
            });
        }

		function insert_follow(loginId, blogId) {
		    var my_id = loginId;
		    var you_id = blogId;
		    var command = "insert";
			$.ajax({
				type: "POST",
				url: "/followInsert.hi",
				datatype: "html",
				data: {
				    my_id: my_id,
					you_id: you_id,
					command: command
				},
				success: function (data) {
                    alert("이웃 추가 되었습니다.");
                    location.reload();
				},
				error: function (data) {

				}
			});
        }
	</script>
</head>
<body>
<center>
<br>

<!-- 블로그 주인의 프로필사진을 넣습니다 -->
<!-- class="img-responsive" 반응형 이미지 -->
<img src="<%=userDto.getPf_image() %>" class="img-responsive img-thumbnail" onerror="src='/resources/image/noimg.png'">
<br>

<!-- 블로그 주인의 닉네임을 넣습니다 -->
<h4><%=userDto.getName() %></h4>

<!-- 레벨 -->
<h5 style="color: #670000">{ <%=grades[Integer.parseInt(user_grade)]%>  
<img src="/resources/image/level<%=userDto.getGrade()%>.png" height="20px"> }</h5>

<!-- 블로그 주인의 블로그소개를 넣습니다 -->
<div style="word-wrap:break-word; word-break:break-all; font-size: 13px;">
<%=userDto.getPf_content() %>
</div>
<br>

<%
	if(loginuser != null){
		if(id.equals(loginuser.getId())){ %>
			<a href="write.hi?id=<%=id %>&ct_seq=<%=ct_seq %>&state=<%=state %>" class="btn btn-default btn-md">
			    <span class="glyphicon glyphicon-pencil"></span> 포스트쓰기
			</a>
		<% } else if(follow){ %>
			<a class="btn icon-btn btn-warning btn-sm" href="javascript:delete_follow('<%=loginuser.getId()%>', '<%=id%>')">
				<span class="glyphicon btn-glyphicon glyphicon-minus img-circle text-warning" style="font-size: 8px"></span>
				이웃삭제
			</a>
		<% } else { %>
			<a class="btn icon-btn btn-warning btn-sm" href="javascript:insert_follow('<%=loginuser.getId()%>', '<%=id%>')">
				<span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-warning" style="font-size: 8px"></span>
				이웃추가
			</a>
		<% } %>
<%}%>
<br>
<hr>

<!-- 카테고리 -->
<div class="list-group">
<a href="main.hi?id=<%=id%>" class="list-group-item btn-link" style="color: #F15F5F; background-color: #F6F6F6;" >
<h6>카테고리 전체글보기 &nbsp;<span class="glyphicon glyphicon-circle-arrow-right"></span></h6> 
</a>

  <%
  	for(int i = 0 ; i < categoryList.size(); ++i){
  %>
    <a class="list-group-item <%if(ct_seq.equals(categoryList.get(i).getSeq()+"")) out.println("active");%>" href="main.hi?ct_seq=<%=categoryList.get(i).getSeq() %>&id=<%=id%>&state=<%=categoryList.get(i).getState() %>" >
	    <span class="badge"><%=cateCount.get(i).get("TOTAL") %></span>		<!-- 카테고리별 글 갯수  -->
	    <%=categoryList.get(i).getName() %>
    </a>
  <%
  	}
  %>
</div>




<!--최근방문자  -->		
<div class="list-group">
      <div class="list-group-item" style="color: #4374D9; background-color: #F6F6F6;"><h6>방문자정보 <i class="icon-info-sign"></i> </h6></div>
      
        <%
		  	for(int i = 0 ; i < visitList.size(); ++i){
		  	  if(!visitList.get(i).get("ID").equals(id)){
		 %>
      
	      <div class="list-group-item">
			<span style="font-size: 10px"><%=visitList.get(i).get("ID") %></span> <!--닉네임  -->
			<span style="font-size: 13px"> <a href="/post/main.hi?id=<%=visitList.get(i).get("ID") %>" ><%=visitList.get(i).get("TITLE") %></a> </span><!--블로그제목  -->
			<br><span style="font-size: 10px"><%=visitList.get(i).get("VDATE") %></span><!--최근방문일  -->
		 </div>

		  <%
				  	}
				  	if (i ==4) break;
		  	}
		  %>
</div>


<!-- 방문자수 -->
<div class="panel panel-info">
      <div class="panel-heading"><h6>방문자수 <i class="icon-group"></i></h6></div>
      <div class="panel-body">
      	<strong>Today  <span style="font-size: 20px; color: red;"><%=visit.get("today") %></span></strong>
      	<br>
      	Total  <%=visit.get("total") %>
      </div>
</div>

</center>
</body>
</html>