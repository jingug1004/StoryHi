<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <!-- Bootstrap CSS -->
	<link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="https://s.pstatic.net/pm2/css/main_v170324_2.css"/>
<link rel="stylesheet" type="text/css" href="https://ssl.pstatic.net/sstatic/search/pc/css/api_atcmp_170323.css"/>
<script type="text/javascript" src="https://s.pstatic.net/pm2/js/lib/nlog/lcslog.js"></script>
	

  
<style type="text/css">
/* html { */
/*   min-height: 100%; */
/* } */

/* body { */
/*   background: radial-gradient(ellipse at bottom left, rgba(104, 128, 138, 0.4) 10%, rgba(138, 114, 76, 0) 40%), linear-gradient(to bottom, rgba(57, 173, 219, .25), rgba(42, 60, 87, 0.4)), linear-gradient(135deg, #670d10, #092756); */
/* } */

/* h1 { */
/*   color: white; */
/*   padding-left: 10px; */
/* } */

/* #hover { */
/*   color: rgba(188, 175, 204, 0.9); */
/* } */

/* h2#testimonials { */
/*   color: #fffae3; */
/* } */

/* div#all { */
/*   width: 100%; */
/*   height: 100%; */
/* } */


/* generic css */

.view {
  margin: 10px;
  float: left;
  border: 10px solid #fff;
  overflow: hidden;
  position: relative;
  text-align: center;
  box-shadow: 1px 1px 2px #e6e6e6;
  cursor: default;
  background: #fff url(../images/bgimg.jpg) no-repeat center center
}

.view .mask,
.view .content {
  width: 300px;
  height: 200px;
  position: absolute;
  overflow: hidden;
  top: 0;
  left: 0
}

.view img {
  display: block;
  position: relative
}

.view h2 {
  text-transform: uppercase;
  color: #fff;
  text-align: center;
  position: relative;
  font-size: 17px;
  font-family: Raleway, serif;
  padding: 10px;
  /*background: rgba(0, 0, 0, 0.8);*/
  margin: 20px 0 0 0
}

.view p {
  font-family: Merriweather, serif;
  font-style: italic;
  font-size: 14px;
  position: relative;
  color: #fff;
  padding: 0px 20px 0px;
  text-align: center
}

.view a.info {
  display: inline-block;
  text-decoration: none;
  padding: 7px 14px;
  background: #000;
  color: #fff;
  font-family: Raleway, serif;
  text-transform: uppercase;
  box-shadow: 0 0 1px #000
}

.view a.info:hover {
  box-shadow: 0 0 5px #000
}


/*1*/

.view-first img {
  /*1*/
  transition: all 0.2s linear;
  width: 300px;
  height: 200px;
}

.view-first .mask {
  opacity: 0;
  background-color: rgba(58, 1, 132, 0.44);
  transition: all 0.4s ease-in-out;
}

.view-first h2 {
  transform: translateY(-100px);
  opacity: 0;
  font-family: Raleway, serif;
  transition: all 0.2s ease-in-out;
}

.view-first p {
  transform: translateY(100px);
  opacity: 0;
  transition: all 0.2s linear;
}

.view-first a.info {
  opacity: 0;
  transition: all 0.2s ease-in-out;
}


/* */

.view-first:hover img {
  transform: scale(1.1);
}

.view-first:hover .mask {
  opacity: 1;
}

.view-first:hover h2,
.view-first:hover p,
.view-first:hover a.info {
  opacity: 1;
  transform: translateY(0px);
}

.view-first:hover p {
  transition-delay: 0.1s;
}

.view-first:hover a.info {
  transition-delay: 0.2s;
}


/*2*/

.view-second img {
  transition: all 0.2s ease-in;
  -webkit-transition: all 0.2s ease-in;
}

.view-second .mask {
  background-color: rgba(12, 19, 27, 0.6);
  width: 300px;
  padding: 105px;
  height: 200px;
  opacity: 0;
  transform: translate(265px, 145px) rotate(45deg);
  -webkit-transform: translate(265px, 145px) rotate(45deg);
  transition: all 0.2s ease-in-out;
  -webkit-transition: all 0.2s ease-in-out;
}

.view-second h2 {
  border-bottom: 1px solid rgba(0, 0, 0, 0.3);
  font-family: Raleway, serif;
  background: transparent;
  margin: 20px 40px 0px 40px;
  -webkit-transform: translate(200px, -200px);
  transform: translate(200px, -200px);
  -webkit-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}

