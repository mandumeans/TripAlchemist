<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<%
	int error =0;
	try {
		error = Integer.parseInt(request.getParameter("error"));
	}catch(Exception ex){
	}
	if(error!=0){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			out.println("<script>alert('아이디 또는 패스워트를 확인하세요.');</script>");
		}catch(Exception e){
		}
	}
%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="bootstrap.min.css" rel="stylesheet">
 <link href="index.css" rel="stylesheet">
 <script type ="text/javascript">
 </script>
</head>
<body>
	<%
		if(request.getMethod() == "POST"){
			request.setCharacterEncoding("utf-8");
			
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String savePassword;
			String name ="";
			
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try{
				
				String DB_SERVER ="localhost:3306";
				String DB_SERVER_USERNAME="cap";
				String DB_SERVER_PASSWORD ="test";
				String DB_DATABASE = "Trip";
				String DB_URL = "jdbc:mysql://localhost:3306/Trip";
				Class.forName("com.mysql.jdbc.Driver");
				
				con = DriverManager.getConnection(DB_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
				
				stmt = con.prepareStatement("SELECT *FROM users WHERE email = ?");
				stmt.setString(1,email);
				rs = stmt.executeQuery();
				
				if(rs.next()){
					savePassword = rs.getString("password");
					if(savePassword.equals(password)){
						session.setAttribute("userName",rs.getString("name"));
						session.setAttribute("userEmail",rs.getString("email"));
						error = 0;
						response.sendRedirect("search.jsp");
					}else{
						error = 1;
					}
				}else{
					error=1;
				}
				response.sendRedirect("login.jsp?error =" +error);
			}catch(Exception e){
				out.println(e);
			}finally{
				if(stmt != null){
					try{
						stmt.close();
					}catch(SQLException sqle){
					}
				}
				if(con != null){
					try{
						con.close();
					}catch(SQLException sqle){
					}
				}
				if(rs != null){
					try{
						rs.close();
					}catch(SQLException sqle){	
					}
				}
			}
		}
	
	
	%>
	
	<div class="container">
      <form class ="form-signin">
      	<h1 class="form-signin-heading">TripAlchemist</h1>
      	<input type="text" class="form-control" placeholder ="TripAlchemist 검색">
      </form>
      
      <form name = "form" class="form-signin" method ="post">
        <input name = "email" type="text" class="form-control" placeholder ="이메일" autofocus>
        <input name = "password" type="password" class="form-control" placeholder="비밀번호">
        <a href ='pwd_find_form.jsp'>비밀번호를 잃어버리셨나요?</a>
        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	  	<a href ='index.jsp' class="btn btn-lg btn-default btn-block" type="button">가입</a>
	   </form>
    </div>
    <script type="text/javascript" src="jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="bootstrap.min.js"></script>
</body>
</html>


 

    

  
  