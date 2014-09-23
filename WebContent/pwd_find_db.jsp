<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
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
	<div class ="form-signin">
		<div class ="result">
			<h1 class="form-signin-heading">TripAlchemist</h1>
<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String dbUrl = "jdbc:mysql://localhost:3306/Trip";
		String dbUser = "cap";
		String dbPassword = "test";

		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

		//이름이 가입한목록에 있는지 없는지 
		
		if (conn != null) {
			String email = null;
			String db_name = null;
			String name = null, password = null;
			request.setCharacterEncoding("utf-8");
			email = request.getParameter("email");
			stmt = conn.prepareStatement("SELECT * FROM users WHERE email= ?");
			stmt.setString(1, email);
			rs = stmt.executeQuery();

			boolean hasEmail = false;
			while (rs.next()) {
				name = rs.getString("name");
				password = rs.getString("password");
				hasEmail = true;
			}
			if (hasEmail == false) {
				out.print("정보를 찾을 수 없습니다. <br> 입력한 내용을 다시 확인해 주십시오.");

			} else {
				response.sendRedirect("./pwd_find_msg.jsp?password=" +password);
			} 
		}
	%>
		<p></p>
		<a href ='pwd_find_form.jsp' class="btn btn-lg btn-primary btn-block" type="button">비밀번호 찾기</a> 
		</div>
	</div>
</div>
</body>
</html>