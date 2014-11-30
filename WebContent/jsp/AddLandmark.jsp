<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="member.dto.LandmarkList" %>
<%@page import ="java.util.Vector"%>
<%@page import = "member.dto.LandmarkDao" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.ta.web.DBConnector" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" 
		src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD-EDvVM7eLhn0JWHezI7x2eGmAhre2BjE&sensor=FALSE">
</script>
<script type="text/javascript" src="../js/list.js"></script>
<script>

var map;
var geocoder;
var checkedMarker;
var nowLocation;

function initialize() {
	geocoder = new google.maps.Geocoder();
	var mapOptions = {
		center : new google.maps.LatLng(36.514465, 127.823751),
		zoom : 7,
		mapTypeId : google.maps.MapTypeId.ROADMAP,
		draggableCursor : 'default'
	};
	map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	map.set("disableDoubleClickZoom", true);
	google.maps.event.addListener(map, 'dblclick', function(event) {
		if(typeof checkedMarker !== 'undefined'){
			checkedMarker.setMap(null);
		}
		nowLocation = event.latLng;
		
		
		var realAddress = getRealAddress(nowLocation.lat(), nowLocation.lng(), function(address) {
			document.getElementsByName('address')[0].value = address;
			document.getElementsByName('lat')[0].value = nowLocation.lat();
			document.getElementsByName('lng')[0].value = nowLocation.lng();
			placeMarker(event.latLng, '0');
		}, function(result) {
			alert('failed to get address' + result);
		});
	});
}

function placeMarker(location, type) {
	var color;
	if(type === '3'){
		color = '|57D9FF|000000'
	} else {
		color = '|FE6256|000000';
	}
	
	checkedMarker = new google.maps.Marker({
		position : location,
		map : map,
		icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + color,
		title : 'Click for detail'
	});
	google.maps.event.addListener(checkedMarker, 'click', function() {
		document.getElementsByName('address')[0].value = '';
		document.getElementsByName('lat')[0].value = '';
		document.getElementsByName('lng')[0].value = '';
		checkedMarker.setMap(null);
	});
}

function getRealAddress(lat, lng, suceessCallback, failCallback) {
	var latlng = new google.maps.LatLng(lat, lng);
	var result;

	// get address from google web server asynchronously
	geocoder.geocode({
		latLng : latlng
	}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			if (results[0]) {
				suceessCallback(results[0].formatted_address);
			} else {
				suceessCallback('(' + lat + ',' + lng + ')');
			}
		} else {
			failCallback('(' + lat.toFixed(2) + ',' + lng.toFixed(2) + ')');
		}
	});
}

</script>

<link href="../css/list.css" rel="stylesheet">
<style type="text/css">
	.maincontainer{
		float : left;
		margin-right : 5%;
		 margin-bottom : 5%;
	}
	.input{
		float : left;
		margin : 0px;
	}
	.landmarkList{
		width : 45%;
		float : right;
	}
	.item{
		width : 100%;
		float : right;
	}
</style>

</head>
<body onload="initialize()">
	<jsp:include page="navbar.jsp" flush="false">
		<jsp:param name="param" value="navbar"/>
	</jsp:include>
	<br><br><br><br>
	
	<div class="container">
	
		<div id="map_canvas" class="maincontainer" style="width: 50%; height: 340px;"></div>
		
	   	<div id="products" class="landmarkList row list-group">  
	   	
     <%
     	LandmarkDao bdao = new LandmarkDao();
		Vector<LandmarkList> vector;
		vector = bdao.getAllLandmark();
		
		LandmarkList bean = new LandmarkList();

 		for(int i = 0 ; i < vector.size() ; i++){
  			
  			bean = vector.get(i);
  		
 				%>  
	        <div class="item  col-xs-4 col-lg-4 grid-group-item list-group-item">
	            <div class="thumbnail">
	                <div class="caption">
	                <img class="group list-group-image" width="20%" src="../image/map.JPG" alt="" />
	                	<br>
	                    <h3 class="group inner list-group-item-heading"><%=bean.getName() %></h3>
	                    <h5 class="text-right"><%=bean.getAddress() %></h4>                
	                </div>
	            </div>
	        </div>        
         <%} %>       
	    </div>  
	         
		<div class="input" style="width: 50%;">
		   	<form accept-charset="UTF-8" name = "form" action="/tripAlchemist/addLandmark" method ="post">
		   		<fieldset>
			   	  	<div class="form-group">
			   		    <input class="form-control" placeholder="명소 이름을 입력해주세요" name="placeName" type="text" autofocus required> 
			   		</div>
			   		<div class="form-group">
			   			<input class="form-control" placeholder="주소" readonly="readonly" name="address" type="text" required>
			   		</div>
			   		<div class="form-group">
			   			<input class="form-control" placeholder="위도" readonly="readonly" name="lat" type="text" required>
			   		</div>
			   		<div class="form-group">
			   			<input class="form-control" placeholder="경도" readonly="readonly" name="lng" type="text" required>
			   		</div>
			   		<button type = "submit" class="btn btn-lg btn-primary btn-block">등록</button>
				</fieldset>
		   	</form>
	   	</div>
	   	
	</div>
</body>
</html>