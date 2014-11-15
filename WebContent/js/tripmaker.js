var map;
var geocoder;

// 날들을 저장함 (2차원배열)
var days = new Array();
var landmarks = new Array();

// 현재 선택된 탭과 그 날짜가 뭔지 저장하는 상태함수
var nowActiveTab;
var nowActiveIdx;

// 명소들을 저장하기위한 구조체
function placeInfo(day, lat, lng, address, name, type, marker) {
	this.day = day;
	this.lat = lat; // latitude
	this.lng = lng; // longitude
	this.address = address;
	this.name = name;
	this.type = type; // 1.landmark 2.food 3.accomodation 4.shopping
						// 5.entertaining 6.etc
	this.marker = marker;
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
		insertNewPlace(event.latLng);
	});
}

function insertNewPlace(location) {
	// push place information to places array
	var lat = location.lat();
	var lng = location.lng();

	// 구글 API로 부터 실제 주소를 받아온다.
	var realAddress = getRealAddress(lat, lng, function(result) {
		// 실제 주소 받아오는게 성공하면 현재 활성화된 탭에 리스트를 추가해줌
		if (result === null || typeof result === 'undefined') {
			$(nowActiveTab).append(
					'<li class="list-group-item">(' + lat.toFixed(2) + ','
							+ lng.toFixed(2) + ')</li>');
		} else {
			$(nowActiveTab).append(
					'<li class="list-group-item">' + result + '</li>');
		}

		// days 2차원 배열에 현재 활성화된 날짜에 placeInfo구조체를 배열에 집어넣고 Marker도 찍는다.
		days[nowActiveIdx].push(new placeInfo(nowActiveTab, location.lat(),
				location.lng(), result, '', '', placeMarker(location)));
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

function placeMarker(location) {
	var marker = new google.maps.Marker({
		position : location,
		map : map,
		icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld='
				+ (parseInt(days[nowActiveIdx].length) + 1) + '|FE6256|000000',
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
	for (var i = 0; i < days.length; i++) {
		for (var j = 0; j < days[i].length; j++) {
			days[i][j].marker.setMap(null);
		}
	}

	for (var i = 0; i < days[nowActiveIdx].length; i++) {
		days[nowActiveIdx][i].marker.setMap(map);
		days[nowActiveIdx][i].marker
				.setIcon('http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld='
						+ (parseInt(i) + 1) + '|FE6256|000000');
	}
	$(nowActiveTab).empty();

	for (var i = 0; i < days[nowActiveIdx].length; i++) {
		$(nowActiveTab).append(
				'<li class="list-group-item">' + days[nowActiveIdx][i].address
						+ '</li>');
	}
}
///////////////MAP CONTROL END//////////////////////////////

$(document).ready(function() {
	// DATE 관련 함수는 전 페이지에서 처리하므로 지워져야할 부분
	var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp
			.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
	var checkin = $('#start_date').datepicker({
						onRender : function(date) {
							return date.valueOf() < now.valueOf() ? 'disabled' : '';
						}
					})
			.on('changeDate',function(ev) {
						if (ev.date.valueOf() > checkout.date
								.valueOf()) {
							var newDate = new Date(ev.date)
							newDate
									.setDate(newDate.getDate() + 1);
							checkout.setValue(newDate);
						}
						checkin.hide();
						$('#end_date')[0].focus();
					}).data('datepicker');
	var checkout = $('#end_date')
			.datepicker(
					{
						onRender : function(date) {
							return date.valueOf() <= checkin.date
									.valueOf() ? 'disabled'
									: '';
						}
					})
			.on(
					'changeDate',
					function(ev) {
						checkout.hide();
						var totalDays = (checkout.date - checkin.date) / 86400000;
						makeDaysTab(totalDays);
						$('#title').append(
								'(' + totalDays + '일)');
					}).data('datepicker');

	// Show Landmark button event
	$('#btnLandmarkShow')
			.click(
					function() {
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
								success : function(result) {
									$.each(result,function(index) {
										landmarks.push(new placeInfo('',result[index].lat,result[index].lng,result[index].address,result[index].name,'1',
												placeLandMarker(result[index].lat,result[index].lng,result[index].name)));
									});
								},
								error : function(result) {
									alert('failed to get landmarks');
								}
							}); // ajax end
						}
					});

	// hotel Recommend button event
	$('#btnHotelRecommand')
			.click(
					function() {
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

						var startDate = checkin.date;
						var DateToGo = new Date();
						DateToGo.setDate(startDate.getDate() + Number(nowActiveIdx));
						var location = {
							"lat" : lat,
							"lng" : lng,
							'theDay' : yyyymmdd(DateToGo)
						};

						console.log(location);
						// ajax로 추천된 데이터들 콜백함수를 통해 뿌려줌
						$.ajax({
							url : "/tripAlchemist/recommand",
							type : "GET",
							data : location,
							dataType : "json",
							contentType : "application/json",
							timeout : 10000,
							success : function(result) {
								console.log(result);
							},
							error : function(result) {
								alert('failed to get landmarks');
							}
						}); // ajax end
					}); // btnhotelRecommend event
}); // document.ready end

function yyyymmdd(dateIn) {
	var yyyy = dateIn.getFullYear();
	var mm = dateIn.getMonth(); // getMonth() is zero-based
	var dd = dateIn.getDate();
	return String(yyyy + '/' + mm + '/' + dd); // Leading zeros for mm and dd
}

// ////////////TAB CONTROL///////////////////////////

function makeDaysTab(totalDays) {
	$('#myTab').empty();
	for (var i = 1; i <= totalDays; i++) {
		if (i === 1) {
			$('#myTab').append(
					'<li class="active"><a href="#day' + i + '" index="'
							+ (parseInt(i) - 1) + '">' + i + '</a></li>');
			$('.tab-content').append(
					'<div class="tab-pane active" id="day' + i + '"></div>');
		} else {
			$('#myTab').append(
					'<li><a href="#day' + i + '" index="' + (parseInt(i) - 1)
							+ '">' + i + '</a></li>');
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