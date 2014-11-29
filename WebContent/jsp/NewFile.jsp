<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">

<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>

</head>
<body>
<jsp:include page="navbar.jsp" flush="false">
        <jsp:param name="param" value="navbar"/>
</jsp:include>	  
<div class="container">
<br><br><br><br>

<div class="row">
<div class="col-sm-6 col-sm-offset-3">
<h1 class="text-center">비밀 번호 찾기</h1><br>
</div>
</div>
<div class="row">
<div class="col-sm-6 col-sm-offset-3">
<p>비밀번호를 찾고자 하는 이메일과 이름을 입력해주세요.</p>
<form method="post" name = "findForm" action ="/tripAlchemist/PassFind" accept-charset="UTF-8">
<input type="email" class="input-lg form-control" name="email" placeholder="Email@email.com" autofocus required>
<div class="row">
<div class="col-sm-6">
<span id="8char" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 이메일을 입력하세요<br><br>
</div>
</div>
<input type="text" class="input-lg form-control" name="name" id="password2" placeholder="Name" required>
<div class="row">
<div class="col-sm-6">
<span id="8char" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 이름을 입력하세요<br><br>
</div>
</div>
<button type="submit" class="col-xs-12 btn btn-primary btn-load btn-lg">비밀번호 찾기</button>
</form>
</div><!--/col-sm-6-->
</div><!--/row-->
</div>
</body>
</html>