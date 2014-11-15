<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="headerExam.jsp" %>
	<script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD-EDvVM7eLhn0JWHezI7x2eGmAhre2BjE&sensor=FALSE">
    </script>
    <script type="text/javascript">
      function initialize() {
        var mapOptions = {
          center: { lat: -34.397, lng: 150.644},
          zoom: 8
        };
        var map = new google.maps.Map(document.getElementById('map-canvas'),
            mapOptions);
      }
      google.maps.event.addDomListener(window, 'load', initialize);
    </script>
	<div id="map_canvas" style="width: 940px; height: 540px;">
	</div>
	<div class="bnbwrap">
		<ul>
			<li class="bnblist">
				<div class="cell num">1</div>
				<div class="cell itemthumb">
					<img class="img-responsive" src="http://placehold.it/70X70">
				</div>
				<div class="cell itemname">Hotel 1</div>
				<div class="cell itemadrs">Hotel address 1</div>
				<div class="cell reserve last"><input type="button" name="bnb" value="예약하기"></div>
			</li>
			<li class="bnblist">
				<div class="cell num">2</div>
				<div class="cell itemthumb">
					<img class="img-responsive" src="http://placehold.it/70X70">
				</div>
				<div class="cell itemname">Hotel 2</div>
				<div class="cell itemadrs">Hotel address 2</div>
				<div class="cell reserve last"><input type="button" name="bnb" value="예약하기"></div>
			</li>
			<li class="bnblist">
				<div class="cell num">3</div>
				<div class="cell itemthumb">
					<img class="img-responsive" src="http://placehold.it/70X70">
				</div>
				<div class="cell itemname">Hotel 3</div>
				<div class="cell itemadrs">Hotel address 3</div>
				<div class="cell reserve last"><input type="button" name="bnb" value="예약하기"></div>
			</li>
		</ul>
	</div>

<%@include file="footerExam.jsp" %>