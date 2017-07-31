<%@page import="java.text.DecimalFormat"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.BlogDto"%>
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
	//성별, 연령별 데이버 받아오는 부분
	List<Map<String,Object>> visitAgeList = new ArrayList<Map<String,Object>>();
	visitAgeList = (List<Map<String,Object>>)request.getAttribute("visitAgeList");
	
	Date date = new Date();
	SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	
	// 시작일과 종료일이 Defaul로 오늘 날짜로 부터 일주일간의 데이터를 불러옴
	String comment2 = sd.format(date);
	date.setDate(date.getDate()-7);
	String comment1 = sd.format(date);
	
	if(request.getAttribute("comment1")!=null){
		comment1 = (String)request.getAttribute("comment1");
		comment2 = (String)request.getAttribute("comment2");
	}
	
// 	성별 통계 (사람모양)
	Double sumMen = 0.0;
	Double sumWomen = 0.0;
	Double totSum=0.0;
	for(int i=1;i<6;i++){
		sumMen += Integer.parseInt(visitAgeList.get(0).get("MEN"+i+"0").toString());
		sumWomen += Integer.parseInt(visitAgeList.get(0).get("WOMEN"+i+"0").toString());
	}
	totSum = sumMen+sumWomen;
	DecimalFormat f1 = new DecimalFormat("0.0"); 
	// % 구하기
	Double ppMen 	= (sumMen/totSum)*100;
	Double ppWomen	= (sumWomen/totSum)*100;
	if(ppMen.toString().equalsIgnoreCase("NaN")) ppMen = 0.0;
	if(ppWomen.toString().equalsIgnoreCase("NaN")) ppWomen = 0.0;
	
	String d1 = f1.format(ppMen); 
	String d2 = f1.format(ppWomen);
	
// 나이별 통계 
	Double sum10 = 0.0,sum20 = 0.0,sum30 = 0.0,sum40 = 0.0,sum50 = 0.0;
	Double totageSum = 0.0;
	sum10 = Double.valueOf(visitAgeList.get(0).get("MEN10").toString())+Integer.parseInt(visitAgeList.get(0).get("WOMEN10").toString());
	sum20 = Double.valueOf(visitAgeList.get(0).get("MEN20").toString())+Integer.parseInt(visitAgeList.get(0).get("WOMEN20").toString());
	sum30 = Double.valueOf(visitAgeList.get(0).get("MEN30").toString())+Integer.parseInt(visitAgeList.get(0).get("WOMEN30").toString());
	sum40 = Double.valueOf(visitAgeList.get(0).get("MEN40").toString())+Integer.parseInt(visitAgeList.get(0).get("WOMEN40").toString());
	sum50 = Double.valueOf(visitAgeList.get(0).get("MEN50").toString())+Integer.parseInt(visitAgeList.get(0).get("WOMEN50").toString());
	
	totageSum = sum10+sum20+sum30+sum40+sum50;
	// % 구하기
	Double ppsum10 = (sum10/totageSum)*100;
	Double ppsum20 = (sum20/totageSum)*100;
	Double ppsum30 = (sum30/totageSum)*100;
	Double ppsum40 = (sum40/totageSum)*100;
	Double ppsum50 = (sum50/totageSum)*100;
	
	if(ppsum10.toString().equalsIgnoreCase("NaN")) ppsum10 = 0.0;
	if(ppsum20.toString().equalsIgnoreCase("NaN")) ppsum20 = 0.0;
	if(ppsum30.toString().equalsIgnoreCase("NaN")) ppsum30 = 0.0;
	if(ppsum40.toString().equalsIgnoreCase("NaN")) ppsum40 = 0.0;
	if(ppsum50.toString().equalsIgnoreCase("NaN")) ppsum50 = 0.0;
	
	
	String age1 = f1.format(ppsum10); 
	String age2 = f1.format(ppsum20);
	String age3 = f1.format(ppsum30);
	String age4 = f1.format(ppsum40);
	String age5 = f1.format(ppsum50);

	
	//블로그 테마색 불러오기
	if(session.getAttribute("user")!=null){
		UserDto user = (UserDto)session.getAttribute("user");
	}
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
   ['Month', '남자' , '여자'],
   ['10대',  <%=visitAgeList.get(0).get("MEN10") %>, <%=visitAgeList.get(0).get("WOMEN10") %>],
   ['20대',  <%=visitAgeList.get(0).get("MEN20") %>, <%=visitAgeList.get(0).get("WOMEN20") %>],
   ['30대',  <%=visitAgeList.get(0).get("MEN30") %>,  <%=visitAgeList.get(0).get("WOMEN30") %>],
   ['40대',  <%=visitAgeList.get(0).get("MEN40") %>, <%=visitAgeList.get(0).get("WOMEN40") %>],
   ['50대',  <%=visitAgeList.get(0).get("MEN50") %>, <%=visitAgeList.get(0).get("WOMEN50") %>]

]);

