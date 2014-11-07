<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String actionUrl;
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String dbUrl = "jdbc:mysql://localhost:3306/tripalchemist";
		String dbUser = "cap";
		String dbPassword = "test";
		
		String email;
		
		try {
			if(session.getAttribute("userEmail") == null) {
				email = "";
			} else {
				email = (String)session.getAttribute("userEmail");
			}
		} catch (Exception e) {
			email = "";
		}
		request.setCharacterEncoding("utf-8");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		List<String> errorMsg = new ArrayList<String>();
		int result = 0;	
		 
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE user " + "SET password=?, name=?" + "WHERE email=?"
			);
			stmt.setString(1, password);
			stmt.setString(2, name);
			stmt.setString(3, email);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsg.add("변경에 실패하였습니다.");
			}
		} catch (SQLException e) {
			errorMsg.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			 		<li><a href="mypage.jsp" >내 일정</a></li>
			 		<li><a href="mylandmark.jsp">내 명소</a></li>
			 		<li  class="active"><a href ="modify.jsp">개인 정보 수정</a></li>
				</ul>	
				<div class="container">
 <% if(errorMsg.size() > 0){%>
 <div class="alert alert-error">
 	<h3>오류:</h3>
 	<ul>
 		<% for(String msg: errorMsg){ %>
 			<li><%=msg%></li>
 			<%} %>
 	</ul>
 	</div>
 	<div>
 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
 	</div>
 	<%} else if(result == 1){%>
 	<div>
 		<b><%=name%></b> 님 수정되었습니다.
 	</div>
 	<div>
 		<a href="main.jsp" class="btn btn-mini btn-primary">목록</a>
 		<a href="mypage.jsp" class="btn btn-mini btn-primary">마이페이지</a>
 	</div>
 	<%} %>
 </div>
			</div>
		</div>
	</div>
</body>
</html>

 