.view-second p {
  transform: translate(-200px, 200px);
  -webkit-transform: translate(200px, -200px);
  transition: all 0.2s ease-in-out;
  -webkit-transition: all 0.2s ease-in-out;
}

.view-second a.info {
  transform: translate(0px, 100px);
  -webkit-transform: translate(0px, 100px);
  transition: all 0.2s 0.1s ease-in-out;
  -webkit-transition: all 0.2s 0.1s ease-in-out;
}


/* */

.view-second:hover .mask {
  opacity: 1;
  transform: translate(-80px, -125px) rotate(45deg);
  -webkit-transform: translate(-80px, -125px) rotate(45deg);
}

.view-second:hover h2 {
  transform: translate(0px, 0px);
  -webkit-transform: translate(0px, 0px);
  transition-delay: 0.3s;
  -webkit-transition-delay: 0.3s;
}

.view-second:hover p {
  transform: translate(0px, 0px);
  -webkit-transform: translate(0px, 0px);
  transition-delay: 0.4s;
  -webkit-transition-delay: 0.4s;
}

.view-second:hover a.info {
  transform: translate(0px, 0px);
  -webkit-transform: translate(0px, 0px);
  transition-delay: 0.5s;
  -webkit-transition-delay: 0.5s;
}


/*3*/

.view-tenth img {
  transform: scaleY(1);
  transition: all .7s ease-in-out;
}

.view-tenth .mask {
  background-color: rgba(255, 231, 179, 0.3);
  transition: all 0.5s linear;
  opacity: 0;
}

.view-tenth h2 {
  border-bottom: 1px solid rgba(0, 0, 0, 0.3);
  background: transparent;
  margin: 20px 40px 0px 40px;
  transform: scale(0);
  color: #333;
  transition: all 0.5s linear;
  opacity: 0;
}

.view-tenth p {
  color: #333;
  opacity: 0;
  transform: scale(0);
  transition: all 0.5s linear;
  padding-
}

.view-tenth a.info {
  opacity: 0;
  transform: scale(0);
  transition: all 0.5s linear;
}

.view-tenth:hover img {
  -webkit-transform: scale(10);
  transform: scale(10);
  opacity: 0;
}

.view-tenth:hover .mask {
  opacity: 1;
}

.view-tenth:hover h2,
.view-tenth:hover p,
.view-tenth:hover a.info {
  transform: scale(1);
  opacity: 1;
}
</style>


<title>Insert title here</title>
</head>
<body>


<div id="all">

  <div class="view view-tenth">
    <img src="http://static1.squarespace.com/static/55ac6d80e4b0a964784b2f80/t/5703eb0cb09f95f41391ea85/1459874573710/j07SfQZ.png" />
    <div class="mask">
      <h2>글 제목</h2>
      <p>글 내용(안녕하세요 반갑습니다 잘해봅시다 이쁘게 되야할텐데)</p><p> 작성자 </p>
      <a href="#" class="info">글보러가기</a>
    </div>
  </div>




<!--   <div class="view view-first"> -->
<!--     <img src="http://static1.squarespace.com/static/55ac6d80e4b0a964784b2f80/t/5703e9208259b507928ad72a/1459874081584/xzKx01n.png" /> -->
<!--     <div class="mask"> -->
<!--       <h2>Empire State</h2> -->
<!--       <p>A cool description of some sort between these tags. I am so cool and awesomely awesome.</p> -->
<!--       <a href="#" class="info">Read More</a> -->
<!--     </div> -->
<!--   </div> -->


<!--   <div class="view view-second"> -->
<!--     <img src="http://static1.squarespace.com/static/55ac6d80e4b0a964784b2f80/t/5703eaab37013bdcee28c077/1459874476977/gw9SfTu.png" /> -->
<!--     <div class="mask"></div> -->
<!--     <div class="content"> -->
<!--       <h2>Midtown</h2> -->
<!--       <p>A description of some sort between these tags. I am so cool and awesomely awesome.</p> -->
<!--       <a href="#" class="info">Read More</a> -->
<!--     </div> -->
<!--   </div> -->




<!--   <div class="view view-second"> -->
<!--     <img src="http://static1.squarespace.com/static/55ac6d80e4b0a964784b2f80/t/5703eb2e746fb98cc2510ebd/1459874606989/PsZyN43.png" /> -->
<!--     <div class="mask"></div> -->
<!--     <div class="content"> -->
<!--       <h2 id="testimonials">Upper East Side</h2> -->
<!--       <p>&ldquo;A description of some sort between these tags. I am so cool ye and awesomely awesome. He was cool.&rdquo;</p> -->
<!--       <a href="#" class="info">Read More</a> -->
<!--     </div> -->
<!--   </div> -->



