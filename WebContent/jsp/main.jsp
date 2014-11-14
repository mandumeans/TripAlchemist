<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.ta.web.DBConnector" %>
<%@page import ="member.dto.MemberDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<link href ="../css/test.css" rel ="stylesheet">
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type ="text/javascript" src ="../js/test.js"></script>

<link href='http://fonts.googleapis.com/css?family=Buenard:700' rel='stylesheet' type='text/css'>
<script src="http://pupunzi.com/mb.components/mb.YTPlayer/demo/inc/jquery.mb.YTPlayer.js"></script>

<link href ="../css/datepicker.css" rel ="stylesheet">
 <script type ="text/javascript" src ="../js/bootstrap-datepicker.js"></script> 

<script type ="text/javascript">
	$(document).ready(function(){
		$('#example1').datepicker({
			format:"yyyy-mm-dd"
		});
	});
</script>
<%MemberDTO memberDTO =(MemberDTO)session.getAttribute("member_info"); %>
</head>

<body>   
<jsp:include page="navbar.jsp" flush="false">
        <jsp:param name="param" value="navbar"/>
</jsp:include>	  
<section class="content-section video-section">
  <div class="pattern-overlay">
  <a id="bgndVideo" class="player" data-property="{videoURL:'https://www.youtube.com/watch?v=fdJc1_IBKJA',containment:'.video-section', quality:'large', autoPlay:true, mute:true, opacity:1}">bg</a> 
    <div class="container">
    <%if(memberDTO ==null){ %>  
     <h3>TripAlchemist에 오신 것을 환영합니다.</h3><br>
      <div class="row vertical-offset-100">     
    	<div class="col-md-4 col-md-offset-4">
    		<form accept-charset="UTF-8" name = "form2"  method ="post">
                 <fieldset>
			    	<div class="form-group">
			    		    <input class="form-control" placeholder="도시 및 지역을 입력하세요" name="text" type="text" > 
			    	</div>
			    	
			   	</fieldset>
			</form>
			
			<h3>회원 가입을 해주세요.</h3>
    		<div class="panel panel-default">	
			    	<div class="panel-body">
			    	
			    	<form accept-charset="UTF-8" name = "form" action="/tripAlchemist/register" method ="post">
                    <fieldset>
			    	  	<div class="form-group">
			    		    <input class="form-control" placeholder="이메일을 입력하세요" name="email" type="email" autofocus required> 
			    		</div>
			    		<div class="form-group">
			    			<input class="form-control" placeholder="이름을 입력하세요" name="name" type="text" required>
			    		</div>
			    		<div class="form-group">
			    			<input class="form-control" placeholder="패스워드를 입력하세요" name="password" type="password" required>
			    		</div>
			    		<div class="form-group">			    			
			    			<select class ="form-control" name ="gender" required>
        						<option>M</option>
        						<option>F</option>
        					</select>
			    		</div>			    		
			    		<div class="form-group">
			    			<input class="form-control" placeholder="생년월일을  선택하세요." name="DOB" id ="example1" type="text" required>
			    		</div>
			    		<button type = "submit" class="btn btn-lg btn-primary btn-block">가입</button>
			    	</fieldset>
			      	</form>
			    </div>
			</div>
		</div>
	</div>
	 <%}else{ %>
	 	<br><p></p>
	  	<h3><%=memberDTO.getName()%>님 TripAlchemist에 오신 것을 환영합니다.</h3><br>
	  	<br><p></p>
	  	<h3>국가 또는 도시를 검색해주세요.</h3>
	  	<br><p></p>
		<div class="col-md-4 col-md-offset-4">           
    		<form accept-charset="UTF-8" name = "form2"  method ="post">
                 <fieldset>
			    	<div class="form-group">
			    		    <input class="form-control" placeholder="도시 및 지역을 입력하세요" name="text" type="text" > 
			    	</div>
			    	
			   	</fieldset>
			</form>        
        </div>
	 <%} %>
    </div>
   
  </div>
</section>

