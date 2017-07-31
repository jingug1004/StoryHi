<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.service.MessageService"%>
<%@ page import="com.hifive.history.util.PagingUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<style type="text/css">
	img#logo{		/* 로고 윗부분 마진 */
		margin-top: 15px;
	}
	.navbar-login
	{
		width: 350px;
		padding: 10px;
		padding-bottom: 0px;
	}

	.navbar-login-session
	{
		padding: 10px;
		padding-bottom: 0px;
		padding-top: 0px;
	}

	.scrollable-menu {
		height: auto;
		max-height: 200px;
		overflow-x: hidden;
	}
</style>

<!-- 네이게이션 바.. 상단고정 -->
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">		<!-- 양 옆에 공백 -->

		<div class="navbar-header" style="vertical-align: center">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 왼쪽로고. 클릭시 첫화면으로 이동함 -->
			<a href="/"><img src="/resources/image/logo_sm.png" width="120" id="logo"></a>
		</div>

		<div class="navbar-collapse collapse" id="bs-example-navbar-collapse-1" aria-expanded="false" style="height: 1px;">
			<!-- 로그인전 =============================================================================== -->
			<% if (session.getAttribute("user") == null) { %>
				<!-- 오른쪽 로그인/회원가입 버튼 -->
				<ul class="nav navbar-nav navbar-right">
					<li><button class="btn btn-default navbar-btn" onclick="do_login()">Login</button></li>
					<li>&nbsp;&nbsp;&nbsp;</li> <!-- 버튼 사이 공백 넣어주려고 -->
					<li><button class="btn btn-default navbar-btn" onclick="do_join()">Join</button></li>
				</ul>
			<!-- 로그인후 =============================================================================== -->
			<% } else { %>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="javascript:go_myblog();">내블로그</a></li>
				<li class="dropdown" id="followDropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">이웃 <span class="caret"></span></a>
					<ul class="dropdown-menu scrollable-menu" role="menu" id="followUl" ></ul>
				</li>
				<li><a href="javascript:do_message(); ">쪽지함</a></li>
				<li><a href="/chart/control.hi">블로그관리</a></li>

				<li class="dropdown">
		          <a class="dropdown-toggle" role="button" aria-expanded="false" href="#" data-toggle="dropdown" style="color: #D9418C;">
		       	   [<b>${sessionScope.user.name}</b>]님<span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a href="javascript:do_update()"><i class="icon-user"></i> 내정보수정 </a></li>
		            <li class="divider"></li>
		            <li><a href="javascript:do_logout();" ><i class="icon-off"></i> 로그아웃 </a></li>
		          </ul>
				
			</ul>
			<% } %>
		</div>
	</div>
</nav>

<!--페이지이동  -->
<script type="text/javascript">

    function go_myblog() {
        var frm = document.myblogfrm;
        frm.submit();
    }
    function do_logout(){
        var frm = document.logoutfrm;
        frm.submit();
    }
    function do_login(){
        var frm = document.loginfrm;
        frm.submit();
    }
    function do_join(){
        var frm = document.joinfrm;
        frm.submit();
    }
    function do_update() {
        var frm = document.updatefrm;
        frm.submit();
    }
    function do_message(){
        var frm = document.messagefrm;
        frm.submit();
    }

    $("#followDropdown").on("click", function (e) {
        dropdownSet();
    });

	function dropdownSet() {
        <c:if test="${!empty sessionScope.user.id }">
            var id = "${sessionScope.user.id}";
        </c:if>
		var PAGE = "notpage";
        $("#followUl").empty();
        $.ajax({
            type:"POST",
            url:"/user/followSearch.hi",
            dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
            data: {
                "id": id,
	            "PAGE": PAGE
            },
            success: function (data) {
                // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                var followList = $.parseJSON(data);
                if (followList.length == 0) {
                    $("#followUl").append("<li><a href=\"#\">\"이웃을 추가해보세요!\"</a></li>");
                } else {
                    for (var i = 0; i < followList.length; i++) {
                        var followBlogUrl = "/post/main.hi?id=" + followList[i].ID;
                        var followMessageUrl = "/message/writeForm.hi?TAKEID=" + followList[i].ID;
                        $("#followUl").append("" +
                            "<li>" +
                            "   <div class=\"navbar-login\">" +
                            "       <div class=\"row\">" +
                            "           <div class=\"col-sm-8\" style=\"text-align:right;color: black; font-size: 13px\">" +
                            "               <p>" + followList[i].NAME +" § "+ followList[i].TITLE  +
                            "               </p>" +
                            "           </div>" +
                            "           <div class=\"col-sm-4\">" +
                            "                   <a href=\"" + followBlogUrl + "\" class=\"btn btn-info btn-sm\" style=\"font-size: 13px\"><span class=\"glyphicon glyphicon-home\" ></span></a> " +
                            "                   <a href=\"" + followMessageUrl + "\" class=\"btn btn-warning btn-sm\" style=\"font-size: 13px\"><span class=\"glyphicon glyphicon-envelope\"></span></a> " +
                            "           </div>" +
                            "       </div>" +
                            "   </div>" +
                            "</li>");
                        
/*                         
                        $("#followUl").append("" +
                                "<li>" +
                                "   <div class=\"navbar-login\">" +
                                "       <div class=\"row\">" +
                                "           <div class=\"col-sm-8\">" +
                                "               <p class=\"text-center\">" +
                                "                   <a href=\"#\">" + followList[i].NAME + "</a> " +
                                "                   <a href=\"#\">" + followList[i].TITLE + "</a> " +
                                "               </p>" +
                                "           </div>" +
                                "           <div class=\"col-sm-4\">" +
                                "                   <a href=\"" + followBlogUrl + "\" class=\"btn btn-primary btn-sm\"><span class=\"glyphicon glyphicon-home\"></span></a> " +
                                "                   <a href=\"" + followMessageUrl + "\" class=\"btn btn-primary btn-sm\"><span class=\"glyphicon glyphicon-envelope\"></span></a> " +
                                "           </div>" +
                                "       </div>" +
                                "   </div>" +
                                "</li>"); */
                        
                        
                        
                        
                        
                    }

                }
            },
            complete: function (data) {
                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
            },
            error: function (xhr, status, error) {
//                alert("에러발생?");
            }
        });
    }

</script>

<form name="myblogfrm" action="/post/main.hi">
	<input type="hidden" name="id" value="${sessionScope.user.id}">
</form>
<form name="logoutfrm" action="/main/logout.hi"></form>
<form name="loginfrm" action="/main/login.hi" method="post"></form>
<form name="joinfrm" action="/user/join.hi" method="post" enctype="multipart/form-data"></form>
<form name="updatefrm" action="/user/update.hi" method="post" enctype="multipart/form-data"></form>
<form name="messagefrm" action="/message/receive.hi" method="post"></form>