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
<div class = "container">			
	<form class ="form-signin" action="pwd_find_db.jsp" method="post">
		<h1 class ="form-signin-heading">TripAlchemist</h1>
			<h2>비밀번호  찾기</h2>
				<input class="form-control" placeholder ="이메일" type="text" name="email" autofocus>
				<p></p>
				<button class="btn btn-lg btn-primary btn-block" type="submit">찾기</button>
				<a href ='login.jsp' class="btn btn-lg btn-default btn-block" type="button">로그인</a>
			
	</form>
</div>
</body>
</html>