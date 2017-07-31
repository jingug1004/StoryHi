<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	

</head>
<body>

<!--헤더 START-->
<jsp:include page="header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->
<br><br>
<div class="jumbotron">
<h1 align="center">LOGIN</h1>
<%
	if (request.getAttribute("fail") != null) {
%>
		<h6 align="center" style="color: red"><%=request.getAttribute("fail")%></h6>
<%
	}
%>
<br><br>
<div class="col-xs-2"></div>	<!--여백용  -->
	<div class="col-xs-8">
		<form action="/main/login.hi" method="post">
			<input type="hidden" name="do_login" value="do_login">
			<input type="text" name="id" class="form-control input-lg" max="20" placeholder="YOUR ID*" style="font-family: 'Nanum Gothic', sans-serif;">
			<br>
			<input type="password" name="password" class="form-control input-lg" max="20" placeholder="YOUR PASSWORD*"  style="font-family: 'Nanum Gothic', sans-serif;">
			<br>
			<center>
			<input type="submit" class="btn btn-primary btn-lg btn-block" value="LOGIN" />
			<div class="clearfix"></div><br>	<!-- 줄 띄기  -->
			<a href='javascript:do_join()'>회원가입</a> <%--헤더에 있는 do_join() function 사용--%>
			</center>
		</form>

</div>
<div class="col-xs-2"></div><!--여백용  -->

<br><br><br><br>	<!--밑에 여백 맞추려고 br넣었음 -->
<br><br><br><br>
<br><br><br><br>
<br><br><br><br>
</div>
<br>
</div>
<!--내용 END -->

<!--푸터 START -->
<jsp:include page="footer.jsp"/>
<!--푸터 START -->

</body>
</html>