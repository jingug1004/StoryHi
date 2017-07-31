<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	//현재 카테고리 리스트 받아오기
	List<CategoryDto> categoryList = (List<CategoryDto>)request.getAttribute("categoryList");
	//비로그인시 블로그관리 접근 권한이 없긴하지만 한번 더 막아주기.
	if(session.getAttribute("user")!=null){
		UserDto user = (UserDto)session.getAttribute("user");
	}
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
%>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
#categoryTable{
font-size: 12px;
border-width: 1px;
}
</style>
<script>
	$(document).ready(function name() {
		$("#categoryTable tr").click(function trclick() {
			var id = $(this).attr("id");
			var name = $(this).eq(0).find("td").eq(1).text();
			var state = $(this).eq(0).find("td").eq(2).text();
			
			$("#catename").val(name);
			$("#cateseq").val(id);
			/* state=="전체공개"?$("#optionsRadios1").attr("checked",true):$("#optionsRadios2").attr("checked",true); */
			if(state=="전체공개"){
				$("#optionsRadios1").attr("checked",true);
				$("#optionsRadios2").attr("checked",false);
			}else{
				$("#optionsRadios2").attr("checked",true);
				$("#optionsRadios1").attr("checked",false);
			}
	})
});
</script>
</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<script>
	function do_func(ment) {
		if($("#catename").val()!=null && $("#catename").val().trim()!='' && $("#cateseq").val()!=''){
			if(ment=='del'){
				if(confirm("정말 삭제하시겠습니까?")){
					if(<%=categoryList.size()==1%>){
						alert('최소 카테고리 1개는 유지 해야 합니다!');
					}else{
						$("#btn").val(ment);
						var frm = document.output;
						frm.submit();
					}
				}
			}else{
				if(confirm("정말 수정하시겠습니까?")){
					$("#btn").val(ment);
					var frm = document.output;
					frm.submit();
				}
			}
		}else if($("#catename").val()==null || $("#catename").val().trim()==''){
			alert("카테고리를 선택하세요");
		}else{
			alert("카테고리를 선택하세요");
		}
	}
	function check() {
		if($("#name").val()!=null && $("#name").val().trim()!=''){
			if(confirm($("#name").val()+" 카테고리를 추가하시겠어요?")){
				var frm = document.regiCate;
				frm.submit();
			}}else{
			alert('카테고리명을 입력하세요');
		}		
	}
	function color() {
		if(confirm("설정을 변경하시겠어요?")){
			var frm = document.blog;
			frm.submit();
			
		}
	}
</script>
<!-- 
태마 버전
그린 : rgb(224, 239, 208) / rgb(251, 255, 247)
 -->
