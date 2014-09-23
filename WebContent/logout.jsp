<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="bootstrap.min.css" rel="stylesheet">
	<link href="index.css" rel="stylesheet">
	<script type="text/javascript" src="jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="bootstrap.min.js"></script>
</head>
<body>
	<%
		session.invalidate(); 
		response.sendRedirect("index.jsp");
	%>
	
</body>
</html>