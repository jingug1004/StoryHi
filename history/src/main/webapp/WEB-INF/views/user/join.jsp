<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>

	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		var idCheck = false;
		var emailCheck = false;
		var verifiedEmail = "";
		var passwordCheck = false;
		$(document).ready(function () {
            $("#id").on({
				focus: function () {
				    idCheck = false;
                    $("#idCheckSuccess").hide();
                    $("#idCheckFail").hide();
					$("#idOnlyEngNum").hide();
                },
	            blur: function () {
                    var id = $("#id").val();
                    if (id != "") {
                    	if (!validateID(id) || id.length < 4 || id.length > 12) {
							$("#idOnlyEngNum").show();
		                    idCheck = false;
                    		return;
	                    }

                        $.ajax({
                            type: "POST",
                            url: "/user/idCheck.hi",
                            dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
                            data: {
                                "id": id
                            },
                            success: function (data) {
                                // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                                var flag = $.parseJSON(data);
                                if (flag.msg == "true") {
                                    $("#idCheckSuccess").show();
                                    idCheck = true;
                                }
                                else {
                                    $("#idCheckFail").show();
                                    idCheck = false;
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
                }
            });
            $("#email").on("blur", function () {
                if ($(this).val() != verifiedEmail) {
                    $("#emailCheckSuccess").hide();
                    emailCheck = false;
                    $("#cknum").val("");
                    $("#emailCheckFail").show();
                }
            });
            $("#emailCk").on("click", function () {
                var email = $('#email').val();
                if (!validateEmail(email)) {
                    alert("이메일 주소 형식이 틀립니다.")
	                return;
                } else {
                	// $('#divEmailConfirm').show();
                }
                $.ajax({
                    type: "POST",
                    url: "/user/generated.hi",
                    dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
                    data: {
                        "email": email
                    },
                    success: function (data) {
                        // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                        var flag = $.parseJSON(data);
                        if (flag.msg == "true") {
                            var digit = flag.digit;
                            $('#hiddenDigit').val(digit);
                            alert("인증메일이 전송되었습니다.");
                            $('#divEmailConfirm').show(); ///-> 75번 라인으로  
                        }
                    },
                    complete: function (data) {
                        // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
                    },
                    error: function (xhr, status, error) {
                        alert("인증메일이 전송에 실패하였습니다.");
                    }
                });
            });
            $("#emailCkaf").on("click", function () {
                if($('#hiddenDigit').val() == $('#cknum').val()) {
                    alert('인증되었습니다.');
                    $('#divEmailConfirm').hide();
                    verifiedEmail = $('#email').val();
					emailCheck = true;
					$("#emailCheckFail").hide();
					$("#emailCheckSuccess").show();
                } else {
                    alert('인증 번호를 다시 확인해주세요.');
                    emailCheck = false;
                    $("#emailCheckSuccess").hide();
                    $("#emailCheckFail").show();
                }
            });
            $("#join").on("click", function () {
                if (joinCheck()) {
                    $("#joinForm").submit();
                }
            });
			$("#password").on({
				keyup: function () {
					pwCheck();
				},
				change: function () {
					pwCheck();
				}
			});
			$("#passwordCheck").on({
				keyup: function () {
					pwCheck();
				},
				change: function () {
					pwCheck();
				}
			});
			// 사진찾기를 클릭시 파일인풋클릭되게 하는 스크립트
			document.querySelector('#upload_btn').addEventListener('click', function(e) {
				document.querySelector('#fileInput').click();
			}, false);
        });
		function pwLengthCheck() {
			if ($("#password").val().length >= 4 && $("#password").val().length <= 12) {
				$("#pwLengthFail").hide();
				return true;
			} else {
				$("#pwLengthFail").show();
				$("#pwCheckFail").hide();
				$("#pwCheckSuccess").hide();
				passwordCheck = false;
				return false;
			}
		}
		function pwCheck() {
			if (pwLengthCheck()) {
				if ($("#password").val() == $("#passwordCheck").val()) {
					$("#pwCheckFail").hide();
					$("#pwCheckSuccess").show();
					passwordCheck = true;
				} else {
					$("#pwCheckSuccess").hide();
					$("#pwCheckFail").show();
					passwordCheck = false;
				}
			}
		}
		function joinCheck() {
		    if ($("#id").val()=="" || $("#email").val()=="" || $("#password").val()=="" || $("#passwordCheck").val()==""
			    || $("#name").val()=="" || $("#birthday").val()=="") {
		        alert("필수 입력 사항을 모두 입력해 주세요.");
		        return false;
		    }
		    if (!passwordCheck) {
                alert("패스워드를 확인해주세요.");
                return false;
		    }
		    if (!idCheck) {
		        alert("사용할 수 없는 ID입니다.");
			    return false;
		    }
		    if (!emailCheck) {
		        alert("이메일이 인증되지 않았습니다.");
			    return false;
		    }
		    if ($("#birthday").val().indexOf('-') != 4) {
		    	alert("날짜포맷이 맞지 않았습니다.");
			    return false;
		    }
			return true;
        }
        function validateEmail(email) {
            var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
            return re.test(email);
        }
		function loadname(img, previewName){
			var isIE = (navigator.appName=="Microsoft Internet Explorer");
			var path = img.value;
			var default_path = "/resources/image/girl.png";
			var ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase();
			var incorrect = "";
			if (ext == "gif" || ext == "jpeg" || ext == "jpg" ||  ext == "png" ) {
				if (isIE) {
					$('#'+ previewName).attr('src', path);
				} else {
					if (img.files[0]) {
						var reader = new FileReader();
						reader.onload = function (e) {
							$('#'+ previewName).attr('src', e.target.result);
						}
						reader.readAsDataURL(img.files[0]);
					}
				}
			} else if (ext != "") {
				$('#'+ previewName).attr('src', default_path);
				if (isIE) {
					$('#fileInput').replaceWith( $('#fileInput').clone(true) );
				} else {
					$('#fileInput').val("");
				}
				incorrect += "파일 형식이 올바르지 않습니다.";
				alert(incorrect);
			} else {
				$('#'+ previewName).attr('src', default_path);
				incorrect += "incorrect file type";
			}
		}
		function validateID(id) {
			var re = /^[_A-Za-z0-9-]*$/ ;
			return re.test(id);
		}
	</script>
</head>
<body>

<%
	List<String> areaList = (ArrayList<String>)request.getAttribute("areaList");
%>

<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->
<h1 align="center">회원가입</h1>
<br>
<div class="col-xs-2"></div>	<!--여백용  -->
	<div class="col-xs-8" >
	
		<!-- form명 바꾸면 안되요 : id, name꼭 다시 확인하세요.. 중복된 이름이 있을수도 있음  -->
			<form class="form-horizontal" action="/user/join.hi" method="post" enctype="multipart/form-data" id="joinForm">
				<input type="hidden" name="do_join" value="do_join">
				<div class="form-group" >
					<span class="label label-danger">필수입력사항</span>
				</div>

				<div class="form-group" id="divId">
					<label for="divId" class="col-lg-2 control-label">ID</label>
					<div class="col-lg-10">
						<input type="text" class="form-control onlyHangul" id="id"
							name="id" data-rule-required="true" placeholder="원하는ID를 입력하세요"
							maxlength="20" style="ime-mode: disabled" onkeydown="nonHangulSpecialKey()">
<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: green" hidden="hidden" id="idCheckSuccess"> 사용하실 수 있는 ID입니다. </p>
										<p style="color: red" hidden="hidden" id="idOnlyEngNum"> 4~12자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다. </p>
<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: red" hidden="hidden" id="idCheckFail"> ID가 이미 존재합니다. 다른 ID를 선택하세요. </p>
					</div>
				</div>

				<div class="form-group" id="divEmail">
					<label for="divEmail" class="col-lg-2 control-label">이메일</label>
					<div class="col-lg-8">
						<input type="email" class="form-control" id="email" name="email"
							placeholder="이메일" maxlength="30">
						<p style="color: green" hidden="hidden" id="emailCheckSuccess"> 인증이 완료되었습니다. </p>
						<p style="color: red" hidden="hidden" id="emailCheckFail"> 메일 확인 후 인증번호를 확인해주세요. </p>
					</div>
					<div class="col-lg-2">
						<button type="button" class="btn btn-danger btn-block" id="emailCk"
						        name="emailCk">인증</button>
					</div>
				</div>

				<div class="form-group" id="divEmailConfirm" hidden="hidden">
					<label for="divEmailConfirm" class="col-lg-2 control-label">인증번호 입력</label>
					<div class="col-lg-8">
						<input type="hidden" id="hiddenDigit" value="" />
						<input type="text" class="form-control" id="cknum" name="cknum"
							placeholder="메일확인후 인증번호를 입력하세요" maxlength="30">
					</div>
					<div class="col-lg-2">
						<button type="button" class="btn btn-success btn-block" id="emailCkaf"
						        name="emailCkaf">확인</button>
					</div>
				</div>

				<div class="form-group" id="divPassword">
					<label for="divPassword" class="col-lg-2 control-label">패스워드</label>
					<div class="col-lg-10">
						<input type="password" class="form-control" id="password" style="font-family: 'Nanum Gothic', sans-serif;"
							name="password" data-rule-required="true" placeholder="패스워드"
							maxlength="12">
						<p style="color: red" hidden="hidden" id="pwLengthFail"> 패스워드의 길이는 4자 이상 12자 이내로 해주세요. </p>
					</div>
				</div>

				<div class="form-group" id="divPasswordCheck">
					<label for="divPasswordCheck" class="col-lg-2 control-label">패스워드
						확인</label>
					<div class="col-lg-10">
						<input type="password" class="form-control" id="passwordCheck" style="font-family: 'Nanum Gothic', sans-serif;"
							data-rule-required="true" placeholder="패스워드 확인" maxlength="12">

						<p style="color: green" hidden="hidden" id="pwCheckSuccess"> 패스워드가 일치합니다. </p>
						<p style="color: red" hidden="hidden" id="pwCheckFail"> 패스워드와 패스워드 확인이 서로 다릅니다. </p>
					</div>
				</div>

				<div class="form-group" id="divName">
					<label for="divName" class="col-lg-2 control-label">닉네임</label>
					<div class="col-lg-10">
						<input type="text" class="form-control onlyHangul" id="name"
							name="name" data-rule-required="true" placeholder="사용할 닉네임을 입력하세요"
							maxlength="10">
					</div>
				</div>

				<div class="form-group" id="divbirthday">
					<label for="divbirthday" class="col-lg-2 control-label">생년월일</label>
					<div class="col-lg-10">
						<input type="date" class="form-control" id="birthday" name="birth">
					</div>
				</div>

				<div class="form-group">
					<label class="col-lg-2 control-label" for="select">지역</label>
					<div class="col-lg-10">
						<select class="form-control" id="select" name="area">
							<%
								for (String area : areaList) {
							%>
									<option><%=area%></option>
							<%
								}
							%>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-lg-2 control-label" for="select">성별</label>
					<div class="col-lg-10">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-default active">
								<input type="radio" name="sex" id="male" autocomplete="off" value="0" checked>
								남
							</label>
							<label class="btn btn-default">
								<input type="radio" name="sex" id="femail" autocomplete="off" value="1">
								여
							</label>
						</div>
					</div>
				</div>

				<hr>

				<div class="form-group" id="choose">
				<span class="label label-warning" >선택사항</span>
				</div>

				<div class="form-group" id="divProfileImg">
					<label for="divProfileImg" class="col-lg-2 control-label" style="color: #A6A6A6">프로필사진</label>
					<div class="col-lg-10">
						<img src="/resources/image/girl.png" width="130" name="previewimg" id="previewimg" alt="">
						<input type="file" accept="image/*" id="fileInput" name="profileImg" onchange="loadname(this,'previewimg')"  style="display:none;">
						<input type="button" value="사진찾기"  class="btn btn-default" id="upload_btn">
					</div>
				</div>

				<div class="form-group" id="divProfileCon">
					<label for="divProfileCon" class="col-lg-2 control-label" style="color: #A6A6A6">프로필내용</label>
					<div class="col-lg-10">
						<input type="text" class="form-control" id="profile"
							name="profileCon" data-rule-required="true" placeholder="안녕하세요."
							maxlength="36">
					</div>
				</div>
				<hr>		<!-- 구분선 -->

				<div class="col-xs-2"></div>	<!--여백용  -->

				<!-- 회원가입/취소 버튼 -->
				<div class="form-group" align="center">
					<button type="button" class="btn btn-info" id="join">회원가입</button>
					<a href="/"><input type="button" class="btn btn-default" id="cancel" value="취소" /></a>
				</div>
			</form>
	</div>
</div>

<br><br>
<!--내용 END -->

<!--푸터 START -->
<jsp:include page="/WEB-INF/views/main/footer.jsp"/>
<!--푸터 START -->

</body>
</html>