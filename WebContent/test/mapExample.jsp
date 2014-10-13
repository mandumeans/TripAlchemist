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
		var map;
		var geocoder;
		
		//날들을 저장함 (2차원배열)
		var days = new Array();
		var landmarks = new Array();
		
		//현재 선택된 탭과 그 날짜가 뭔지 저장하는 상태함수
		var nowActiveTab;
		var nowActiveIdx;
		
		//명소들을 저장하기위한 구조체
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
		
		//교통정보를 저장하기 위한 구조체
		function transportInfo(){
			var type = ''; //1.car 2.bus 3.train 4.taxi 5.walk 6.bicycle 7.
		}
		
		function initialize(){
			geocoder = new google.maps.Geocoder();
			var mapOptions = {
					center : new google.maps.LatLng(36.514465, 127.823751),
					zoom: 7,
					mapTypeId: google.maps.MapTypeId.ROADMAP,
				    draggableCursor: 'default'
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
			
			//구글 API로 부터 실제 주소를 받아온다.
			var realAddress = getRealAddress(lat, lng, 
			function(result){	
				//실제 주소 받아오는게 성공하면 현재 활성화된 탭에 리스트를 추가해줌
				if(result === null ||typeof result === 'undefined'){
				    $(nowActiveTab).append('<li class="list-group-item">(' + lat.toFixed(2) + ',' + lng.toFixed(2) + ')</li>');
				} else {
				    $(nowActiveTab).append('<li class="list-group-item">' + result + '</li>');
				}
				
				//days 2차원 배열에 현재 활성화된 날짜에 placeInfo구조체를 배열에 집어넣고 Marker도 찍는다.			
				days[nowActiveIdx].push(new placeInfo(nowActiveTab, location.lat(), location.lng(),result,'','',placeMarker(location)));
			}, 
			function(result){
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
				icon: 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + (parseInt(days[nowActiveIdx].length) + 1) + '|FE6256|000000',
				title: 'Click for detail'
			});
			google.maps.event.addListener(marker, 'click', function(){
				deletePlace(marker)
			});
			return marker;
		}
		
		function placeLandMarker(lat,lng,name){
			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(lat, lng),
				map: map,
			    animation: google.maps.Animation.DROP,
				icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
				title: name
			});	        
			
			var balloon = '<div class="placeBalloon">' + name + '</div>';

	        var infowindow = new google.maps.InfoWindow({
	        	content: balloon,
	        });

			infowindow.open(map,marker);
