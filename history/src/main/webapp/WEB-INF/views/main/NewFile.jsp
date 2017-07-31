<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <!-- Bootstrap CSS -->
	<link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
<style type="text/css">
.gallery-title
{
    font-size: 36px;
    color: #42B32F;
    text-align: center;
    font-weight: 500;
    margin-bottom: 70px;
}
.gallery-title:after {
    content: "";
    position: absolute;
    width: 7.5%;
    left: 46.5%;
    height: 45px;
    border-bottom: 1px solid #5e5e5e;
}
.filter-button
{
    font-size: 18px;
    border: 1px solid #42B32F;
    border-radius: 5px;
    text-align: center;
    color: #42B32F;
    margin-bottom: 30px;

}
.filter-button:hover
{
    font-size: 18px;
    border: 1px solid #42B32F;
    border-radius: 5px;
    text-align: center;
    color: #ffffff;
    background-color: #42B32F;

}
.filter-button.active
{
    background-color: #42B32F;
    color: white;
}
.port-image
{
    width: 100%;
}

.gallery_product
{
    margin-bottom: 30px;
}
/*  이미지와 텍스트 겹치기*/
#image{
   position:relative;
   float:left;
   overflow:hidden;/* div 박스 사이즈를 넘어간 값은 숨긴다*/ 
}
#image .text{
   position:absolute;
   top:50px;
   left:10px;
   width:365px;
   height: 200px;
}
#image:hover{
            cursor:pointer;
            -webkit-transform:scale(1.1); /*  크롬 */
            -moz-transform:scale(1.1); /* FireFox */
            -o-transform:scale(1.1); /* Opera */
            transform: scale(1.2, 1.2)
        }
</style>
<script type="text/javascript">
$(document).ready(function(){

    $(".filter-button").click(function(){
        var value = $(this).attr('data-filter');
        
        if(value == "all")
        {
            //$('.filter').removeClass('hidden');
            $('.filter').show('1000');
        }
        else
        {
//            $('.filter[filter-item="'+value+'"]').removeClass('hidden');
//            $(".filter").not('.filter[filter-item="'+value+'"]').addClass('hidden');
            $(".filter").not('.'+value).hide('3000');
            $('.filter').filter('.'+value).show('3000');
            
        }
    });

});
</script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
    <div class="container">
        <div class="row">

        <div align="center">
            <button class="btn btn-default filter-button active" data-filter="취미">테마별보기</button>
            <button class="btn btn-default filter-button" data-filter="취미">HDPE Pipes</button>
            <button class="btn btn-default filter-button" data-filter="sprinkle">Sprinkle Pipes</button>
            <button class="btn btn-default filter-button" data-filter="spray">Spray Nozzle</button>
            <button class="btn btn-default filter-button" data-filter="irrigation">Irrigation Pipes</button>
        </div>
        <br/>



            <div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter 취미" >
            <div id="image">
                <img src="http://fakeimg.pl/365x365/" class="img-responsive" style="width : 365px; height: 200px;" >
                <div class="text">
                   <center>
                   <h3>
                   어른도 가끔<br>
                   숨고싶을 때가 있다</h3>
                   </center>
                   </div>
                </div>
            </div>

            <div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter sprinkle">
                <img src="http://fakeimg.pl/365x365/" class="img-responsive" style="width : 365px; height: 200px;">
            </div>

            <div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter 취미">
                <img src="http://fakeimg.pl/365x365/" class="img-responsive" style="width : 365px; height: 200px;">
            </div>

            <div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter irrigation">
                <img src="http://fakeimg.pl/365x365/" class="img-responsive" style="width : 365px; height: 200px;">
            </div>

            <div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter spray">
                <img src="http://fakeimg.pl/365x365/" class="img-responsive" style="width : 365px; height: 200px;">
            </div>

            <div class="gallery_product col-lg-4 col-md-4 col-sm-4 col-xs-6 filter irrigation">
                <img src="http://fakeimg.pl/365x365/" class="img-responsive" style="width : 365px; height: 200px;">
            </div>
        </div>
    </div>
</section>





</body>
</html>
