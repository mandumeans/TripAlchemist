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
		#map_canvas {display:inline-block;  }
		.leftContent {background: lightgray; height:540px; width: 500px; top:0px; display:inline-block; overflow: auto;}
		.placeListItem {}
	</style>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href ="../css/datepicker.css" rel="stylesheet">
	<script type="text/javascript" 
			src="http://maps.googleapis.com/maps/api/js?key=AIzaSyD-EDvVM7eLhn0JWHezI7x2eGmAhre2BjE&sensor=FALSE">
	</script>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type ="text/javascript" src ="../js/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
		var map;places
		var geocoder;
		var days = new Array();
		var places = new Array();
		var nowActiveTab;
		
		function placeInfo(day,lat,lng,address,name,type,marker){
			this.day = day;
			this.lat = lat;	//latitude
			this.lng = lng;	//longitude
			this.address = address;
			this.name = name;
			this.type = type;	//1.landmark 2.food 3.accomodation 4.shopping 5.entertaining 6.etc 
			this.marker = marker;
		}
		
		placeInfo.prototype.getInfo = function(){
			return this.lat + ', ' + this.lng;
		}
		
		function transportInfo(){
			var type = ''; //1.car 2.bus 3.train 4.taxi 5.walk 6.bicycle 7.
		}
		
		function initialize(){
			geocoder = new google.maps.Geocoder();
			var mapOptions = {
					center : new google.maps.LatLng(36.514465, 127.823751),
					zoom: 7,
					mapTypeId: google.maps.MapTypeId.ROADMAP
			};
			map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);	
			map.set("disableDoubleClickZoom", true);
			google.maps.event.addListener(map, 'dblclick',function(event){
				insertNewPlace(event.latLng);
			});
		}
		
		function insertNewPlace(location){
			//push place information to places array
			var lat = location.lat();
			var lng = location.lng();
			var realAddress = getRealAddress(lat, lng, function(result){
				if(result === null ||typeof result === 'undefined'){
				    $(nowActiveTab).append('<li class="list-group-item">(' + lat.toFixed(2) + ',' + lng.toFixed(2) + ')</li>');
				} else {
				    $(nowActiveTab).append('<li class="list-group-item">' + result + '</li>');
				}
				//push place information to array
				places.push(new placeInfo(nowActiveTab, location.lat(), location.lng(),result,'','',placeMarker(location)));
			}, function(result){
				alert('failed to get address' + result);
			});
		}

		function getRealAddress(lat, lng, suceessCallback, failCallback){
			var latlng = new google.maps.LatLng(lat, lng);
			var result;
			
			//get address from google web server asynchronously
			geocoder.geocode({latLng: latlng}, function(results, status){
				if(status == google.maps.GeocoderStatus.OK){
					if(results[0]){
						suceessCallback(results[0].formatted_address);	
					} else {
						suceessCallback('(' + lat + ',' + lng + ')');
					}
				} else {
					failCallback('(' + lat.toFixed(2) + ',' + lng.toFixed(2) + ')');
				}
			});
		}
		
		function placeMarker(location){
			var marker = new google.maps.Marker({
				position: location,
				map: map,
				icon: 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + (parseInt(places.length) + 1) + '|FE6256|000000',
				title: 'Click for detail'
			});
			google.maps.event.addListener(marker, 'click', function(){
				//deletePlace(marker)
			});
			return marker;
		}
		
		function deletePlace(marker){
			for(var i=0;i<places.length;i++){
				if(places[i].marker === marker){
					alert(places[i].lat + ',' + places[i].lng);
					places[i].marker.setMap(null);
					places.splice(i,1);
					refreshMarkerList();
				}
			}
		}
		
		function refreshMarkerList(){
			for(var i=0;i<places.length;i++){
				places[i].marker.setIcon('http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + (parseInt(i) + 1) + '|FE6256|000000');
			}
			$(nowActiveTab).empty();
			
			for(var i=0;i<places.length;i++){
			    $(nowActiveTab).append('<li class="list-group-item">' + places[i].address + '</li>');
			}
		}
		
		
		
	</script>
	<script type="text/javascript">
	$(document).ready(function () {
		var nowTemp = new Date();
		var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0); 
        var checkin = $('#start_date').datepicker({
        	onRender: function(date) {
        	return date.valueOf() < now.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function(ev) {
        	if (ev.date.valueOf() > checkout.date.valueOf()) {
            	var newDate = new Date(ev.date)
                newDate.setDate(newDate.getDate() + 1);
                checkout.setValue(newDate);
            }
            checkin.hide();
            $('#end_date')[0].focus();
       }).data('datepicker');
       var checkout = $('#end_date').datepicker({
       		onRender: function(date) {
            return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
            }
       }).on('changeDate', function(ev) {
       		checkout.hide();
       		var days = (checkout.date - checkin.date) / 86400000;
       		makeDaysTab(days);
       		$('#title').append('(' + days + '일)');
       }).data('datepicker');
    });
	
	function makeDaysTab(days){
		$('#myTab').empty();
		for(var i=1;i<=days;i++){
			if(i === 1){
				$('#myTab').append('<li class="active"><a href="#day' + i + '">' + i + '</a></li>');
				$('.tab-content').append('<div class="tab-pane active" id="day' + i + '"></div>');
			} else {
				$('#myTab').append('<li><a href="#day' + i + '">' + i + '</a></li>');
				$('.tab-content').append('<div class="tab-pane" id="day' + i + '"></div>');
			}
		}
		$('#myTab a').click(function (e) {
			e.preventDefault();
			$(this).tab('show');
			nowActiveTab = $(this).attr('href');
		});
		if(days > 0){
			nowActiveTab = '#day1';
		}
	}
	
</script>
	</head>
	<body onload="initialize()">    		
		<h2 id="title">여행을 시작할 날짜와 끝낼 날짜를 입력하세요.</h2>
    	<p><input type ="text" class = "form-control" data-date-format="yyyy-mm-dd" placeholder="시작 날짜"  id="start_date"></p>
    	<p><input type ="text" class = "form-control"data-date-format="yyyy-mm-dd" placeholder="마지막 날짜" id="end_date"></p>
		<div id="map_canvas" style="width: 940px; height: 540px;"></div>
		<div class="leftContent">
			<ul class="nav nav-tabs" id="myTab">
			</ul>
			<div class="tab-content">
			</div>
		</div>
	</body>
</html>