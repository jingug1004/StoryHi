<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Open+Sans:400,300,700|Montserrat);
body {
	font-size: 18px;
	font-family: "Open Sans";
	
}
.side-menu {
	float: right;
	position: fixed;
	z-index: 1;
	width: 50px;
	height: 100vh;
	top: 0.5;
	right: 0;
	background: white;
	overflow-x: hidden;
	box-shadow: 1px 0 12px rgba(0, 0, 0, 0.64);
	transition: 0.5s;
	position: absolute;
}

.side-menu.open {
	width: 200px;
}

.side-menu .icon {
	display: inline-block;
	
	width: 100%;
	height: 50px;
	
	padding-top: 15px;
	padding-bottom: 15px;
	
	font-family: "Montserrat";
	color: white;
	
	background: #8100A6;
	
	cursor: pointer;
	text-align: center;
	box-shadow: inset 0 -1px #8100A6;
	
	transition: all 0.2s ease-out;
}

.side-menu.open .icon:after {
	content: "내이웃목록";
	
	margin-left: 15px;
}

.side-menu .text {
	transform: rotate(90deg);
}

/* .side-menu:not(.open) .text:before { */
/* 	content: '이웃목록';; */
	
/* 	margin-left: 20px; */
	
/* 	font-family: "Montserrat"; */
/* } */

.side-menu .content {
	display: none;
	padding: 15px;
}

.side-menu.open .content {
	display: inherit;
}

.side-menu .content input, .side-menu .content select, .side-menu .content button
	{
	width: 100%;
	padding: 0.8ex;
	margin-bottom: 15px;
	font-size: 16px;
	border: 1px solid #d2d2d2;
	border-radius: 3px;
}

.side-menu .content button {
	cursor: pointer;
	background: white;
	transition: all 0.1s ease-out;
}

.side-menu .content button:hover {
	color: #8100A6;
	border-color: #8100A6;
}

.side-menu .content button:active {
	color: white;
	background: #8100A6;
}

.side-menu .content input:focus, .side-menu .content select:focus {
	border-color: #4ae;
}

</style>
</head>
<body>

<div style="float : right">
<div class="side-menu">
	<div class="icon"><span class="fa fa-bars"></span></div>
	<div class="text">이웃목록</div>
	<div class="content">
	<h4>김미현</h4> <button>aa</button>
	</div>
</div>
</div>


<script type="text/javascript">
$(".side-menu .icon").click(function() {
	$(".side-menu").toggleClass("open");
});

</script>
</body>
</html>