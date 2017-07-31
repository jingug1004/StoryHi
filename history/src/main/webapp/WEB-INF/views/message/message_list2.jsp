<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 

List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
int page_num 		= 1;
int unReadNotes 	= 0; 
int intTotalCount	= 0;

if(session.getAttribute("user") != null) {
	
	if(request.getAttribute("GETLIST") != null) {
		datas = (ArrayList<Map<String, Object>>) request.getAttribute("GETLIST");
	}
	
	if(request.getAttribute("PAGE_NUM") != null) {
		page_num = Integer.parseInt((String) request.getAttribute("PAGE_NUM"));
	} 
	
	if(request.getAttribute("UNREADNOTES") != null) {
		unReadNotes = (Integer) request.getAttribute("UNREADNOTES");
	}
} else {
	response.sendRedirect("../main/login");
}

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title> 보낸쪽지함 </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
// 페이징
function do_search_page(url, page_num) 
{
	  console.log(url+"\t"+page_num);
	 
	  var frm = document.searchForm;
	  frm.PAGE_NUM.value = page_num;
	  frm.action = url;
	  frm.submit();
}

/* 체크박스 전체선택, 전체해제 */
function checkAl() { 
	if( $("#th_checkAll").is(':checked') ){
        $("input[name=checkRow]").prop("checked", true);
      }else{
        $("input[name=checkRow]").prop("checked", false);
      }
}

/* 삭제(체크박스된 것 전부) */
function deleteAction(){
	var checkRow = "";
	$( "input[name='checkRow']:checked" ).each (function (){
	  checkRow = checkRow + $(this).val()+"," ;
	});
	checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기
	// alert(checkRow);
	
	
	if(checkRow == ''){
		alert("삭제할 대상을 선택하세요.");
		return false;
	}
	console.log("### checkRow => {}"+checkRow);
	
	if(confirm("정보를 삭제 하시겠습니까?")){	    
		location.href='delete.hi?idx='+checkRow+'&to=send';
	    //"${rc.contextPath}/test_proc.do?idx="+checkRow+"&goUrl="+url;
	}
}

function gotoBlog(id) {
	location.href='/post/main.hi?id='+id;
}
</script>	
</head>
<body>

<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!-- 좌측메뉴 -->
<div class="col-xs-2">
	<jsp:include page="menu.jsp" flush="false">
		<jsp:param name="unReadNotes" value="<%=unReadNotes%>" />
	</jsp:include>
</div>

<!--내용 START -->
<div class="col-xs-10" style="min-height: 700px">
<center><h2> :: 보낸쪽지함 ::</h2></center><br>
	<div class="col-xs-1"></div>
	<form name="searchForm" action="" method="POST">
		<input type="hidden" name="PAGE_NUM" value="">
	<div class="col-xs-11">
		<div class="form-group col-xs-12">
			<!-- 버튼 -->	
			<div> <!-- class="form-group"> -->			
				<span onclick="deleteAction();" class="btn btn-danger">
				<span class="glyphicon glyphicon-trash" style="font-size: 22px"></span></span>
	    	</div>
    	</div>
		<table class="table">
			<tr style="background-color:#FFDDDD " >
				<th width="5%" style="text-align: center;">
				<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAl();" /></th>
				<th width="25%" style="text-align: center;">받는사람</th>
				<th width="40%" style="text-align: center;">내용</th>
				<th width="15%" style="text-align: center;">보낸날짜</th>
				<th width="15%" style="text-align: center;">수신확인</th>
			</tr>
			
			<%
			if(datas != null && datas.size() > 0) {	
				Map<String, Object> cnt = datas.get(0);
				intTotalCount = (Integer) cnt.get("TOTAL");
				
				for(int i = 0; i < datas.size(); i++) {
					Map<String, Object> item = datas.get(i);	
					
					// view 삭제 여부 확인
					if(item.get("SEND_VIEW").equals("-1")) {
						continue;	
					}	
					
					String subContents = (String) item.get("CONTENTS");
					
					if(subContents.length() > 15) {
						subContents = subContents.substring(0, 15) + "...";
						
					} else {
						
					}
			%>
				<tr>
					<td align="center"><input type="checkbox" name="checkRow" value="<%=item.get("SEQ") %>"></td>
					<%-- <td><%=item.get("NAME") %>  <span style="font-size: 11px; color :#670000 ">(<%=item.get("TAKE_ID") %>)</span></td> --%>
<td><%=item.get("NAME") %> <span style="font-size: 11px; color :#670000">(<a href="javascript:void(0);" onclick="gotoBlog('<%=item.get("TAKE_ID") %>');"><%=item.get("TAKE_ID") %></a>)</span></td>
					<td><a href='read.hi?note=<%=item.get("SEQ") %>&show=btn'><%=subContents %></a></td>
					
					
					<td><%=item.get("WDATE") %></td>
				
				<% 
				if(item.get("STATE").equals("0")) {
				%>
					<td align="center"><b>미확인</b></td>
				<%	
				} else {
				%>
					<td align="center">읽음</td>
				<%	
				}
				%>
				</tr>
			<%
				}
			} else {
			%>
				<tr>
					<td align="center" colspan="5">쪽지가 없습니다.</td>
				</tr>
			<%	
			}
			%>	
		</table>
		<center>
		<table>
			<tr><td style="text-align: center;">
				<!-- Paging Area Start -->
				<%=PagingUtil.renderPaging(
						intTotalCount, page_num, 10, 10, "send.hi", "do_search_page")%>
				<!-- Paging Area end //--> 	<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->	
			</td></tr>
		</table>
		</center>
	</div>
	</form>
</div>


<br><br><br><br><br>
</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>


