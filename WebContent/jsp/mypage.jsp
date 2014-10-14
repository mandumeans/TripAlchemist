<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
 <link href="../css/bootstrap.css" rel="stylesheet">
 <link href="../css/index.css" rel="stylesheet">
 <link href="../css/nav.css" rel="stylesheet">
 <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
 <script type="text/javascript" src="../js/bootstrap.min.js"></script> 
</head>
<body>
	<jsp:include page="top.jsp" flush="false">
        <jsp:param name="param" value="top"/>
	</jsp:include>	
	<div class ="page">
    	<div class="container">     
      		<div class="jumbotron">
        		<h1>My Page</h1>
        		<ul class="nav nav-tabs">			
			 		<li class="active"><a href="mypage.jsp" >내 일정</a></li>
			 		<li><a href="mylandmark.jsp">내 명소</a></li>
			 		<li><a href ="modify.jsp">내 정보</a></li>
				</ul>	
				<div>
					
				</div>        
			</div>
		</div>
    </div>

</body>
</html>