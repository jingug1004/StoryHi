<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.hifive.history.model.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

String SENDID = "";
String TAKEID = "";

HttpSession sesson = null;
UserDto dto 	   = null;
String blackIds    = null; 

int unReadNotes    = 0;
	
if(session.getAttribute("user") != null) {
	sesson = request.getSession(false);
	dto    = (UserDto) sesson.getAttribute("user");
	
	SENDID = dto.getId();
	TAKEID = (String) request.getAttribute("TAKEID");
	
	blackIds 		= (String) request.getAttribute("blackIds");
	
	if(blackIds != null) {
		out.println("<script>alert('쪽지 전달을 실패하였습니다. " + blackIds + " 아이디가 존재하지 않습니다. 쪽지 수신자 아이디를 확인해 주세요.');</script>");
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
<title>쪽지함</title>
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet"	type="text/css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
function replaceLeftOpenTag(obj) {
	return obj.replace(/</g, "&lt;");
}
function replaceRightOpenTag(obj) {
	return obj.replace(/>/g, "&gt;");
}

$(document).ready(function () {
	$("#sending").on("click", function () {
	    if (sendCheck()) {
	    	
	    	$("#realNote").val(replaceLeftOpenTag($("#realNote").val()));	    	
	    	$("#realNote").val(replaceRightOpenTag($("#realNote").val()));	    
	    	
	        $("#textNote").submit();
	    }
	});
	
	$("#TAKE_ID").on('keyup',function(e){
		if(e.which == 32) {
			// alert('스페이스바');
			
			var alreadyinputIds = $("#TAKE_ID").val();
			alreadyinputIds = alreadyinputIds.trim();
			
			if(alreadyinputIds.length == 0) {
				$("#TAKE_ID").val("");
			} else {
				$("#TAKE_ID").val(alreadyinputIds +",");
			}
		}
	});
	
	$("#TAKE_ID").blur(function() {
		// alert('벗어남');
		
		var alreadyinputIds = '';
		var outputIds 		= '';
		alreadyinputIds = $("#TAKE_ID").val();
		
		/*
		 *  input  : ,,<, sung ,123,,,hi,,성우
		 *  output : sung,123,hi
		 * 
		 *  1. 유효하지 않는 , 삭제 
		 *  2. 앞뒤 공백 제거(이건 입력하는 부분에서 할까)
		 *  3. , 를 제외한 모든 특수문자 삭제
		 *  4. 한글 제거
		 */
 
		if(alreadyinputIds.length == 0) {	
			 
		} else {
			var idArr = alreadyinputIds.split(',');
			 
			for(var i = 0; i < idArr.length; i++) {
				// alert(idArr[i]);
				 
				if(idArr[i].length == 0) {
					continue;
				} else {
					var stringRegx = /[`~!@\#$%<>{}^&*\()\-=+_;:?\’|ㄱ-ㅎ|가-힣]/gi; 
					// var special =  /[`~!@#$%^&*|\\\'\";:\/?]/gi;
					
					if(stringRegx.test(idArr[i])) {
						continue;
					}
					 
					outputIds = outputIds + idArr[i] + ",";
				}
			}
		}
		
		outputIds = outputIds.substring(0,outputIds.lastIndexOf(","));
		
		// alert(outputIds)
		$("#TAKE_ID").val(outputIds);
	});
});
	
function sendCheck() {
    if ($("#TAKE_ID").val()=="" || $("#realNote").val()=="") {
        alert("필수 입력 사항을 모두 입력해 주세요.");
        return false;
    }
    
	return true;
   }

/* 글자 수 체크 */
$(document).ready(function() {
	//$(function() {
	    $('#realNote').keyup(function (e){
	        var content = $(this).val();
	        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
	        $('#counter').html(content.length + '/300');
	    });
	    $('#realNote').keyup();
	//});

    $("#TAKE_ID_CK").on("click", function () {
        modalSet(1);
    });
});

	function modalSet(pagenum) {
        <c:if test="${!empty sessionScope.user.id }">
            var id = "${sessionScope.user.id}";
        </c:if>
		var PAGE_NUM = pagenum;
        $("#followDiv").empty();
        $.ajax({
            type:"POST",
            url:"/user/followSearch.hi",
            dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
            data: {
                "id": id,
	            "PAGE_NUM": PAGE_NUM
            },
            success: function (data) {
                // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                var followList = $.parseJSON(data);
                if (followList.length == 0) {
                    $("#followDiv").append("<li><a href=\"#\">\"이웃이 없습니다.\"</a></li>");
                } else {
                    for (var i = 0; i < followList.length; i++) {
                        var followUrl = "javascript:in_follow(\'" + followList[i].ID + "\')";
                        var followName = followList[i].NAME + "(" + followList[i].ID + ")";
                        $("#followDiv").append("<p><a href=\"" + followUrl + "\">" + followName + "</a></p>");
                    }
                    // 페이징
                    var pagingString = paging(followList[0].TOT_CNT, pagenum, 10, 10, "modalSet");
                    $("#followDiv").append("<center><table><tr><td style='text-align: center;'>" + pagingString + "</td></tr></table></center>");
                }
            },
            complete: function (data) {
                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
            },
            error: function (xhr, status, error) {
                alert("에러발생");
            }
        });
    }

    function paging(maxnum, currpageno, rowperpage, bottomcount, scriptname) {
        var maxNum = 0; // 총 갯수
        var currPageNo = 1; // 현재 페이지 번호 : page_num
        var rowPerPage = 10; // 한페이지에 보여질 행수 : page_size
        var bottomCount = 10; // 바닥에 보여질 페이지 수: 10

        maxNum = maxnum;
        currPageNo = currpageno;
        rowPerPage = rowperpage;
        bottomCount = bottomcount;

        var scriptName = scriptname; // 호출 자바스크립트

        var maxPageNo = ((maxNum - 1) / rowPerPage) + 1;
        var startPageNo = ((currPageNo - 1) / bottomCount) * bottomCount + 1;//
        var endPageNo = ((currPageNo - 1) / bottomCount + 1) * bottomCount;
        var nowBlockNo = ((currPageNo - 1) / bottomCount) + 1;
        var maxBlockNo = ((maxNum - 1) / bottomCount) + 1;

        var inx = 0;
        var html = "";
        if (currPageNo > maxPageNo) {
            return "";
        }
        html = html + "<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
        html = html + "<tr>\n";
        html = html + "<td class=\"list_num\">\n";
        html = html + "<ul class=\"pagination pagination-sm\">\n";

        // 1 2 3 ... 10	(숫자보여주기)
        for (inx = 1; inx <= maxPageNo && inx <= endPageNo; inx++) {

            if (inx == currPageNo) {
                html = html + "<li class='active'><a href='#'>" + inx	+ "</a></li>";
            } else {
                html = html + "<li><a href=\"javascript:" + scriptName + "(" + inx+ ");\" class=\"num_text\">" + inx + "</a></li> \n";
            }
        }

        html = html + "</ul>		\n";
        html = html + "</td>  	\n";
        html = html + "</tr>  	\n";
        html = html + "</table>   \n";

        return html;
    }

function in_follow(followId) {
	var alreadyinputIds = '';
	alreadyinputIds = $("#TAKE_ID").val();
	
	if(alreadyinputIds.length == 0) {	
		followId = followId;	
	} else {
		// 검사
		var index = alreadyinputIds.indexOf(followId);	
		
		if(index == -1) {
			followId = alreadyinputIds + ',' + followId
		} else {
			followId = alreadyinputIds;
		}
	}
	
	$("#TAKE_ID").val(followId);
       $("#myModal").modal('toggle');
}
</script>

<style type="text/css">
	#wrap span {
	    position: absolute;
	    bottom: 5px;
	    right: 20px;
	}

	#counter {
		/* background:rgba(255,0,0,0.5);
		border-radius: 0.5em;
		padding: 0 .5em 0 .5em;
		font-size: 0.75em; */
	}	
</style>


</head>
<body>

	<!--헤더 START-->
	<jsp:include page="/header.hi" />
	<!--헤더 END-->
	<div class="container">
		<br> <br> <br> <br>
		<!-- 헤더때문에 윗에 공백 넣어주는거임 -->

		<!-- 좌측메뉴 -->
		<div class="col-xs-2">
		<jsp:include page="menu.jsp" flush="false">
			<jsp:param name="unReadNotes" value="<%=unReadNotes%>" />
		</jsp:include>
		</div>

		<!--내용 START -->
		<div class="col-xs-10" style="min-height: 700px">
			<center>
				<h2>:: 쪽지쓰기 ::</h2>
			</center>
			<br>
			<div class="col-xs-1"></div>
			<div class="col-xs-8">
				<form id="textNote" action="write.hi" method="post" class="form-horizontal">
					<input type="hidden" name="SEND_ID" value="<%=SENDID %>" />
					

					<div class="form-group">
						<label class="col-lg-2 control-label">받는사람</label>
						<div class="col-lg-7">
						<%
						if(TAKEID != null) {
						%>
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID"
									placeholder="<%=TAKEID %>" value="<%=TAKEID %>" maxlength="30">
						<%	
						} else {
						%>	
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID"
									placeholder="hifive" maxlength="30">
						<% 
						}
						%>
						</div>
						<div class="col-lg-3">
							<button type="button" class="btn btn-info btn-block" data-toggle="modal" data-target="#myModal" 
								id="TAKE_ID_CK"	name="TAKE_ID_CK">
								이웃목록보기
							</button>

							<!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											<h4 class="modal-title" id="myModalLabel">이웃 목록</h4>
										</div>
										<div class="modal-body" id="followDiv">
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
					<div class="col-lg-2"></div> 
					<div class="col-lg-10" style="font-size: 12px;color: #003399">* 최대5명에게 그룹쪽지를 보낼수 있습니다.</div></div>
					
					<div id="wrap" class="form-group">
						<label class="col-lg-2 control-label">내용</label>
						<div class="col-lg-10">
							<textarea id="realNote" name="NOTE" 
							rows="10" maxlength="300" style="resize: none; min-height: 200px"
							class="form-control" ></textarea>
							<span id="counter">###</span>
						</div>
					</div>
					
					<div class="form-group">
						<button id="sending" class="btn btn-danger col-lg-3 col-md-offset-3" type="button">보내기</button>
						<button class="btn btn-default col-lg-3 col-md-offset-1" type="reset">Cancel</button>
					</div>
				</form>
			</div>
			<div class="col-xs-3"></div>
		</div>
		<br> <br> <br> <br> <br>
	</div>
	<!--푸터 START -->
	<jsp:include page="../main/footer.jsp" />
	<!--푸터 START -->
</body>
</html>