var options = {
title : '성별분석',
vAxis: {title: '방문수'},
hAxis: {title: '<%=comment2%> ~ <%=comment1%>'},
seriesType: 'bars',
series: {5: {type: 'line'}}
};

var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
chart.draw(data, options);
}
</script>
<script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['ages', 'Hours per Day'],
          ['10대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN10").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN10").toString()) %>],
          ['20대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN20").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN20").toString()) %>],
          ['30대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN30").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN30").toString()) %>],
          ['40대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN40").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN40").toString()) %>],
          ['50대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN50").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN50").toString()) %>]
        ]);

        var options = {
          title: '연령별 분석',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
</script>



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



/* 통계-네이버스타일 */
em { font-style: normal; }
/* Common Sprite Images */
.chart-mask,
.chart-male,
.chart-female{	background:url(http://cfile8.uf.tistory.com/image/2224F3375832C6D91F0A83) no-repeat;
}

.chart-box-wrap{padding:31px 0 42px;background:url(http://cfile5.uf.tistory.com/image/2270834358321490110214) repeat-x;text-align:center}
.chart-box-inner{display:inline-block;vertical-align:top}
.chart-box-inner:after{display:block;clear:both;content:''}
.chart-progress{position:relative;float:left;margin-left:28px;width:32px;height:130px}
.chart-progress:first-child{margin-left:0}
.chart-progressIn{position:absolute;bottom:0;left:0;right:0;background:#d9dee3}
.chart-percent{position:absolute;left:0;text-align:center;white-space:nowrap;font-size:14px;font-weight:bold}
.chart-percent.chart-zero{color:#898a8a!important}
.chart-target{position:absolute;left:0;text-align:center;white-space:nowrap;font-size:12px;color:#353535}
.chart-mask{position:absolute;bottom:0;left:0;width:100%;height:127px}
.chart-sex, .chart-age{float:left}
.chart-age{margin-left:60px}
.chart-male{width:51px;height:125px;margin:5px 0 0 0;background-position:0 0} /* 부모 박스에 회색(디폴트) 백그라운드 정의 */
.chart-male .chart-progressIn{bottom:1px;left:1px;right:1px;background:#2db9c2}
.chart-male .chart-percent{color:#2db9c2}
.chart-male .chart-mask{background-position:-60px 0} /* 자식 박스모델에 뚫린 이미지(백그라운드) 정의 */
.chart-female{width:58px;height:125px;margin:5px 0 0 11px;background-position:-120px 0} /* 부모 박스에 회색(디폴트) 백그라운드 정의 */
.chart-female .chart-progressIn{bottom:1px;left:1px;right:1px;background:#ef4c3b}
.chart-female .chart-percent{color:#ef4c3b}
.chart-female .chart-mask{background-position:-190px 0} /* 자식 박스모델에 뚫린 이미지(백그라운드) 정의 */
.chart-sex .chart-percent{top:-25px;width:100%}
.chart-sex .chart-target{bottom:-25px;width:100%}
.chart-age .chart-percent{top:-18px;width:40px;margin-left:-5px}
.chart-age .chart-target{bottom:-24px;width:100%}
.chart-progress-100 .chart-progressIn,
.chart-progress-top .chart-progressIn{background:#7e44ae}
.chart-progress-100 .chart-percent,
.chart-progress-top .chart-percent{color:#7e44ae}
.chart-progress-100 .chart-percent{top:-20px}
.chart-progress-0 .chart-percent{color:#898a8a}
.chart-progress-lower .chart-percent{color:#717172}

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
		       	<legend><i class="icon-bar-chart"></i> 방문자수 성별/연령별 통계</legend></fieldset>
		       	
		       	<!-- <p style="font-size: 25px; margin-top: 20px">방문자수</p> -->
		       	
		       	<form class="form-horizontal" method="post" action="age.hi" name="agechart" id="agechart">
		       	<div class="form-group" id="" style="margin-top: 10px">
						<div class="col-xs-1" style="text-align: right;margin-right: 0">
							<i class="icon-calendar" style="font-size: 35px; margin-top: 5px"></i>
						</div>
					<div class="col-xs-4">
						<input type="date" class="form-control" id="startdate" name="startdate">
					</div>
					<div class="col-xs-1"><h4><i class="icon-ellipsis-horizontal"></i></h4></div>
					<div class="col-xs-4">
						<input type="date" class="form-control" id="enddate" name="enddate">
					</div>
					<div class="col-xs-2">
						<button type="button"  id="search" class="btn btn-danger"> 조회 </button>
					</div>
				</div>
				</form>
				
				<div class="clearfix"></div><br>
<!--여긴 테스트 미현 ============================================================================================================  -->

<div class="chart-box-wrap">
	<div class="chart-box-inner">
	
<!-- 	성별 -->
		<div class="chart-sex">
			<!-- [D] 남자인 경우 : chart-male 추가 -->
			<div class="chart-progress chart-male">
				<!-- [D] 0% 일 때 : chart-zero 추가 -->
				<span class="chart-percent">
				<%=d1 %>
				<em>%</em></span>
				<span class="chart-progressIn" style="height:<%=d1 %>%"></span>
				<span class="chart-target">남성</span>
				<span class="chart-mask"></span>
			</div>
			<!-- [D] 여자인 경우 : chart-female 추가 -->
			<div class="chart-progress chart-female">
				<!-- [D] 0% 일 때 : chart-zero 추가 -->
				<span class="chart-percent">
				<%=d2 %>
				<em>%</em></span>
				<span class="chart-progressIn" style="height:<%=d2 %>%"></span>
				<span class="chart-target">여성</span>
				<span class="chart-mask"></span>
			</div>
		</div>
		
		
		
<!-- 		나이별 -->
		<div class="chart-age">
			<!-- [D]
				100% 인 그래프 : chart-progress-100 추가
				가장 높은 그래프 : chart-progress-top 추가
				가장 낮은 그래프 : chart-progress-lower 추가
				0% 인 그래프 : chart-progress-0 추가
			-->
			<div class="chart-progress chart-progress-100">
				<span class="chart-progressIn" style="height:<%=age1 %>%">
					<span class="chart-percent">
					<%=age1 %>
					<em>%</em></span>
				</span>
				<span class="chart-target"><span>10</span>대</span>
			</div>
			<div class="chart-progress chart-progress-100">
				<span class="chart-progressIn" style="height:<%=age2 %>%">
					<span class="chart-percent">
					<%=age2 %>
					<em>%</em></span>
				</span>
				<span class="chart-target"><span>20</span>대</span>
			</div>
			<!-- [D] 가장 높은 그래프 : chart-progress-top or chart-progress-100 추가 -->
			<div class="chart-progress chart-progress-100">
				<span class="chart-progressIn" style="height:<%=age3 %>%">
					<span class="chart-percent">
					<%=age3 %>
					<em>%</em></span>
				</span>
				<span class="chart-target"><span>30</span>대</span>
			</div>
			<div class="chart-progress chart-progress-100">
				<span class="chart-progressIn" style="height:<%=age4 %>%">
					<span class="chart-percent">
					<%=age4 %>
					<em>%</em></span>
				</span>
				<span class="chart-target"><span>40</span>대</span>
			</div>
			<div class="chart-progress chart-progress-100">
				<span class="chart-progressIn" style="height:<%=age5 %>%">
					<span class="chart-percent">
					<%=age5 %>
					<em>%</em></span>
				</span>
				<span class="chart-target">50대<em class="chart-up">↑</em></span>
			</div>
		</div>
	</div>
</div>

<!--여긴 테스트 미현 ============================================================================================================  -->
				
				
				<center>
				<br>
				<!--차트1  -->
			  	<hr style="border:2px dashed">
		       	<br>
		       	<div class="col-xs-12" id="chart_div" style="height: 500px;"></div>
		       	<br>
		       	<hr style="border:2px dashed">
		       	<!--차트2  -->
		       	<div class="col-xs-12" id="donutchart" style="height: 500px;"></div>
		       	</center>
		       	</div>




		       	
			<div class="col-xs-1"></div>
  		</div>
	</div>







<!--중간 END -->
	</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->

<script type="text/javascript">
$(document).ready(function () {
	$("#search").on("click", function () {
		if($("#startdate").val()<$("#enddate").val()){
			if ($("#startdate").val().indexOf('-') != 4 || $("#enddate").val().indexOf('-') != 4) {
		    	alert("날짜포맷이 맞지 않았습니다.");
			    return false;
		    }else{
		    	$("#agechart").submit();
		    }
		}else{
			alert("기간을 확인하세요");
		}
	});
});
</script>

</body>
</html>