<div class="container" style="margin-top:30px;">	
	<h1 class="text-center">인기있는 여행일정 <br> <small>여행 일정을 공유하고, 내 여행일정을 만들어보세요.</small></h1><br><br>
	
	<div class="row form-group">	
        <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
                <div class="panel-image">
                    <img src="http://666a658c624a3c03a6b2-25cda059d975d2f318c03e90bcf17c40.r92.cf1.rackcdn.com/unsplash_52d09387ae003_1.JPG" class="panel-image-preview" />
                    <label for="toggle-1"></label>
                </div>
                <input type="checkbox" id="toggle-1" class="panel-image-toggle">
                <div class="panel-body">
                    <h4>Title of Image</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in lobortis nisl, vitae iaculis sapien. Phasellus ultrices gravida massa luctus ornare. Suspendisse blandit quam elit, eu imperdiet neque semper et.</p>
                </div>
                <div class="panel-footer text-center">
                    <a href="#download"><span class="glyphicon glyphicon-download"></span></a> 
                    <a href="#facebook"><span class="fa fa-facebook"></span></a>
                    <a href="#twitter"><span class="fa fa-twitter"></span></a>                                   
                    <a href="#share"><span class="glyphicon glyphicon-share-alt"></span></a>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">You can even have a Panel Title</h3>
                </div>
                <div class="panel-image hide-panel-body">
                    <img src="http://666a658c624a3c03a6b2-25cda059d975d2f318c03e90bcf17c40.r92.cf1.rackcdn.com/unsplash_52c470899a2e1_1.JPG" class="panel-image-preview" />
                    <label for="toggle-3"></label>
                </div>
                <input type="checkbox" id="toggle-3" class="panel-image-toggle">
                <div class="panel-body">
                    <h4>Title of Image</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in lobortis nisl, vitae iaculis sapien. Phasellus ultrices gravida massa luctus ornare. Suspendisse blandit quam elit, eu imperdiet neque semper et.</p>
                </div>
                <div class="panel-footer text-center">
                    <a href="#download"><span class="glyphicon glyphicon-download"></span></a>
                    <a href="#facebook"><span class="fa fa-facebook"></span></a>
                    <a href="#twitter"><span class="fa fa-twitter"></span></a>
                    <a href="#share"><span class="glyphicon glyphicon-share-alt"></span></a>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
                <div class="panel-image hide-panel-body">
                    <img src="http://666a658c624a3c03a6b2-25cda059d975d2f318c03e90bcf17c40.r92.cf1.rackcdn.com/unsplash_52cf9489095e8_1.JPG" class="panel-image-preview" />
                    <label for="toggle-2"></label>
                </div>
                <input type="checkbox" id="toggle-2" class="panel-image-toggle">
                <div class="panel-body">
                    <h4>Title of Image</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in lobortis nisl, vitae iaculis sapien. Phasellus ultrices gravida massa luctus ornare. Suspendisse blandit quam elit, eu imperdiet neque semper et.</p>
                </div>
                <div class="panel-footer text-center">
                    <a href="#download"><span class="glyphicon glyphicon-download"></span></a>
                    <a href="#facebook"><span class="fa fa-facebook"></span></a>
                    <a href="#twitter"><span class="fa fa-twitter"></span></a>
                    <a href="#share"><span class="glyphicon glyphicon-share-alt"></span></a>
                </div>
            </div>
        </div>
	</div>
    
    <div class="row form-group">
        <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">You can even have a Panel Title</h3>
                </div>
                <div class="panel-image hide-panel-body">
                    <img src="http://666a658c624a3c03a6b2-25cda059d975d2f318c03e90bcf17c40.r92.cf1.rackcdn.com/unsplash_52c470899a2e1_1.JPG" class="panel-image-preview" />
                    <label for="toggle-3"></label>
                </div>
                <input type="checkbox" id="toggle-3" class="panel-image-toggle">
                <div class="panel-body">
                    <h4>Title of Image</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in lobortis nisl, vitae iaculis sapien. Phasellus ultrices gravida massa luctus ornare. Suspendisse blandit quam elit, eu imperdiet neque semper et.</p>
                </div>
                <div class="panel-footer text-center">
                    <a href="#download"><span class="glyphicon glyphicon-download"></span></a>
                    <a href="#facebook"><span class="fa fa-facebook"></span></a>
                    <a href="#twitter"><span class="fa fa-twitter"></span></a>
                    <a href="#share"><span class="glyphicon glyphicon-share-alt"></span></a>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
                <div class="panel-image">
                    <a href ="main.jsp"><img src="http://666a658c624a3c03a6b2-25cda059d975d2f318c03e90bcf17c40.r92.cf1.rackcdn.com/unsplash_52cd36aac6bed_1.JPG" class="panel-image-preview" /></a>
                    <label for="toggle-4"></label>
                </div>
                <input type="checkbox" id="toggle-4" checked class="panel-image-toggle">
                <div class="panel-body">
                    <h4>Show the Description by default!</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in lobortis nisl, vitae iaculis sapien. Phasellus ultrices gravida massa luctus ornare. Suspendisse blandit quam elit, eu imperdiet neque semper et.</p>
                </div>
                <div class="panel-footer text-center">
                    <a href="#download"><span class="glyphicon glyphicon-download"></span></a>
                    <a href="#facebook"><span class="fa fa-facebook"></span></a>
                    <a href="#twitter"><span class="fa fa-twitter"></span></a>
                    <a href="#share"><span class="glyphicon glyphicon-share-alt"></span></a>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-4">
            <div class="panel panel-default">
                <div class="panel-image">
                    <img src="http://666a658c624a3c03a6b2-25cda059d975d2f318c03e90bcf17c40.r92.cf1.rackcdn.com/unsplash_52d09387ae003_1.JPG" class="panel-image-preview" />
                    <label for="toggle-1"></label>
                </div>
                <input type="checkbox" id="toggle-1" class="panel-image-toggle">
                <div class="panel-body">
                    <h4>Title of Image</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in lobortis nisl, vitae iaculis sapien. Phasellus ultrices gravida massa luctus ornare. Suspendisse blandit quam elit, eu imperdiet neque semper et.</p>
                </div>
                <div class="panel-footer text-center">
                    <a href="#download"><span class="glyphicon glyphicon-download"></span></a>  
                    <a href="#facebook"><span class="fa fa-facebook"></span></a>
                    <a href="#twitter"><span class="fa fa-twitter"></span></a>
                                  
                    <a href="#share"><span class="glyphicon glyphicon-share-alt"></span></a>
                </div>
            </div>
        </div>
	</div>
</div>
<div>
	
</div>
</body>
</html>