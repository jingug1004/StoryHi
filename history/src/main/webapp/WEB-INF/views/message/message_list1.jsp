<%@page import="com.hifive.history.model.UserDto"%>
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
int intTotalCount 	= 0;

String my_id 		= "";

if(session.getAttribute("user") != null) {
	
	// 로그인한 세션정보
	UserDto userDto = (UserDto) session.getAttribute("user");
	my_id = userDto.getId();
	
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
<title> 받은쪽지함 </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- http://aramk.tistory.com/21 -->
<script type="text/javascript">
/* 내용 검색  */
$(document).ready(function() {
	$("#words").on("click", function() {
		var words = $('#searchbox').val();
		var id	  = $('#My_ID').val();
        
		do_search_for_filtered('filtered.hi', 1, id, words);
	});	
});

function do_search_for_filtered(url_i, page_i, take_id_i, words_i) {
	var url 	= url_i;
	var words 	= words_i;
	var id		= take_id_i;
	var page	= page_i;
	
	$.ajax({
		type : "POST",
		url  : "filtered.hi",
		dataType : "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
		data : {
			"condi" : 'receiver',
			"words" : words,
			"id"	: id,
			"page"  : page
		},
		success : function(data) {	// 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.		
			$('#filteredForm').remove();
			$('#pagiForm').remove();				
			// alert('success ' +data);
			
			var item = $.parseJSON(data);
			/* $.each(item,function(key,value) {
				alert('key:'+key+', idx:'+value.IDX+', seq:'+value.SEQ+
						', send_id:'+value.SEND_ID+', take_id:'+value.TAKE_ID+
						', contents:'+value.CONTENTS+', wdate:'+value.WDATE+
						', rdate:'+value.RDATE+', state:'+value.STATE+
						', name:'+value.NAME+', TOTAL:'+value.TOTAL);
			});	 */			
			
			if (item.length == 1) {
				// alert('item.length ' +item.length);
				$("#wrapfilteredForm").append('<table id="filteredForm" class="table"><tr class="warning" ><th width="10%" style="text-align: center;"><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAl();" /></th><th width="20%" style="text-align: center;">보낸사람</th><th width="40%" style="text-align: center;">내용</th><th width="20%" style="text-align: center;">날짜</th><th width="10%" style="text-align: center;">읽음</th><tr><td align="center" colspan="5">쪽지가 없습니다.</td></tr>');
			}
			else {
				var filteredForm = '<table id="filteredForm" class="table"><tr class="warning" >';
				filteredForm = filteredForm + '<th width="5%" style="text-align: center;"><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAl();" /></th>';
				filteredForm = filteredForm + '<th width="25%" style="text-align: center;">보낸사람</th>';
				filteredForm = filteredForm + '<th width="40%" style="text-align: center;">내용</th>';
				filteredForm = filteredForm + '<th width="20%" style="text-align: center;">날짜</th>';
				filteredForm = filteredForm + '<th width="10%" style="text-align: center;">읽음</th>';
										
				for (var i = 0; i < item.length - 1; i++) {
					var idx		 = item[i].IDX;
					var seq		 = item[i].SEQ;
					var send_id	 = item[i].SEND_ID;
					var take_id	 = item[i].TAKE_ID;
					var contents = item[i].CONTENTS;
					var wdate	 = item[i].WDATE;
					var rdate	 = item[i].RDATE;
					var state	 = item[i].STATE;
					var name	 = item[i].NAME;
					var total	 = item[i].TOTAL;
					var take	 = item[i].TAKE_VIEW;
					
					if(take == '-1') 
						continue;
					
					if(contents.length > 25) {
						contents = contents.substring(0, 25) + '...';
						// alert(contents);
					}
					
					filteredForm = filteredForm + '<tr><td align="center"><input type="checkbox" name="checkRow" value='+seq+'</td>';
					filteredForm = filteredForm + '<td>'+ name+' <span style="font-size: 11px; color :#670000">('+send_id+')</span></td>'
					filteredForm = filteredForm + '<td><a href=read.hi?note='+seq+'>'+contents+'</a></td>';
					filteredForm = filteredForm + '<td>'+wdate+'</td>';						

					if(state == '0') {
						filteredForm = filteredForm + '<td>읽지 않음</td></tr>';
					} else {
						filteredForm = filteredForm + '<td>'+rdate+'</td></tr>';
					}						
				}
				filteredForm = filteredForm + '</table>';
				// alert(filteredForm);
				$("#wrapfilteredForm").append(filteredForm);
				
				// 내가 입력한 검색어 확인
				var getWords = item[item.length-1].INPUTWORDS;
				// alert('내가 입력한 검색어는 ? ' +getWords)
				
				var pagiForm = '<table id="pagiForm"><tr><td style="text-align: center;">';
				
				// 1 2 3 ..	 총 갯수		  현재 페이지 번호?		      페이지 크기	             바닥에 보여질 페이지 수		URL				스크립트
				// renderPaging(
				//		int maxNum_i, int currPageNoIn_i, int rowsPerPage_i, int bottomCount_i, String url_i, String scriptName_i)
				pagiForm = pagiForm + renderPaging(
						item[0].TOTAL, page, 10, 10, "filtered.hi", "do_search_for_filtered", item[0].TAKE_ID, getWords);					
				
				// 						params :    url,   받은이,   검색 단어
				// function do_search_for_filtered(url_i, take_id, words)					
									
				pagiForm = pagiForm + '</td></tr></table>';					
				
				$("#wrapPagiForm").append(pagiForm);
			}
		},
		complete : function(data) {
			
		},
		error : function(xhr, status, error) {
			alert("에러 발생");
		}
	});	
}

// 검색 결과 페이징
function renderPaging(
		maxNum_i, currPageNoIn_i, rowsPerPage_i, bottomCount_i,
		url_i, scriptName_i, take_id_i, words_i) {
	
	var maxNum      = parseInt("0");  // 총 갯수
	var currPageNo  = parseInt("1");  // 현재 페이지 번호 : page_num
	var rowPerPage  = parseInt("10"); // 한페이지에 보여질 행수 : page_size
	var bottomCount = parseInt("10"); // 바닥에 보여질 페이지 수: 10
	var take_id     = take_id_i;	  // 
	var words		= words_i;		  // 

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
	html +="<ul class=\"pagination pagination-sm\">";	
	
	// <<
	if (nowBlockNo > 1 && nowBlockNo <= maxBlockNo) {
			html +="<li><a href=\"javascript:" + scriptName + "( '" + url+ "', 1,'" + take_id + "','" + words + "');\"> ";
			html +="&laquo;";
			html +="</a></li>";
	}

	// <
	if (startPageNo > bottomCount) {
		html +="<li><a href=\"javascript:" + scriptName + "( '" + url + "'," + (startPageNo - 1)+ ",'" + take_id+ "','" + words+ "');\"> ";
		html +="<";
		html +="</a></li>";
	}

	// 1 2 3 ... 10	(숫자보여주기)
	for (inx = startPageNo; inx <= maxPageNo && inx <= endPageNo; inx++) {
		if (inx == currPageNo) {
			html +="<li class='active'><a href='#'>" + inx	+ "</a></li>";
			
		} else {								
			html +="<li><a href=\"javascript:" + scriptName + "";
			html +="('" + url + "'," + inx+ ",'" + take_id+ "','" + words+ "')";
			html +="\" class=\"num_text\">" + inx + "</a></li>";
		}															
	}

	// >
	if (maxPageNo >= inx) {
		html +="<li><a href=\"javascript:" + scriptName + "('" + url + "',"+ ((nowBlockNo * bottomCount) + 1) + ",'" + take_id+ "','" + words+ "');\"> ";
		html +=">";
		html +="</a></li>";
	}

	// >>
	if (maxPageNo >= inx) {
		html +="<li><a href=\"javascript:" + scriptName + "( '" + url+ "'," + maxPageNo + ",'" + take_id + "','" + words + "');\"> ";
		html +="&raquo;";
		html +="</a></li>";
	}
	
	html +="</ul>";
	html +="</td>";
	html +="</tr>";
	html +="</table>";

	return html;
}

// 페이징
function do_search_page(url, page_num) 
{
	  // alert(url+" "+page_num);
	 
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
	// alert('삭제 ' +checkRow);	
	
	if(checkRow == ''){
		alert("삭제할 대상을 선택하세요.");
		return false;
	}
	console.log("### checkRow => {}"+checkRow);
	
	if(confirm("정보를 삭제 하시겠습니까?")){	    
		location.href='delete.hi?idx='+checkRow+'&to=receive';
	//  "${rc.contextPath}/test_proc.do?idx="+checkRow+"&goUrl="+url;
	}
}

/* 답장(체크박스된 것 전부) */
function replyAction() {
	var checkRow = "";
	$( "input[name='checkRow']:checked" ).each (function (){	
		// 아이디 중복 검사
		// var index = checkRow.indexOf($(this).closest('td').next().html());
		var index = checkRow.indexOf($(this).closest('td').next().find('span:first').html());
		// alert($(this).closest('td').next().find('span:first').html());
		
		if(index != -1) {
			
		} else {
			// checkRow = checkRow + $(this).closest('td').next().html()+",";
			checkRow = checkRow + $(this).closest('td').next().find('a:first').html()+",";
		}
	});
	
	<%-- 변경 전
	<tr>
	<td align="center"><input type="checkbox" name="checkRow" value="<%=item.get("SEQ") %>"></td>					
	<td><%=item.get("SEND_ID") %>(<%=item.get("NAME") %>)</td>
	
		  변경 후
	<td align="center"><input type="checkbox" name="checkRow" value="<%=item.get("SEQ") %>"></td>
	<td><%=item.get("NAME") %> <span style="font-size: 11px; color :#670000">(<%=item.get("SEND_ID") %>)</span> </td> 
	
	<td><%=item.get("NAME") %> <span style="font-size: 11px; color :#670000">(<a href="javascript:void(0);" onclick="gotoBlog('<%=item.get("SEND_ID") %>');"><%=item.get("SEND_ID") %></a>)</span></td>
	--%>
	
	checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); 
	// alert('답장 대상 ' +checkRow);
	
	if(checkRow == ''){
		alert("답장할 대상을 선택하세요.");
		return false;
	}
	console.log("### checkRow => {}"+checkRow);
	
	if(confirm("정말 보내겠습니까?")){	    
		location.href='writeForm.hi?list='+checkRow;
	}
}

