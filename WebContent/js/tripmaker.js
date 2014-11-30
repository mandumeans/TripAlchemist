var map;
var geocoder;

// 날들을 저장함 (2차원배열)
var days = new Array();
var landmarks = new Array();

// 현재 선택된 탭과 그 날짜가 뭔지 저장하는 상태함수
var nowActiveTab;
var nowActiveIdx;

// 명소들을 저장하기위한 구조체
function placeInfo(day, lat, lng, address, name, type, hotelInfo, marker) {
	this.day = day;
	this.lat = lat; // latitude
	this.lng = lng; // longitude
	this.address = address;
	this.name = name;
	this.type = type; // 1.landmark 2.food 3.accommodation 4.shopping
						// 5.entertaining 6.etc
	this.hotelInfo = hotelInfo; //only for type 3(accommodation)
	this.marker = marker;
}

//예약할 호텔 방의 정보를 저장하기 위한 구조체
function hotelInfo(hotelNum, hotelRoomNum, hotelName, hotelRoomName, price) {
	this.hotelNum = hotelNum;
	this.hotelRoomNum = hotelRoomNum; 
	this.hotelName = hotelName;
	this.hotelRoomName = hotelRoomName; 
	this.price = price;
}


//예약할 호텔 방의 정보를 저장하기 위한 구조체
function SaveInfo(day, order, lat, lng, address, name, type, hotelNum, hotelRoomNum) {
	this.day = day;						// day 0,1,2,3,4...
	this.order = order;						// number 0,1,2,3,4...
	this.lat = lat; 					// latitude
	this.lng = lng; 					// longitude
	this.address = address;
	this.name = name;	
	this.type = type; 					// 1.landmark 2.food 3.accommodation 4.shopping 5.entertaining 6.etc
	this.hotelNum = hotelNum; 
	this.hotelRoomNum = hotelRoomNum; 
}

// 교통정보를 저장하기 위한 구조체
function transportInfo() {
	var type = ''; // 1.car 2.bus 3.train 4.taxi 5.walk 6.bicycle 7.
}
///////////////MAP CONTROL//////////////////////////////
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
		//모달팝업 띄우기
		$('#tripAddition').modal();
		$('#tripAddition').on('shown.bs.modal', function () {
		    $('#tripName').focus();
		});
		
		//뭐든 이름을 넣어야함
		$('#tripName').keyup( function(e) {
			if($("#tripName").val() !== ''){
				$('#category').prop( "disabled", false );
			} else {
				$('#category').prop( "disabled", true );
			}
	    });
		
		//카테고리를 뭐든 선택하면 바로 저장됨
		$('#category').change(function(){
			if($("#category option:selected").val() !== '0'){
				$('#tripAddition').modal('hide');
			}
		});
		
		//팝업창이 닫히면 정보 저장함
		$('#tripAddition').on('hide.bs.modal', function (e) {
			//console.log( $("#category option:selected").val() );
			//console.log( $("#tripName").val() );
			if($("#category option:selected").val() === '0' || $("#tripName").val() === '') {
				insertNewPlace(event.latLng,'','');
			} else {
				insertNewPlace(event.latLng, $("#tripName").val(), $("#category option:selected").val());
			}
			//modal reset
			$("#tripName").val('');
			$("#category").val('0').attr("selected", "selected");
			$('#category').prop( "disabled", true );
			
			$(this).off('hide.bs.modal');			//이벤트 중복 발생 방지
		});
	});
}

