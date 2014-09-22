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
		#map_canvas { height : 30%; width : 30%  }
	</style>
	<script type="text/javascript" 
			src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD-EDvVM7eLhn0JWHezI7x2eGmAhre2BjE&sensor=FALSE">
	</script>
	<script type="text/javascript">
		var map;
		var places = new Array();
		
		function placeInfo(lat,lng,address,name,type){
			this.lat = lat;	//latitude
			this.lng = lng;	//longitude
			this.address = address;
			this.name = name;
			this.type = type;	//1.landmark 2.food 3.accomodation 4.shopping 5.entertaining 6.etc 
		}
		
		placeInfo.prototype.getInfo = function(){
			return this.lat + ', ' + this.lng;
		}
		
		function transportInfo(){
			var type = ''; //1.car 2.bus 3.train 4.taxi 5.walk 6.bicycle 7.
		}
		
		function initialize(){
			var mapOptions = {
					center : new google.maps.LatLng(36.514465, 127.823751),
					zoom: 7,
					mapTypeId: google.maps.MapTypeId.ROADMAP
			};
			map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);	
			
			google.maps.event.addListener(map, 'click',function(event){
				insertNewPlace(event.latLng);
				placeMarker(event.latLng);
			});
		}
		
		function placeMarker(location){
			var marker = new google.maps.Marker({
				position: location,
				map: map,
				title: 'Click for detail'
			});
			google.maps.event.addListener(marker, 'click', function(){
				map.setZoom(7);
				map.setCenter(marker.getPosition());
			});
		}
		
		function insertNewPlace(location){
			//push place information to places array
			places.push(new placeInfo(location.lat(), location.lng(),'','',''));
		}
	</script>
	</head>
	<body onload="initialize()">
		<div id="map_canvas" style="width:940px;height:540px"></div>
	</body>
</html>