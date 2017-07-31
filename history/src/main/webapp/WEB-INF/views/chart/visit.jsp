<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%-- <%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	Calendar cal = Calendar.getInstance();
	List<Map<String,Object>> visitList = new ArrayList<Map<String,Object>>();
	visitList = (List<Map<String,Object>>)request.getAttribute("visitList");
	
	Date date = new Date();
	SimpleDateFormat sd = new SimpleDateFormat("YYYY-MM-DD");
	String comment2 = sd.format(date);
	date.setDate(date.getDate()-7);
	String comment1 = sd.format(date);
	
	
	
	Date enddate = null;
	String enddate_str = "";
	if(request.getAttribute("enddate") != null){
		enddate_str = (String)request.getAttribute("enddate");
		// enddate = sd.parse(enddate_str);
	}
	
	//블로그 테마색 불러오기
	if(session.getAttribute("user")!=null){
		UserDto user = (UserDto)session.getAttribute("user");
	}
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
	
%>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>블로그 관리/통계</title>
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawVisualization);

function drawVisualization() {
  // Some raw data (not necessarily accurate)
  var data = google.visualization.arrayToDataTable([
	['Month', '방문자', {role:'style'}],
   	['<%=visitList.get(0).get("CUR_DATE")%>',  <%=visitList.get(0).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(1).get("CUR_DATE")%>',  <%=visitList.get(1).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(2).get("CUR_DATE")%>',  <%=visitList.get(2).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(3).get("CUR_DATE")%>',  <%=visitList.get(3).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(4).get("CUR_DATE")%>',  <%=visitList.get(4).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(5).get("CUR_DATE")%>',  <%=visitList.get(5).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(6).get("CUR_DATE")%>',  <%=visitList.get(6).get("CNT")%>, 'color: #bff1ff'],
]);

	var options = {
	title : '방문자 분석',
	vAxis: {title: '방문수'},
	hAxis: {title: '선택기간 방문자'},
	seriesType: 'bars',
	series: {7: {type: 'line'}}
	};

	var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	chart.draw(data, options);
}
</script>
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
</style>

</head>
<body>
<!--헤더 START-->
	<jsp:include page="/header.hi" />
	<!--헤더 END-->

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
		       	<!-- <p style="font-size: 25px; margin-top: 20px;"> 방문자수</p><hr> -->
		       	<div class="col-xs-12" style="background-color: white; padding-top: 20px;">
		       	<fieldset>
		       	<legend><i class="icon-bar-chart"></i> 방문자수 통계</legend></fieldset>
		       	
		       	<form class="form-horizontal" id="search_form" method="post" action="visit.hi">
			       	<div class="form-group" id="startdate" style="margin-top: 10px">
						<div class="col-xs-4" style="text-align: right;margin-right: 0">
							<i class="icon-calendar" style="font-size: 35px; margin-top: 5px"></i>
						</div>
						
						<div class="col-xs-4" style="margin-left: 0; text-align: left">
							<input type="date" class="form-control" id="enddate" name="enddate" value="<%=enddate_str == null ? "": enddate_str%>">
							
						</div>
						<div class="col-xs-4">
							<button type="button" id="search" class="btn btn-danger"> 조회 </button>
						</div>
					</div>
				<div class="form-group">
				<p style="color: red; font-size: 13px; text-align: center;">* 선택한 날짜로부터 7일전까지의 데이터를 확인할 수 있습니다.</p>
				</div>
				
				</form>
		       	<div class="col-xs-12" id="chart_div" style="height: 500px"></div>
		       	<div class="col-xs-12">
		       	
		       	<br>
		       	
		       	<form class="form-horizontal" action="visitdown.hi">
					<span style="font-size: 13px;float: right;color: green"> * 선택한 날짜로부터 1달치 데이타가 엑셀로 저장됩니다</span><br>
		       		<span style="font-weight: bold;font-size: 18px">일별 방문자수</span>
		       		<button type="submit" class="btn btn-success btn-sm" style="float: right;"> 엑셀로 저장 </button>
		       		<table class="table table-bordered" style="margin-top: 20px;">
		        	<tr class="info">
						<td style="font-size: 11px">날짜</td>
						<%
							for(int i =0; i < visitList.size(); ++i){
						%>
						<td style="font-size: 11px"><%=visitList.get(i).get("CUR_DATE") %></td>
						<%
							}
						%>
		        	</tr>
		        	<tr>
		        		<td style="font-size: 11px;vertical-align: center">방문</td>
		        		<%
							for(int i =0; i < visitList.size(); ++i){
						%>
						<td style="text-align: center; "><%=visitList.get(i).get("CNT") %>명</td>
						<%
							}
						%>
		        	</tr>
		        	</table>
		        </form>
		       	</div>
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

<script type="text/javascript">
$(document).ready(function () {
	$("#search").on("click", function () {
		if ($("#enddate").val().indexOf('-') != 4) {
	    	alert("날짜포맷이 맞지 않았습니다.");
		    return false;
	    }else{
	    	$("#search_form").submit();
	    }
	});
});
</script>
</body>
</html>