<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="bootstrap.min.css" rel="stylesheet">
<link href ="datepicker.css" rel="stylesheet">
<link href="index.css" rel="stylesheet">

<script type="text/javascript" src="jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="bootstrap.min.js"></script>
<script type ="text/javascript" src ="bootstrap-datepicker.js"></script>

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
       }).data('datepicker');
    });
</script>
</head>
<body>
	<div>
		<form class ="access">
			<%if(session.getAttribute("userName")==null){%>
				<a href = 'login.jsp'>login</a>
			<%}else{%>
					<%=session.getAttribute("userName") %>님 안녕하세요.
					<a href ='logout.jsp'>logout</a>
				<% }%>
		</form>	
	</div>
	
    <div class="container">
    	<div class="form-signin">
    		<h1 class="form-signin-heading">TripAlchemist</h1>
    		<h2>여행을 시작할 날짜와 끝낼 날짜를 입력하세요.</h2>
    		<p><input type ="text" class = "form-control" data-date-format="yyyy-mm-dd" placeholder="시작 날짜"  id="start_date"></p>
    		<p><input type ="text" class = "form-control"data-date-format="yyyy-mm-dd" placeholder="마지막 날짜" id="end_date"></p>
    		<button class="btn btn-lg btn-primary btn-block" type="submit">검색</button>
    	</div>
    </div>
</body>
</html>
