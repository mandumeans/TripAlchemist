<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="bootstrap.min.css" rel="stylesheet">
<link href="index.css" rel="stylesheet">
<script type="text/javascript" src="jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="bootstrap.min.js"></script>
</head>
<body>
<div class ="container">
	<div class = "form-signin">
			<h1 class ="form-signin-heading">TripAlchemist</h1>
			<p class ="result">
			<% 
				out.print("비밀 번호는 "+"<b>" + request.getParameter("password") + "입니다.");
			%>
			</p>
			<p></p>
			<a href ='login.jsp' class="btn btn-lg btn-primary btn-block" type="button">돌아가기</a>
			
	</div>
</div>
</body>
</html>