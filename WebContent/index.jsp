<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@ page import ="java.sql.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost::3306/trip";
	String dbUser = "cap";
	String dbPassword = "test";
	
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	List<String> errorMsg = new ArrayList<String>();
	int result =0;
	
	try{
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement("INSERT INTO users" + "VALUES(?,?,?)");
		stmt.setString(1,id);
		stmt.setString(2,email);
		stmt.setString(3,password);
		result = stmt.executeUpdate();
		if(result !=1){
			errorMsg.add("등록에 실패하였습니다.");
		}
		} catch(SQLException e){
			errorMsg.add("SQL 오류: " + e.getMessage());
		} finally{
			if(rs != null) try{rs.close();} catch(SQLException e){}
			if(stmt != null) try{stmt.close();} catch(SQLException e){}
			if(conn != null) try{conn.close();} catch(SQLException e){}
		}
	
	
%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
 <link href="bootstrap.min.css" rel="stylesheet">
 <link href="index.css" rel="stylesheet">
 <script type="text/javascript" src="jquery-1.11.1.min.js"></script>
 <script type="text/javascript" src="bootstrap.min.js"></script>
 <script type = "text/javascript">
 	function regChk(){
 		var id = document.form.id.value;
 		if(id.length == 0 || id == null){
 			alert("이름을 입력해주세요");
 			return false;
 		}
 		
 		var email = document.form.email.value;
 		if(email.length == 0 || email == null){
 			alert("이메일을 입력해주세요");
 			return false;
 		}
 		if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)) {
		} else {
			alert("이메일의 형식이 옳지 않습니다.");
			return false;
		}
 		var password = document.form.password.value;
 		if(password.length < 8 || password == null){
 			alert("비밀번호는 8자 이상으로 입력하세요");
 			return false;
 		}
 		if(password.length>13){
 			alert("비밀번호는 12자 이하로 입력하세요.");
 		}
 		document.form.submit();
 	}
 	
 	
 </script>
</head>
<body>
	<div class ="container">  
		<form class ="form-signin">
      		<h1 class="form-signin-heading">TripAlchemist</h1>
      		<input type="text" class="form-control" placeholder ="TripAlchemist 검색">
      	</form>
			
      <form name = "form" class="form-signin" action = "search.jsp" method ="post">  	
        <input type="text" name ="id" class="form-control" placeholder ="사용자 이름" autofocus>
        <input type="text" name ="email" class="form-control" placeholder="이메일">
        <input type="password" name ="password" class="form-control" placeholder="비밀번호">
        <input type = "button" value ="가입" class="btn btn-lg btn-primary btn-block" onclick = "regChk()">
        <a href ='login.jsp' class="btn btn-lg btn-default btn-block" type="button">로그인</a> 
      </form>
    </div>
    
</body>
</html>


 

    

  
  