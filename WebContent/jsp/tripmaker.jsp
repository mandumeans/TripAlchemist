<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		html { height : 100% }
		body { height : 100%; margin: 0; padding: 0 }
		#map_canvas {display:inline-block;}
		.leftContent {background: lightgray; height:540px; width: 500px; top:0px; display:inline-block; overflow: auto;}
		.placeListItem {}
		.onMap{position:absolute;left:840px;top:200px;}
		.placeBalloon{width:80px;height:20px}
		#btnHotelRecommand{position:absolute;top:40px;right:0.5px;}
	</style>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href ="../css/datepicker.css" rel="stylesheet">
	<script type="text/javascript" 
			src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD-EDvVM7eLhn0JWHezI7x2eGmAhre2BjE&sensor=FALSE">
	</script>
	<link href ="../css/index.css" rel ="stylesheet">
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type ="text/javascript" src ="../js/bootstrap-datepicker.js"></script>
	<script type ="text/javascript" src ="../js/tripmaker.js"></script>
	</head>
	<body onload="initialize()">  
		<jsp:include page="navbar.jsp" flush="false">
	        <jsp:param name="param" value="top"/>
		</jsp:include>	  		
		<h2 id="title">여행을 시작할 날짜와 끝낼 날짜를 입력하세요.</h2>
    	<p><input type ="text" class = "form-control" data-date-format="yyyy-mm-dd" placeholder="시작 날짜"  id="start_date"></p>
    	<p><input type ="text" class = "form-control"data-date-format="yyyy-mm-dd" placeholder="마지막 날짜" id="end_date"></p>
		<div id="map_canvas" style="width: 940px; height: 540px;">
		</div>
		<div class="onMap">
			<a id="btnLandmarkShow" class="btn btn-primary" data-toggle="button">Landmarks</a></br></br>
			<a id="btnHotelRecommand" class="btn btn-primary">Recommand</br>Hotel</a>
		</div>
		<div class="leftContent">
			<ul class="nav nav-tabs" id="myTab">
			</ul>
			<div class="tab-content">
			</div>
		</div>
		<div class="modal fade" id="hotelRecomPopup">
			<div class="modal-dialog">
		    	<div class="modal-content">
		        	<div class="modal-header">
		          		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		          		<h4 class="modal-title">호텔 선택 </h4>
		        	</div>      
	        		<div class="modal-body">        
						<ul class="nav nav-tabs" id="recomHotelList">
						</ul>
					</div>
		      	</div>
		    </div>
		</div>
	</body>
</html>