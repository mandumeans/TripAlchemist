<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import ="java.sql.*" %>
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	try{
		String url ="jdbc:mysql://localhost:3306/tripalchemist";
		String user = "cap";
		String pwd = "test";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,pwd);
		
		request.setCharacterEncoding("utf-8");
		
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String DOB = request.getParameter("DOB");
		String gender = request.getParameter("gender");
		
		String sql ="insert into user values(?,?,?,?,?)";
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, name);
		stmt.setString(2, email);
		stmt.setString(3, password);
		stmt.setString(4, DOB);
		stmt.setString(5, gender);
		
		stmt.executeUpdate();
		
	}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
		}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다. (순서중요)
		if(stmt != null) try{stmt.close();}catch(SQLException sqle){}            // PreparedStatement 객체 해제
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
		if(rs != null) try{rs.close();} catch(SQLException e){}
	}
%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
 <link href="../css/bootstrap.min.css" rel="stylesheet">
 <link href="../css/bootstrap.css" rel="stylesheet">
 <link href="../css/index.css" rel="stylesheet">
 <link href="../css/nav.css" rel="stylesheet">
 <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
 <script type="text/javascript" src="../js/bootstrap.min.js"></script>
 <script type ="text/javascript" src ="../js/jquery-birthday-picker.min.js"></script> 

</head>
<body>
	<jsp:include page="top.jsp" flush="false">
        <jsp:param name="param" value="top"/>
	</jsp:include>	
	<div class ="login-image">
		<div class ="container">
			<% if(session.getAttribute("userName")==null){ %>
			<form class ="form-signin">
      			<h1 class="form-signin-heading">TripAlchemist</h1>
				<input type="text" name ="search" class="form-control" placeholder="지역을 입력해주세요.">
      		</form>			
      		<form name = "form" class="form-signin" action="index.jsp" method ="post">  	
        		email : <input type="email" name ="email" class="form-control" placeholder="이메일" required>
        		name : <input type="text" name ="name" class="form-control" placeholder ="사용자 이름" autofocus required>        		
        		password :<input type="password" name ="password" class="form-control" placeholder="비밀번호" required>        		        			
				<div id="default-settings"></div>
				<script>
					$("#default-settings").birthdayPicker();											
				</script>	
        		<p></p>
        		성별 : <input type ="radio" name ="gender" class ="radio-inline" value="option1" required> 남성
        		<input type ="radio" name ="gender" class ="radio-inline" value="option2" required> 여성
        		<p></p>
        		<button type = "submit" class="btn btn-lg btn-primary btn-block">가입</button>
      		</form>
       		<%}else{ %>
       		<div class ="form-arr">
       			<form class ="form-signin">
      				<h1 class="form-signin-heading">TripAlchemist</h1>
      				<h2>안녕하세요 <%=session.getAttribute("userName")%>님 </h2><p></p>
					<input type="text" name ="search" class="form-control" placeholder="지역을 입력해주세요.">
      			</form>	
      		</div>
      		<%} %> 
    	</div>
    </div>
    <div class="container">
    	<div class="row">			
            <div class="col-lg-12">
                <h3 class="page-header">
                    <small><img class ="arr" src = "../image/font.JPG" ></small>
                </h3>
            </div>			
        </div>
    	<div>   	
     		<div class="row">
            	<div class="col-md-4 portfolio-item">
                	<a href="#project-link">
                    	<img class="img-responsive" src="http://placehold.it/700x400">
                	</a>
               		<h3><a href="#project-link">여행 일정</a></h3>
                	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>                
            	</div>
				<div class="col-md-4 portfolio-item">
                	<a href="#project-link">
                    	<img class="img-responsive" src="http://placehold.it/700x400">
                	</a>
                	<h3><a href="#project-link">여행 일정</a></h3>
                	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
            	</div>
            	<div class="col-md-4 portfolio-item">
                	<a href="#project-link">
                    	<img class="img-responsive" src="http://placehold.it/700x400">
                	</a>
               		<h3><a href="#project-link">여행 일정</a></h3>
                	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>                
            	</div>
				   
    			<p></p>
    		</div>
			<div class="row">
            	<div class="col-md-4 portfolio-item">
                	<a href="#project-link">
                    	<img class="img-responsive" src="http://placehold.it/700x400">
                	</a>
               		<h3><a href="#project-link">여행 일정</a></h3>
                	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>                
            	</div>
				<div class="col-md-4 portfolio-item">
                	<a href="#project-link">
                    	<img class="img-responsive" src="http://placehold.it/700x400">
                	</a>
                	<h3><a href="#project-link">여행 일정</a></h3>
                	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
            	</div>
            	<div class="col-md-4 portfolio-item">
                	<a href="#project-link">
                    	<img class="img-responsive" src="http://placehold.it/700x400">
                	</a>
               		<h3><a href="#project-link">여행 일정</a></h3>
                	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>                
            	</div>
				   
    			<p></p>
    		</div>
    	</div>
    </div>
    <jsp:include page="footer.jsp" flush="false">
        <jsp:param name="param" value="footer"/>
	</jsp:include>	            
</body>
</html>


 

    

  
  