/* 			google.maps.event.addListener(marker, 'mouseover', function(){
				infowindow.open(map,marker);
			});

			google.maps.event.addListener(marker, 'mouseout', function(){
				infowindow.close(map,marker);
			}); */
			
			return marker;
		}
		
		function deletePlace(marker){
			for(var i=0;i<days[nowActiveIdx].length;i++){
				if(days[nowActiveIdx][i].marker === marker){
					days[nowActiveIdx][i].marker.setMap(null);
					days[nowActiveIdx].splice(i,1);
					refreshMarkerList();
				}
			}
		}
		
		function removeAllLandmarker(){
			for(var i=0;i<landmarks.length;i++){
				landmarks[i].marker.setMap(null);
			}
		}
		
		function refreshMarkerList(){
			
			for(var i=0;i<days.length;i++){
				for(var j=0;j<days[i].length;j++){
					days[i][j].marker.setMap(null);	
				}
			}
			
			for(var i=0;i<days[nowActiveIdx].length;i++){
				days[nowActiveIdx][i].marker.setMap(map);
				days[nowActiveIdx][i].marker.setIcon('http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + (parseInt(i) + 1) + '|FE6256|000000');
			}
			$(nowActiveTab).empty();
			
			for(var i=0;i<days[nowActiveIdx].length;i++){
			    $(nowActiveTab).append('<li class="list-group-item">' + days[nowActiveIdx][i].address + '</li>');
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
       		var totalDays = (checkout.date - checkin.date) / 86400000;
       		makeDaysTab(totalDays);
       		$('#title').append('(' + totalDays + '일)');
       }).data('datepicker');
       
       $('#btnLandmarkShow').click(function(){
    	  if($('#btnLandmarkShow').hasClass('active')){
    		  //랜드마크에 대한 마커 다 지우기
    		  removeAllLandmarker();
	      }
    	  else{
    		  $.ajax({
                  url: "/tripAlchemist/hello",
                  type: "POST",
                  //data: '{"VID" : "' + FindUrlVideoID(UrlInput) + '"}',
                  contentType: "application/json",
                  dataType: "JSON",
                  timeout: 10000,
                  success: function (result) {
                	  $.each(result, function(index){   
                		  landmarks.push(new placeInfo('', result[index].lat, result[index].lng,result[index].address,result[index].name,'1',placeLandMarker(result[index].lat, result[index].lng,result[index].name)));
                	  });
                  },
                  error: function (result) {  
            		  alert('failed to get landmarks');
                  }
              }); //ajax end
    	  }
       });
    });
	
	function makeDaysTab(totalDays){
		$('#myTab').empty();
		for(var i=1;i<=totalDays;i++){
			if(i === 1){
				$('#myTab').append('<li class="active"><a href="#day' + i + '" index="' + (parseInt(i) - 1) + '">' + i + '</a></li>');
				$('.tab-content').append('<div class="tab-pane active" id="day' + i + '"></div>');
			} else {
				$('#myTab').append('<li><a href="#day' + i + '" index="' + (parseInt(i) - 1) + '">' + i + '</a></li>');
				$('.tab-content').append('<div class="tab-pane" id="day' + i + '"></div>');
			}
			days[i-1] = new Array();
		}
		$('#myTab a').click(function (e) {
			e.preventDefault();
			//클릭된 탭이 보이도록하기
			$(this).tab('show');
			
			//현재 보는 탭을 저장
			nowActiveTab = $(this).attr('href');
			nowActiveIdx = $(this).attr('index');
			//맵에서 모든 마커를 지우고 해당 탭의 마커로 다시그리기
			refreshMarkerList();
			//현재 보고있는 맵의 위치를 해당 탭 포인트가 있는곳으로 이동 시킴
			if(days[nowActiveIdx].length>0){
				ChangeMapCenterZoom(days[nowActiveIdx]);
			}
		});
		if(totalDays > 0){
			nowActiveTab = '#day1';
			nowActiveIdx = '0';
		}
	}
	
	function ChangeMapCenterZoom(places){
		var Top = places[0].lat;
		var bottom = places[0].lat;
		var left = places[0].lng;
		var right = places[0].lng;
		//var newLat, newLng, LatVolume, LngVolume;
		
		for(var i=0;i<places.length;i++){
			if(places[i].lat > Top){
				top = places[i].lat;
			}
			if(places[i].lat < bottom){
				bottom = places[i].lat;
			}

			if(places[i].lng < left){
				left = places[i].lng;
			}
			if(places[i].lng > right){
				right = places[i].lng;
			}
		}
		
		//LatVolume = Math.abs(Top-bottom);
		//LngVolume = Math.abs(right-left);
		//if(LatVolume<100 && LngVolume<100){
			var bounds = new google.maps.LatLngBounds(
		             new google.maps.LatLng(Top, left),
		             new google.maps.LatLng(bottom, right));
		    map.fitBounds(bounds);
		//} else {
		//	map.setCenter(new google.maps.LatLng(places[0].lat, places[0].lng));
		//	map.setZoom(7);
		//}
	}
	
</script>
	</head>
	<body onload="initialize()">    		
		<h2 id="title">여행을 시작할 날짜와 끝낼 날짜를 입력하세요.</h2>
    	<p><input type ="text" class = "form-control" data-date-format="yyyy-mm-dd" placeholder="시작 날짜"  id="start_date"></p>
    	<p><input type ="text" class = "form-control"data-date-format="yyyy-mm-dd" placeholder="마지막 날짜" id="end_date"></p>
		<div id="map_canvas" style="width: 940px; height: 540px;">
		</div>
		<div class="onMap"><a id="btnLandmarkShow" class="btn btn-primary" data-toggle="button">Landmarks</a></div>
		<div class="leftContent">
			<ul class="nav nav-tabs" id="myTab">
			</ul>
			<div class="tab-content">
			</div>
		</div>
	</body>
</html>