function insertNewPlace(location, title, category) {
	// push place information to places array
	var lat = location.lat();
	var lng = location.lng();

	var color;
	if(category === '3'){
		color = '|57D9FF|000000';
	} else {
		color = '|FE6256|000000';
	}
	var iconURL = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + (parseInt(days[nowActiveIdx].length) + 1) + color;
	
	// 구글 API로 부터 실제 주소를 받아온다.
	var realAddress = getRealAddress(lat, lng, function(address) {
		// 실제 주소 받아오는게 성공하면 현재 활성화된 탭에 리스트를 추가해줌
		if (address === null || typeof address === 'undefined') {
			$(nowActiveTab).append(
					'<li class="list-group-item">(' + lat.toFixed(2) + ','	+ lng.toFixed(2) + ')</li>');
		} else {
			if(title === ''){
				$(nowActiveTab).append('<li class="list-group-item"><img src="' + iconURL + '">&nbsp&nbsp' + address + '</li>');
			} else {
				$(nowActiveTab).append('<li class="list-group-item"><img src="' + iconURL + '">&nbsp&nbsp' + title + '</li>');
			}
		}

		// days 2차원 배열에 현재 활성화된 날짜에 placeInfo구조체를 배열에 집어넣고 Marker도 찍는다.
		days[nowActiveIdx].push(new placeInfo(nowActiveTab, parseFloat(location.lat()),
				parseFloat(location.lng()), address, title, category, '', placeMarker(location, category)));
	}, function(result) {
		alert('failed to get address' + result);
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


function placeMarker(location, type) {
	var color;
	if(type === '3'){
		color = '|57D9FF|000000'
	} else {
		color = '|FE6256|000000';
	}
	
	var marker = new google.maps.Marker({
		position : location,
		map : map,
		icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld='
				+ (parseInt(days[nowActiveIdx].length) + 1) + color,
		title : 'Click for detail'
	});
	google.maps.event.addListener(marker, 'click', function() {
		deletePlace(marker)
	});
	return marker;
}


function placeLandMarker(lat, lng, name) {
	var marker = new google.maps.Marker({
		position : new google.maps.LatLng(lat, lng),
		map : map,
		animation : google.maps.Animation.DROP,
		icon : 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
		title : name
	});

	var balloon = '<div class="placeBalloon">' + name + '</div>';

	var infowindow = new google.maps.InfoWindow({
		content : balloon,
	});

	infowindow.open(map, marker);

	return marker;
}


function deletePlace(marker) {
	for (var i = 0; i < days[nowActiveIdx].length; i++) {
		if (days[nowActiveIdx][i].marker === marker) {
			days[nowActiveIdx][i].marker.setMap(null);
			days[nowActiveIdx].splice(i, 1);
			refreshMarkerList();
		}
	}
}


function removeAllLandmarker() {
	for (var i = 0; i < landmarks.length; i++) {
		landmarks[i].marker.setMap(null);
	}
}


function refreshMarkerList() {
	var color;
	
	for (var i = 0; i < days.length; i++) {
		for (var j = 0; j < days[i].length; j++) {
			days[i][j].marker.setMap(null);
		}
	}

	for (var i = 0; i < days[nowActiveIdx].length; i++) {
		if(days[nowActiveIdx][i].type === '3'){
			color = '|57D9FF|000000';
		} else {
			color = '|FE6256|000000';
		}
		days[nowActiveIdx][i].marker.setMap(map);
		days[nowActiveIdx][i].marker
				.setIcon('http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld='
						+ (parseInt(i) + 1) + color);
	}
	$(nowActiveTab).empty();

	for (var i = 0; i < days[nowActiveIdx].length; i++) {
		var listItemLabel = days[nowActiveIdx][i].name;
		if(listItemLabel === ''){
			listItemLabel = days[nowActiveIdx][i].address;			
		}
		$(nowActiveTab).append(
				'<li class="list-group-item"><img src="' + days[nowActiveIdx][i].marker.getIcon() + '">&nbsp&nbsp' + listItemLabel
						+ '</li>');
	}
}
///////////////MAP CONTROL END//////////////////////////////

$(document).ready(function() {
	var getParameter = function (param) {
	    var returnValue;
	    var url = location.href;
	    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
	    for (var i = 0; i < parameters.length; i++) {
	        var varName = parameters[i].split('=')[0];
	        if (varName.toUpperCase() == param.toUpperCase()) {
	            returnValue = parameters[i].split('=')[1];
	            
	            return decodeURIComponent(returnValue);
	            //return decodeURIComponent((new RegExp('[?|&]' + returnValue + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
	        }
	        
	    }
	};
	
	var getURLParameter = function (name) {
	    return decodeURIComponent(
	        (location.search.match(RegExp("[?|&]"+name+'=(.+?)(&|$)'))||[,null])[1]
	    ).replace(/\+/gi," ");  
	}
	
	var parseDate = function (str){
		var mdy = str.split('-');
	    return new Date(mdy[0], mdy[1], mdy[2]);
	}
	
	var trip_id = getURLParameter('tripId');
	var title = getURLParameter('title');
	var startDate = getURLParameter('startDate');
	var endDate = getURLParameter('endDate');
	
	if((title === 'null' && startDate === 'null' && endDate === 'null') && trip_id !== 'null' ){
		//trip_id로 들어옴
		$.ajax({
			url : "/tripAlchemist/loadtrip",
			type : "GET",
			data : {tripId : trip_id},
			dataType : "json",
			contentType : "application/json",
			timeout : 10000,
			success : function(result) {
				var endDat;
				var startDat;
				var createby;
				var totalDays;
				var cnt = 0;
				$.each(result,function(index) {
					var title = result[index].title;
					if(cnt == 0){
						startDat = result[index].startDat;
						endDat = result[index].endDat;
						totalDays = (((new Date(endDat)) - (new Date(startDat))) / 86400000) + 1;
						makeDaysTab(totalDays);
					}
					createby = result[index].createby;
					var placeLng = result[index].placeLng;
					var placeLat = result[index].placeLat;
					var placeAddress = result[index].placeAddress;
					var seqOrder = result[index].seqOrder;
					var seqDay = result[index].seqDay;
					var placeNum = result[index].placeNum;
					var placeName = result[index].placeName;
					
					// click event시
					days[seqDay].push(
							new placeInfo('#day' + parseInt(seqDay) , parseFloat(placeLat), parseFloat(placeLng), placeAddress, placeName, placeNum, '', 
									placeMarker(new google.maps.LatLng(placeLat, placeLng), placeNum)
							)
					);
					cnt++;
				});
				refreshMarkerList();
				$('#btnComplete').attr("disabled", "disabled");
				$('#writer').append(createby);
				$('#sDate').append(startDat);
				$('#eDate').append(endDat);
				$('#tdays').append(totalDays);
				$('.desc').show();
			},
			error : function(result) {
				alert('failed to get trip information');
				location.href = 'main.jsp';
			}
		});
	} else if((title !== 'null' && startDate !== 'null' & endDate !== 'null') && trip_id === 'null' ){
		
		var checkin = parseDate(startDate);
		var checkout = parseDate(endDate);

		
		var totalDays = ((checkout - checkin) / 86400000) + 1;
		makeDaysTab(totalDays);
		
	} else {
		alert('Sorry. wrong access');
		location.href = 'main.jsp';
	}
	

	// Show Landmark button event
	$('#btnLandmarkShow').click(function() {
		if ($('#btnLandmarkShow').hasClass('active')) {
			// 랜드마크에 대한 마커 다 지우기
			removeAllLandmarker();
		} else {
			$.ajax({
				url : "/tripAlchemist/hello",
				type : "POST",
				// data: '{"VID" : "' +
				// FindUrlVideoID(UrlInput)
				// + '"}',
				contentType : "application/json",
				dataType : "JSON",
				timeout : 10000,
				beforeSend: function() {
					$('#loadingAnimation').modal();
				},
				success : function(result) {
					$.each(result,function(index) {
						landmarks.push(new placeInfo('',result[index].lat,result[index].lng,result[index].address,result[index].name,'1','',
								placeLandMarker(result[index].lat,result[index].lng,result[index].name)));
					});
				},
				error : function(result) {
					alert('failed to get landmarks');
				}
			}).done(function( data ) {
				$('#loadingAnimation').modal('hide');
			});; // ajax end
		}
	});

	// hotel Recommend button event
	$('#btnHotelRecommand').click(function() {
		// 탭이 존재 하는지 확인
		if ($('#myTab').find('li').length <= 0) {
			alert('Please choose places to go first');
			return;
		}
		// 액티브된 탭에 일정이 한개 이상 존재하는 지 확인
		if ($('div.tab-pane.active').find('li').length <= 0) {
			alert('Please choose places to go first!');
			return;
		}
		var lat = days[nowActiveIdx][days[nowActiveIdx].length - 1].lat;
		var lng = days[nowActiveIdx][days[nowActiveIdx].length - 1].lng;

		var startDate = checkin;
		var DateToGo = new Date();
		DateToGo.setDate(startDate.getDate() + Number(nowActiveIdx));
		var location = {
			"lat" : lat,
			"lng" : lng,
			'theDay' : yyyymmdd(DateToGo)
		};

		// ajax로 추천된 데이터들 콜백함수를 통해 뿌려줌
		$.ajax({
			url : "/tripAlchemist/recommand",
			type : "GET",
			data : location,
			dataType : "json",
			contentType : "application/json",
			timeout : 10000,
			beforeSend: function() {
				$('#loadingAnimation').modal();
			},
			success : function(result) {
				$('#recomHotelList').empty();
				$.each(result,function(index) {
					var hotelNum = result[index].hotelNum;
					var hotelRoomNum = result[index].hotelRoomNum;
					var rank = result[index].rank;
					var name = result[index].name;
					var roomName = result[index].roomName;
					var price = result[index].price;
					var rate = result[index].rate;
					var address = result[index].address;
					var hotelLat = result[index].lat;
					var hotelLng = result[index].lng;
					var listKey = 'hn' + hotelNum + 'hrn' + hotelRoomNum;

					$('#recomHotelList').append('<li><a id="' + listKey + '"> 호텔 : ' + name  + ' / 방 이름 : ' + roomName + ' / 가격 : ' + price + ' / 평점 : ' + rate + '  </a></li>');
					

					// click event시
					//days[nowActiveIdx].push(new placeInfo(nowActiveTab, lat, lng, address, name, '3', new hotelInfo(hotelNum, hotelRoomNum, name, roomName, price), placeMarker(location)));
					$('#' + listKey).click(function(e) {
						days[nowActiveIdx].push(
								new placeInfo(nowActiveTab, parseFloat(hotelLat), parseFloat(hotelLng), address, name, '3', 
										new hotelInfo(hotelNum, hotelRoomNum, name, roomName, price), 
										placeMarker(new google.maps.LatLng(hotelLat, hotelLng), '3')
								)
						);
						$('#hotelRecomPopup').modal('hide');
						refreshMarkerList();
					});
				});
				$('#hotelRecomPopup').modal();
			},
			error : function(result) {
				alert('failed to get hotel information');
			}
		}).done(function( data ) {
			$('#loadingAnimation').modal('hide');
		}); // ajax end
	}); // btnhotelRecommend event

	// hotel Recommend button event
	$('#btnComplete').click(function() {
		var sum = 0;
		var ArrayToSend = new Array();
		
		for (var i = 0; i < days.length; i++) {
			for (var j = 0; j < days[i].length; j++) {
				sum = sum + 1;
				if(days[i][j].hotelInfo === ''){
					ArrayToSend.push(new SaveInfo(i, j, days[i][j].lat, days[i][j].lng, encodeURIComponent(days[i][j].address), encodeURIComponent(days[i][j].name), days[i][j].type, '', ''));
				} else {
					ArrayToSend.push(new SaveInfo(i, j, days[i][j].lat, days[i][j].lng, encodeURIComponent(days[i][j].address), encodeURIComponent(days[i][j].name), days[i][j].type, days[i][j].hotelInfo.hotelNum, days[i][j].hotelInfo.hotelRoomNum));
				}
			}
		}

		if(sum === 0){
			alert('만들어진 일정이 한 개도 없네요 적어도 한개는 넣어주세요');
			return;
		}

		// ajax로 추천된 데이터들 콜백함수를 통해 뿌려줌
		$.ajax({
			url : "/tripAlchemist/savetrip",
			type : "GET",
			data : {title : encodeURIComponent(title), sDate : yyyymmdd(checkin), eDate : yyyymmdd(checkout), myData : JSON.stringify(ArrayToSend)},
			dataType : "json",
			contentType : "application/json",
			timeout : 10000,
			beforeSend: function() {
				$('#loadingAnimation').modal();
			},
			success : function(result) {
				if(result){
					alert('success');
					location.href = 'main.jsp';
				} else {
					alert('failed to save');
				}
				
			},
			error : function(result) {
				console.log('error : ' + result);
				alert('failed to save');
			}
		}).done(function( data ) {
			$('#loadingAnimation').modal('hide');
		}); // ajax end
		
	});
	
}); // document.ready end

function yyyymmdd(dateIn) {
	var yyyy = dateIn.getFullYear();
	var mm = dateIn.getMonth(); // getMonth() is zero-based
	var dd = dateIn.getDate();
	return String(yyyy + '/' + mm + '/' + dd); // Leading zeros for mm and dd
}

//////////////TAB CONTROL ///////////////////////////


// ////////////TAB CONTROL///////////////////////////

function makeDaysTab(totalDays) {
	$('#myTab').empty();
	for (var i = 1; i <= totalDays; i++) {
		if (i === 1) {
			$('#myTab').append(
					'<li class="active"><a href="#day' + i + '" index="'
							+ (parseInt(i) - 1) + '">day' + i + '</a></li>');
			$('.tab-content').append(
					'<div class="tab-pane active" id="day' + i + '"></div>');
		} else {
			$('#myTab').append(
					'<li><a href="#day' + i + '" index="' + (parseInt(i) - 1)
							+ '">day' + i + '</a></li>');
			$('.tab-content').append(
					'<div class="tab-pane" id="day' + i + '"></div>');
		}
		days[i - 1] = new Array();
	}
	$('#myTab a').click(function(e) {
		e.preventDefault();
		// 클릭된 탭이 보이도록하기
		$(this).tab('show');

		// 현재 보는 탭을 저장
		nowActiveTab = $(this).attr('href');
		nowActiveIdx = $(this).attr('index');
		// 맵에서 모든 마커를 지우고 해당 탭의 마커로 다시그리기
		refreshMarkerList();
		// 현재 보고있는 맵의 위치를 해당 탭 포인트가 있는곳으로 이동 시킴
		if (days[nowActiveIdx].length > 0) {
			ChangeMapCenterZoom(days[nowActiveIdx]);
		}
	});
	if (totalDays > 0) {
		nowActiveTab = '#day1';
		nowActiveIdx = '0';
	}
}

function ChangeMapCenterZoom(places) {
	var Top = places[0].lat;
	var bottom = places[0].lat;
	var left = places[0].lng;
	var right = places[0].lng;
	// var newLat, newLng, LatVolume, LngVolume;

	for (var i = 0; i < places.length; i++) {
		if (places[i].lat > Top) {
			top = places[i].lat;
		}
		if (places[i].lat < bottom) {
			bottom = places[i].lat;
		}

		if (places[i].lng < left) {
			left = places[i].lng;
		}
		if (places[i].lng > right) {
			right = places[i].lng;
		}
	}

	var bounds = new google.maps.LatLngBounds(
			new google.maps.LatLng(Top, left), new google.maps.LatLng(bottom,
					right));
	map.fitBounds(bounds);
}

//////////////TAB CONTROL END///////////////////////////