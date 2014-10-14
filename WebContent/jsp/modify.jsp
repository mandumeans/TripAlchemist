<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>	
 <%
	String errorMsg=null;
 	String actionUrl=null;
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/tripalchemist";
	String dbUser = "cap";
	String dbPassword = "test";

	String password="";
	String name = "";
	
	String email;
	try {
		if(session.getAttribute("userEmail") == null) {
			email = "";
		} else {
			email = (String)session.getAttribute("userEmail");
		}
	} catch (Exception e) {
		System.out.println(e);
		email = "";
	}if(email!=null){
		actionUrl="update.jsp";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	 		// 질의 준비
			stmt = conn.prepareStatement("SELECT PASSWORD,name FROM USER WHERE email= ?");
		  stmt.setString(1, email);
			rs = stmt.executeQuery();
			
			// 수행
	    while(rs.next()) {
				password=rs.getString("password");
				name=rs.getString("name");
				
				}
		}catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
			System.out.println(errorMsg);
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}	
%>    
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
 <script type="text/javascript">
	function checkPwd(){
		if (frm.pwd.value != frm.pwdchk.value){
			alert("비밀번호가 같지 않습니다.");
			frm.pwdchk.value="";
		}
	}
	function returnPage(){
		window.location="main.jsp"
	}
	function goPage(){
		window.location="mypage.jsp"
	}
	</script>
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
     				<form name="form" class="form-horizontal" action="<%=actionUrl%>" method="post">
						<fieldset>
	   	 				<table>
	   	 				<tbody>
	   	 					<tr>
        						<th colspan="2" class="title"><div><label>기본 정보</label></div></th>
    						</tr>
	   	 					<tr>
								<th><label for="name">이름</label></th>
								<td>
									<input type="text" id="name" name="name" value="<%=name%>" />
								</td>
								
							</tr>	
  	  						
		    				<tr>
								<th><label for="name">비밀번호</label></th>
								<td><input type="password" id="pwd" name="pwd" value="<%=password%>"/>
									<br>
									<p style="font-size:9pt; color:red;">비밀번호는 6~20자로 되어야 합니다.</p>
								</td>
							</tr>		
							<tr>
								<th><label for="name">비밀번호확인</label></th>
								<td><input type="password" id="pwdchk" name="pwdchk" onblur="javascript:checkPwd();" value="<%=password%>"/>
									<p style="font-size:9pt; color:red;">비밀번호를 동일하게 입력하세요.</p>
								</td>
							</tr>			
 									
 							<tr>        
 								<th class="button" colspan="2">
 									<button type="submit" class="btn btn-primary">수정</button>
 									<a href ="mypage.jsp" class="btn btn-danger">취소</a>
 								</th>
 							</tr>
 						</tbody>
 						</table>
 					</fieldset>
					</form>  
  				</div>      
			</div>
		</div>
	</div>
</body>
</html>




