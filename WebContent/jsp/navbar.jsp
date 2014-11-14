<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="member.dto.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%MemberDTO memberDTO =(MemberDTO)session.getAttribute("member_info"); %>
<body>
<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand">TripAlchemist</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="main.jsp">Home</a></li>
            <li><a href="#about">여행일정찾기</a></li>
            <li><a href="#contact">명소찾기</a></li>
            <%if(memberDTO == null){ %>
            <li><a href="#myModal" data-toggle="modal" data-target="#myModal">내일정만들기</a></li>
            <%}else{ %>
            <li><a href ="#contact">내 일정만들기</a>
            <%} %>
          </ul>
          <%if(memberDTO ==null){ %>
          <ul class="nav navbar-nav navbar-right">            
            <li class="active"><a href="#myModal" data-toggle="modal" data-target="#myModal">로그인</a></li>
          </ul>
          <%}else{ %>
          <ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">
          		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user pull-right"></span><%=memberDTO.getName()%>님</a>
          		<ul class="dropdown-menu">           	
            		<li><a href="myprofile.jsp">마이 페이지 <span class="glyphicon glyphicon-stats pull-right"></span></a></li>
            		<li class="divider"></li>
            		<li><a href="logout.jsp">로그아웃 <span class="glyphicon glyphicon-log-out pull-right"></span></a></li>
          		</ul>
        	</li>
      	</ul>
        <%} %>
       </div>
     </div>
</div>
<div class="modal fade" id="myModal">
	<div class="modal-dialog">
    	<div class="modal-content">
        	<div class="modal-header">
          		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          		<h4 class="modal-title">로그인 </h4>
        	</div>      
        	<form name = "form" class="form" method="post" action="/tripAlchemist/login" accept-charset="UTF-8">
        		<div class="modal-body">           
                    <div class="form-group">
                    	<label class="sr-only" for="exampleInputEmail2">Email address</label>
                    	<input name ="email" type="email" class="form-control"  placeholder="이메일을 입력하세요." required>
                    </div>
                    <div class="form-group">
                        <label class="sr-only" for="exampleInputPassword2">Password</label>
                    	<input name ="password" type="password" class="form-control"  placeholder="패스워드를 입력하세요." required>
                    </div>
                    
					<p class="text-right"><a href="#">비밀번호를 잊어버렸나요?</a></p>
				</div>
        		<div class="modal-footer">
          			<a href="#" data-dismiss="modal" class="btn btn-default">닫기</a>
          			<button type ="submit" class="btn btn-primary">로그인</button>          
        		</div>
        	</form>
      	</div>
    </div>
</div>          
</body>
</html>