<!-- 중간 START -->
   <br><br><br><br>
   <div class="container" >
      <div class="col-xs-2 mydiv" style="background-color: <%=blogdto.getTheme() %>; border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: <%=blogdto.getTheme() %>;">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10" style="margin-top: 20px; margin-bottom : 20px; background-color: #FCFCFC;">
		       	
		       	<!-- <p style="font-size: 25px; margin-top: 20px; margin-bottom: 20px">등록된 카테고리</p> -->

		       	<div class="col-xs-12" style="background-color: white; padding-top: 20px;">
		       	<fieldset>
		       	<legend><span class="glyphicon glyphicon-list"></span> 등록된 카테고리 수정/삭제</legend>
		       	
		        <!-- <div class="col-xs-6" style="overflow: scroll;overflow-x:hidden; height: 300px; "> -->
		        
		        <div class="col-xs-6" style="min-height: 300px; border-radius: 15px; padding-top: 10px; border:2px solid black " >
		       	<table class="table table-hover" id="categoryTable">
		        	<tr class="info" >
						<th width="10%" style="text-align: center;">No</th>
						<th width="60%" style="text-align: center;">카테고리</th>
						<th width="30%" style="text-align: center;">공개여부</th>
		        	</tr>
		        	<%if(categoryList.size()==0){ %>
		        	<tr class="active">
		        		<td colspan="3" style="text-align: center;">등록된 카테고리가 없습니다.</td>
		        	</tr>
		        	<%
		        	}else{
		        		for(int i = 0; i < categoryList.size(); ++i){
		        	%>
		        	<tr id="<%=categoryList.get(i).getSeq() %>" style="cursor:pointer; text-align: center;">
		        		<td><%=i+1 %></td>
		        		<td><%=categoryList.get(i).getName() %></td>
		        		<td><%=categoryList.get(i).getState().equals("0")?"전체공개":"나만보기" %></td>
		        	</tr>
		        	<%
		        		}
		        	}
		        	%>
		        </table>
				</div>
				<div class="col-xs-5" style="margin-left: 15px">
				<form class="form-horizontal" method="post" action="control.hi" id="ouput" name="output">
							<div class="form-group">
								<label for="inputEmail" class="control-label">카테고리</label>
							</div>
							<div class="form-group" style="margin-left: 10px">
								<input type="text" class="form-control" id="catename" name="catename"
									placeholder="◀ 카테고리를 선택하세요" value="">
								<input type="hidden" id="cateseq" name="cateseq" value="">
							</div>
						
							<div class="form-group">
								<label class="control-label">공개설정</label>
							</div>	
							<div class="form-group" style="margin-left: 15px">
									<label class="radio-inline"> <input type="radio" name="catestate"
										id="optionsRadios1" value="true" checked="checked">공개
									</label>
								
									<label class="radio-inline"> <input type="radio" name="catestate"
										id="optionsRadios2" value="false" > 비공개
									</label>
							</div>
						
						<br>
						<div class="form-group">
							<div class="col-xs-offset-3 col-xs-9">
								<input type="hidden" name="btn" id="btn" value="">
								<button type="button" class="btn btn-primary" name="" onclick="do_func('mod')"> 수정 </button>
								<button type="button" class="btn btn-danger" name="" onclick="do_func('del')"> 삭제 </button>
							</div>
						</div>
				</form>
				
				</div>
				</fieldset>
				</div>
				
				<div class="col-xs-12" style="margin-top: 50px; ">
				<hr style="border:2px dashed">
				<form class="form-horizontal" method="post" action="control.hi" name="regiCate">
					<fieldset>
						<legend><span class="glyphicon glyphicon-plus"></span> 카테고리 추가 </legend>
						
						<div class="form-group">
							<label for="inputEmail" class="col-xs-2 control-label">카테고리</label>
							<div class="col-xs-9">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="추가할 카테고리명을 입력하세요 :D">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-2 control-label">공개 설정</label>
							<div class="col-xs-10">
									<label class="radio-inline"> <input type="radio" name="state"
										id="optionsRadios1" value="true" checked="checked">공개
									</label>
								
									<label class="radio-inline"> <input type="radio" name="state"
										id="optionsRadios2" value="false"> 비공개
									</label>
							</div>
						</div>
						
						<div class="form-group" align="center">
								<button type="reset" class="btn btn-default"> 리셋 </button>
								<button type="button" class="btn btn-primary" onclick="check()"> 카테고리 추가 </button>
						</div>
						
					</fieldset>
				</form>
				</div>
				
				
				
				<div class="col-xs-12">
				<hr style="border:2px dashed">
				<form class="form-horizontal" method="post" action="control.hi" name="blog">
					<fieldset>
						<legend><span class="glyphicon glyphicon-cog"></span> 블로그 설정 </legend>
						<div class="form-group">
							<label for="inputEmail" class="col-xs-2 control-label">제목</label>
							<div class="col-xs-9">
								<input type="text" class="form-control" id="title" name="title"
									value="<%=blogdto.getTitle()%>">
							</div>
						</div>
						
						
						<div class="form-group">
							<label for="select" class="col-xs-2 control-label">테마설정</label>
								<div class="col-xs-9">
									
								<table class="table" style="margin-top: 10px">
									<tr>
										<td style="background-color: #f7e3a3; height: 100px"></td>
										<td style="background-color: #f7c4a3;"></td>
										<td style="background-color: #a3f7c4;"></td>
										<td style="background-color: #a3e0f7;"></td>
										<td style="background-color: #f7a3e4;"></td>
									</tr>
									<tr>
										<td style="text-align: center;">
										<label class="radio-inline"> <input type="radio" name="theme"
										id="optionsRadios1" value="#f7e3a3" <%if(blogdto.getTheme().equals("#f7e3a3") || blogdto.getTheme().equals("DEFAULT_THEME")) {%>checked="checked"<%} %>></label>
										</td>
										<td style="text-align: center;">
										<label class="radio-inline"> <input type="radio" name="theme"
										id="optionsRadios2" value="#f7c4a3" <%if(blogdto.getTheme().equals("#f7c4a3")){%>checked="checked"<%} %>></label>
										</td>
										<td style="text-align: center;">
										<label class="radio-inline"> <input type="radio" name="theme"
										id="optionsRadios3" value="#a3f7c4" <%if(blogdto.getTheme().equals("#a3f7c4")){%>checked="checked"<%} %>></label>
										</td>
										<td style="text-align: center;">
										<label class="radio-inline"> <input type="radio" name="theme"
										id="optionsRadios4" value="#a3e0f7" <%if(blogdto.getTheme().equals("#a3e0f7")){%>checked="checked"<%} %>></label>
										</td>
										<td style="text-align: center;">
										<label class="radio-inline"> <input type="radio" name="theme"
										id="optionsRadios5" value="#f7a3e4" <%if(blogdto.getTheme().equals("#f7a3e4")){%>checked="checked"<%} %>></label>
										</td>
									</tr>
								</table>
								</div>
							</div>
							
						<div class="form-group" align="center">
								<button type="reset" class="btn btn-default">리셋</button>
								<button type="button" class="btn btn-primary" onclick="color()">테마적용</button>
						</div>
					</fieldset>
				</form>
				</div>

				<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>