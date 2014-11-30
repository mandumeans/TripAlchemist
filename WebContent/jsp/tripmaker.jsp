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
		.leftContent {background: lightgray; width: 39%; height:540px;  top:0px; margin-left:0.5%; display:inline-block; overflow: auto;}
		.placeListItem {}
		.onMap{position:absolute;left:51.6%;top:130px;float:right; vertical-align:center;}
		#btnLandmarkShow{margin-left:10px; margin-bottom:15px;}
		.placeBalloon{width:80px;height:20px}
		.tripMakerBody {margin-left:10%;
						margin-right:10%;
						border:1px solid black;
						padding:20px;}
		.maincontainer{
						-webkit-border-radius: 10px;
						-moz-border-radius: 10px;
						border-radius: 10px;
		}
		.btnComplete{
			margin-left:10%;
			margin-right:10%;
			width : 140px;
			height : 51px;
			margin-top : 25px;
			float: right;
			display: block;
		}
		.desc{
			margin-left:10%;
			width:20%;
			float: left;
			display: block;
			padding-top:30px;
		}
	</style>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" 
			src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD-EDvVM7eLhn0JWHezI7x2eGmAhre2BjE&sensor=FALSE">
	</script>
	<link href ="../css/index.css" rel ="stylesheet">
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type ="text/javascript" src ="../js/tripmaker.js"></script>
	</head>
	<body onload="initialize()">
		<jsp:include page="navbar.jsp" flush="false">
			<jsp:param name="param" value="top" />
		</jsp:include>
		<h2 id="title">나만의 일정을 만들어 보자!</h2>
		<div class="tripMakerBody maincontainer">
			<div id="map_canvas" class="maincontainer" style="width: 60%; height: 540px;"></div>
			<div class="onMap">
				<a id="btnLandmarkShow" class="btn btn-primary" data-toggle="button">Landmarks</a></br>
				<a id="btnHotelRecommand" class="btn btn-primary">Recommand</br>Hotel
				</a>
			</div>
			<div class="leftContent maincontainer">
				<ul class="nav nav-tabs" id="myTab">
				</ul>
				<div class="tab-content"></div>
			</div>
		</div>
		<div class="jumbotron desc" style="display:none;">
		Author <h3><span id="writer"></span></h3></br>
		Start date <h3><span id="sDate"></span></h3></br>
		End date <h3><span id="eDate"></span></h3></br>
		Total days <h3><span id="tdays"></span></h3>
		</div>
		<a id="btnComplete" class="btnComplete btn btn-primary"><h4>Complete!!</h4></a>
		<div class="modal fade" id="hotelRecomPopup">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">호텔 선택</h4>
					</div>
					<div class="modal-body">
						<ul class="nav nav-tabs" id="recomHotelList">
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal" id="loadingAnimation">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body">
						<center>
							<img src='../image/ajax_loader.gif'/>
						</center>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal" id="tripAddition">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">여기가 어디죠?</h4>
					</div>
					<div class="modal-body">
						여행지 포인트 명 : 
                    	<input type ="text" id="tripName" name="title" class = "form-control" placeholder="예 : 빅 벤, 버킹엄, 경복궁 등등..">
                    	</br>
						여행지 구분 : 
						 <select id="category" disabled="disabled" class="form-control">
						 	<option value="0">선택해 주세요.</option>
						 	<option value="1">관광지</option>
						 	<option value="2">음식</option>
						 	<option value="3">숙박 업소</option>
						 	<option value="4">쇼핑</option>
						 	<option value="5">오락</option>
						 	<option value="6">기타</option>
						 </select>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>