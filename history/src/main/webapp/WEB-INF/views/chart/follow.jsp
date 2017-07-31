<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	Calendar cal = Calendar.getInstance();
	
	List<Map<String, Object>> followIncList = new ArrayList<Map<String,Object>>();
	followIncList = (List<Map<String,Object>>)request.getAttribute("followIncList");
	
	List<Map<String, Object>> followDecList = new ArrayList<Map<String,Object>>();
	followDecList = (List<Map<String,Object>>)request.getAttribute("followDecList");
	
	//블로그 테마색 불러오기
	if(session.getAttribute("user")!=null){
		UserDto user = (UserDto)session.getAttribute("user");
	}
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
%>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['내 팔로우 감소 추이', '증가', '감소'],
          ['<%=followIncList.get(0).get("CUR_DATE")%>',  <%=followIncList.get(0).get("CNT")%>, <%=followDecList.get(0).get("CNT")%>],
          ['<%=followIncList.get(1).get("CUR_DATE")%>',  <%=followIncList.get(1).get("CNT")%>, <%=followDecList.get(1).get("CNT")%>],
          ['<%=followIncList.get(2).get("CUR_DATE")%>',  <%=followIncList.get(2).get("CNT")%>, <%=followDecList.get(2).get("CNT")%>],
          ['<%=followIncList.get(3).get("CUR_DATE")%>',  <%=followIncList.get(3).get("CNT")%>, <%=followDecList.get(3).get("CNT")%>],
          ['<%=followIncList.get(4).get("CUR_DATE")%>',  <%=followIncList.get(4).get("CNT")%>, <%=followDecList.get(4).get("CNT")%>],
          ['<%=followIncList.get(5).get("CUR_DATE")%>',  <%=followIncList.get(5).get("CNT")%>, <%=followDecList.get(5).get("CNT")%>],
          ['<%=followIncList.get(6).get("CUR_DATE")%>',  <%=followIncList.get(6).get("CNT")%>, <%=followDecList.get(6).get("CNT")%>]
        ]);

        var options = {
          title: '이웃증감 분석',
          hAxis: {title: '범위 내 분석',  titleTextStyle: {color: '#111'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>

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
</style>

</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
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
		      	<div class="col-xs-12" style="background-color: white; padding-top: 20px;">
		       	<fieldset>
		       	<legend><i class="icon-bar-chart"></i> 이웃증감 통계</legend></fieldset>
		       	
		       	<!-- <p style="font-size: 25px; margin-top: 20px">이웃증감</p><hr> -->
		       	<form class="form-horizontal" id="search_form" method="post" action="follow.hi">
		        	<div class="form-group" id="endday" style="margin-top: 10px">
		        	
						<div class="col-xs-4" style="text-align: right;margin-right: 0">
							<i class="icon-calendar" style="font-size: 35px; margin-top: 5px"></i>
						</div>
						<div class="col-xs-4">
							<input type="date" class="form-control" id="enddate" name="enddate">
						</div>
						<div class="col-xs-4">
							<button type="submit" id="search" class="btn btn-danger"> 조회 </button>
						</div>
					</div>
				<div class="form-group">
				<p style="color: red; font-size: 13px; text-align: center;">* 선택한 날짜로부터 7일전까지의 데이터를 확인할 수 있습니다.</p>
				</div>
				</form>
				<div id="chart_div" style="width: 100%; height: 500px;"></div>
					<div class="col-xs-12">
		       		
		        	<h5>이웃증감</h5>
		       		<table class="table table-bordered" style="margin-top: 10px;">
		        	<tr class="info">
						<td style="font-size: 11px">날짜</td>
						<%
							for(int i =0; i < followIncList.size(); ++i){
						%>
						<td style="font-size: 11px"><%=followIncList.get(i).get("CUR_DATE") %></td>
						<%
							}
						%>
		        	</tr>
		        	<tr>
		        		<td style="font-size: 11px;vertical-align: center">증가</td>
		        		<%
							for(int i =0; i < followIncList.size(); ++i){
						%>
						<td style="text-align: center; "><%=followIncList.get(i).get("CNT") %>명</td>
						<%
							}
						%>
		        	</tr>
		        	<tr>
		        		<td style="font-size: 11px;vertical-align: center">감소</td>
		        		<%
							for(int i =0; i < followDecList.size(); ++i){
						%>
						<td style="text-align: center; "><%=followDecList.get(i).get("CNT") %>명</td>
						<%
							}
						%>
		        	</tr>
		        	</table>
		        	
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

<!-- <script>
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
</script> -->

</body>
</html>