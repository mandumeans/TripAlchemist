<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀 번호 찾기</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<link href ="../css/test.css" rel ="stylesheet">
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type ="text/javascript" src ="../js/test.js"></script>

</head>
<body>
 
<div class ="container">
	<div class ="row">
	<div class ="col-md-8 col-md-offset-3">
		<table class="table">
			<thead>
				<tr>
					<th><h3>비밀번호 찾기</h3></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th><h5>이메일 /비밀번호찾기</h5></th>
				</tr>
				<tr>
					<th><h6>비밀번호를 찾고자 하는 아이디를 입력해 주세요.</h6></th>
				</tr>
			</thead>
		</table>
	</div>
	</div>
	<div class ="row">
	<div class ="col-md-4 col-md-offset-3" >		
		<form name ="passwordchek" method ="post">
			<div class ="form-group">
				<input class ="form-control" placeholder ="이메일을 입력해주세요." name ="email" type="email" autofocus required>
				<br>
				<input class ="form-control" placeholder ="이름을 입력해주세요." name ="name" type ="text" required>
				<br>
				<button type = "submit" class="btn btn-lg btn-primary btn-block">확인</button>
			</div>
		</form>
	</div>
</div>
</div>
</body>
</html>