<div class="section_themecast" id="themecast">
		<h2 class="blind">주제형 캐스트</h2>
		<div class="themecast_category" id="PM_ID_themecastNavi">
			<div class="area_category">
				<h3 class="blind">관심 주제 선택</h3>
				<div class="ac_scroll" role="tablist">
					<div class="scroll-area" role="presentation">
						<!-- style="width:xxxxPX" -->
						<div class="rolling-container" id="PM_ID_themelist" role="presentation" style="overflow: hidden;">
							<ul class="PM_CL_beforeMove" style="width: 1280px;" queryid="C1490578881956518708">
								<li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_livinghome" role="tab" aria-selected="false" href="#LIVINGHOME" data-clk="tct.lif" data-id="LIVINGHOME"><span class="blind">리빙</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_living" role="tab" aria-selected="false" href="#LIVING" data-clk="tct.fod" data-id="LIVING"><span class="blind">푸드</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_sports" role="tab" aria-selected="false" href="#SPORTS" data-clk="tct.spo" data-id="SPORTS"><span class="blind">스포츠</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_cargame" role="tab" aria-selected="false" href="#CARGAME" data-clk="tct.aut" data-id="CARGAME"><span class="blind">차·테크</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_beauty" role="tab" aria-selected="false" href="#BEAUTY" data-clk="tct.bty" data-id="BEAUTY"><span class="blind">패션뷰티</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_momkids" role="tab" aria-selected="false" href="#MOMKIDS" data-clk="tct.mom" data-id="MOMKIDS"><span class="blind">맘·키즈</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_health" role="tab" aria-selected="false" href="#HEALTH" data-clk="tct.hea" data-id="HEALTH"><span class="blind">건강</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_bboom" role="tab" aria-selected="false" href="#BBOOM" data-clk="tct.web" data-id="BBOOM"><span class="blind">웹툰</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_gameapp" role="tab" aria-selected="false" href="#GAMEAPP" data-clk="tct.gam" data-id="GAMEAPP"><span class="blind">게임</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_video" role="tab" aria-selected="false" href="#VIDEO" data-clk="tct.tvc" data-id="VIDEO"><span class="blind">TV연예</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_music" role="tab" aria-selected="false" href="#MUSIC" data-clk="tct.muc" data-id="MUSIC"><span class="blind">뮤직</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_movie" role="tab" aria-selected="false" href="#MOVIE" data-clk="tct.mov" data-id="MOVIE"><span class="blind">영화</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_culture" role="tab" aria-selected="false" href="#CULTURE" data-clk="tct.bok" data-id="CULTURE"><span class="blind">책·문화</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_with" role="tab" aria-selected="false" href="#WITH" data-clk="tct.pub" data-id="WITH"><span class="blind">함께N</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_travel" role="tab" aria-selected="false" href="#TRAVEL" data-clk="tct.tra" data-id="TRAVEL"><span class="blind">여행+</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_design" role="tab" aria-selected="false" href="#DESIGN" data-clk="tct.des" data-id="DESIGN"><span class="blind">디자인</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_finance" role="tab" aria-selected="false" href="#FINANCE" data-clk="tct.fin" data-id="FINANCE"><span class="blind">경제M</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_job" role="tab" aria-selected="false" href="#JOB" data-clk="tct.job" data-id="JOB"><span class="blind">JOB&amp;</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_science" role="tab" aria-selected="false" href="#SCIENCE" data-clk="tct.sci" data-id="SCIENCE"><span class="blind">과학</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_knowledge tcc_on" role="tab" aria-selected="true" href="#KNOWLEDGE" data-clk="tct.ncc" data-id="KNOWLEDGE"><span class="blind">지식·교양</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_china" role="tab" aria-selected="false" href="#CHINA" data-clk="tct.chn" data-id="CHINA"><span class="blind">중국</span><span class="ac_icon"></span></a>
</li><li class="rolling-panel" role="presentation">
	<a class="PM_CL_themeItem ac_a tcc_business" role="tab" aria-selected="false" href="#BUSINESS" data-clk="tct.bus" data-id="BUSINESS"><span class="blind">비즈니스</span><span class="ac_icon"></span></a>
</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

</div>

</body>
</html>
