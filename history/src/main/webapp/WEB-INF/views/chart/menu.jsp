<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<center>
<br>

<!-- 카테고리 -->
<div class="panel panel-info">
<div class="panel-heading">
    <h3 class="panel-title">관리</h3>
  </div>
<!-- 
	<h5> 관리 </h5> -->
	<div class="list-group" style="border: 3px; border-color: red;">
		<!-- <li class="list-group-item" style="color: #F15F5F; background-color: #F6F6F6;"><b>관리</b></li> -->
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("control")) out.println("active");%>" href="control.hi">블로그관리</a>
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("neighbor")) out.println("active");%>" href="neighbor.hi">나를 추가한 이웃</a>
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("lovepost")) out.println("active");%>" href="lovepost.hi">내가 공감한 글</a>
	</div>
</div>



<!-- 방문자수 -->
<div class="panel panel-info">
	<div class="panel-heading">
	    <h3 class="panel-title">통계</h3>
	</div>
	<div class="list-group">
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("visit")) out.println("active");%>" href="visit.hi">방문자수</a>
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("age")) out.println("active");%>" href="age.hi">성별 / 연령별</a>
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("follow")) out.println("active");%>" href="follow.hi">이웃증감수</a>
	</div>
</div>


<div class="panel panel-info">
	<div class="panel-heading">
	    <h3 class="panel-title">순위</h3>
	</div>
	<div class="list-group">
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("love.")) out.println("active");%>" href="love.hi">공감수 순위</a>
		<a class="list-group-item  <%if(request.getRequestURL().toString().contains("comment")) out.println("active");%>" href="comment.hi">댓글수 순위</a>
	</div>
</div>

</center>