function viewAll() {
	location.href='receive.hi';
}

function gotoBlog(id) {
	location.href='/post/main.hi?id='+id;
}


</script>	
</head>
<body>

<!--헤더 START-->
<jsp:include page="/header.hi" />
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
<center><h2> :: 받은쪽지함 ::</h2></center><br>
	<div class="col-xs-1">
	</div>
	<form name="searchForm" action="" method="POST">
		<input type="hidden" name="PAGE_NUM" value="" />
		<input type="hidden" id="My_ID" value="<%=my_id %>" />
	<div class="col-xs-11" >
		<div class="form-group">
	 		<!-- 삭제, 답장 버튼 -->	
	 		<div class="col-xs-3" align="left">
				<span onclick="deleteAction();" class="btn btn-danger"><span class="glyphicon glyphicon-trash" style="font-size: 22px"></span></span>
            	<span onclick="replyAction();"  class="btn btn-danger"><span class="glyphicon glyphicon-envelope" style="font-size: 22px"></span></span>
			</div>
			<!-- 미확인 쪽지 -->
			<%-- <div class="col-xs-1" align="left">
			(<%=unReadNotes %>)
			</div> --%>
			
			<!-- 입력창 -->
			<div class="col-xs-7" align="left">
				<div class="input-group"> 
			 	<span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
				<input type="text" id="searchbox" class="form-control" placeholder="검색어를 입력하삼"/>
				<span class="input-group-btn"><input type="button" id="words" value="검색" class="btn btn-info" /></span>
				</div>
			</div>
			<!-- 전체보기 -->
			<div class="col-xs-2" align="right">	
				<input type="button" id="viewall" value="전체보기" onclick="viewAll();" class="btn btn-default" />
			</div>		
		</div>	
    	<br><br>
    	<div id="wrapfilteredForm" >
		<table id="filteredForm" class="table">
			<tr class="warning" >
				<th width="5%" style="text-align: center;">
				<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAl();" /></th>
				<th width="25%" style="text-align: center;">보낸사람</th>
				<th width="40%" style="text-align: center;">내용</th>
				<th width="15%" style="text-align: center;">받은날짜</th>
				<th width="15%" style="text-align: center;">수신확인</th>
			</tr>
			
			<%
			if(datas != null && datas.size() > 0) {	
				Map<String, Object> cnt = datas.get(0);
				intTotalCount = (Integer) cnt.get("TOTAL");
				
				for(int i = 0; i < datas.size(); i++) {
					Map<String, Object> item = datas.get(i);
					
					// view 삭제 여부 확인
					if(item.get("TAKE_VIEW").equals("-1")) {
						continue;	
					}					
					
					String subContents = (String) item.get("CONTENTS");
					
					if(subContents.length() > 25) {
						subContents = subContents.substring(0, 25) + "...";
						
					} else {
						
					}
			%>
				<tr>
					<td align="center"><input type="checkbox" name="checkRow" value="<%=item.get("SEQ") %>"></td>					
<td><%=item.get("NAME") %> <span style="font-size: 11px; color :#670000">(<a href="javascript:void(0);" onclick="gotoBlog('<%=item.get("SEND_ID") %>');"><%=item.get("SEND_ID") %></a>)</span></td>
					<td><a href='read.hi?note=<%=item.get("SEQ") %>&show=bty'><%=subContents %></a></td>
					<td align="center"><%=item.get("WDATE") %></td>
				<% 
				if(item.get("STATE").equals("0")) {
				%>
					<td align="center" ><b>미확인</b></td>
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
		</div>
<center>
<div id="wrapPagiForm" >
<table id="pagiForm"><tr><td style="text-align: center;">
<!-- Paging Area Start -->
<%=PagingUtil.renderPaging(
		intTotalCount, page_num, 10, 10, "receive.hi", "do_search_page")%>
<!-- Paging Area end //--> 	<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->	
</td></tr>
</table>
</div>
</center>
	</div>
	</form>
</div>


<!-- <br>
<br>
<br>
<br><div class="col-xs-3" style="min-height: 600px; display:block;">
dddddddddddddddddddddddddddddddddddddddddddddddddddddddd
</div> -->
<br><br><br><br><br>
</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>


