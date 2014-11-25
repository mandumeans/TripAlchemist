<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.ta.web.DBConnector" %>
<%@page import ="member.dto.MemberDTO" %>
<%@page import ="member.dto.ScheduleList" %>
<%@page import ="java.util.Vector"%>
<%@page import = "member.dto.ScheduleDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<link href ="../css/testing.css" rel ="stylesheet">
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type ="text/javascript" src ="../js/testing.js"></script>

<%MemberDTO memberDTO =(MemberDTO)session.getAttribute("member_info"); %>
</head>
<body>
<jsp:include page="navbar.jsp" flush="false">
	<jsp:param name="param" value="navbar"/>
</jsp:include>
<br><br><br><br>

<div class="container">
    <div class="row">
		<div class="col-md-12">
			<h3>마이페이지</h3>
			<div class="tabbable-panel">
				<div class="tabbable-line">
					<ul class="nav nav-tabs ">
						<li class="active">
							<a href="#tab_default_1" data-toggle="tab">내 일정</a>
						</li>
						<li>
							<a href="#tab_default_2" data-toggle="tab">내 명소</a>
						</li>
						<li class="dropdown">
        					<a href="#" class="dropdown-toggle" data-toggle="dropdown">개인 정보<b class="caret"></b></a>
        					<ul class="dropdown-menu">
          						<li><a href="#tab_default_3" data-toggle="tab">내 정보 보기</a></li>
         						<li><a href="#tab_default_4" data-toggle="tab">내 정보 수정</a></li>
        					</ul>
      					</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_default_1">
	   						<div class="container">
   
    <div class="row">
    
        <div class="panel panel-primary filterable">
            <div class="panel-heading">
                <h4 class="panel-title"><a href="#myModal1" data-toggle="modal" data-target="#myModal1" class="btn btn-info">내 일정 만들기</a></h4>
                <div class="pull-right">
                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
                </div>
            </div>
            <table class="table">
                <thead>
                    <tr class="filters">
                        <th><input type="text" class="form-control" placeholder="#" disabled></th>
                        <th><input type="text" class="form-control" placeholder="제목" disabled></th>
                        <th><input type="text" class="form-control" placeholder="시작 날짜" disabled></th>
                        <th><input type="text" class="form-control" placeholder="끝 날짜" disabled></th>
                        <th><input type="text" class="form-control" placeholder="만든 시간" disabled></th>   
                          
                    </tr>
                </thead>
                <tbody>
                             
                <%
                ScheduleDao bdao = new ScheduleDao();
 Vector<ScheduleList> vector = new Vector();
 vector = bdao.getAllBoard();
 
 // 게시판 빈클래스 선언
 	ScheduleList bean = new ScheduleList();
 
 		for(int i = 0 ; i < vector.size() ; i++){
  			
  			bean = vector.get(i);
 				%>
                    <tr>
                        <td><%=bean.getTripNum()%></td>
                        <td><%=bean.getTitle()%></td>
                        <td><%=bean.getStartDat()%></td>
                        <td><%=bean.getEndDat()%></td>
                        <td><%=bean.getCreatedat()%></td>                                                                 
                    </tr>
                 <%   
    }
    %>                
                </tbody>
            </table>
        </div>
    </div>
</div>
	   					
 		
						</div>											
						<div class="tab-pane" id="tab_default_2">
							<div class ="container">
	   							<div class ="row">
	   								<br>	   	
	   								<div class ="col-lg-3 col-sm-6">
	   								<a href="#myModal2" class="thumbnail" data-toggle="modal" data-target="#myModal2">
     									<img src="../image/go.JPG" alt="...">
   									</a>
   									</div>							
	   								<div class ="col-lg-3 col-sm-6"><div class ="well"><a href="#myModal2" data-toggle="modal" data-target="#myModal2">명소 등록하기</a></div></div>
	   								<div class ="col-lg-3 col-sm-6"><div class ="well"><a href ="#">일정 만들기</a></div></div>	   							   								
	   							</div>
	   						</div>
 		
						</div>						
						<div class="tab-pane" id="tab_default_3">
							<div class="container">
      							<div class="row">
      								<br><br>
        							<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >  
          								<div class="panel panel-info">
            								<div class="panel-heading">
              									<h3 class="panel-title"><%=memberDTO.getName()%></h3>
            								</div>
            								<div class="panel-body">
              									<div class="row">
                									<div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100" class="img-circle"> </div>        
                										<div class=" col-md-9 col-lg-9 "> 
                  											<table class="table table-user-information">
                    										<tbody>
                      											<tr>
                        											<td>Email</td>
                       	 											<td><%=memberDTO.getEmail()%></td>
                      											</tr>
                      											<tr>
                        											<td>Name</td>
                        											<td><%=memberDTO.getName()%></td>
                      											</tr>
                      											<tr>
                        											<td>Date of Birth</td>
                        											<td><%=memberDTO.getDOB()%></td>
                      											</tr>                   
                      											<tr>
                        											<td>Gender</td>
                        											<td><%=memberDTO.getGender()%></td>
                      											</tr>
                    										</tbody>
                  											</table>                 
                									</div>
              								  </div>
            							  </div>
                 						  <div class="panel-heading">
              								<h3 class="panel-title"></h3>
            							  </div>         
          							 </div>
        						 </div>
      						  </div>
    					  </div>
						</div>
						<div class="tab-pane" id="tab_default_4">
							<form action="/tripAlchemist/update" method ="post">
      						<br>
      						<div class="container">
    							<div class="row clearfix">
    								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
										<table class="table table-bordered table-hover table-sortable" id="tab_logic">
											<thead>
												<tr>
													<th class="text-center">
														정보
													</th>
													<th class="text-center">
														내 정보 
													</th>
												</tr>					
											</thead>
											<tbody>
    											<tr>
													<td class="text-center">이름</td>
													<td data-name = "name">
														<input type="text" name="name"  value ="<%=memberDTO.getName()%>" class="form-control" autofocus/>
													</td>
												</tr>
												<tr>
													<td class="text-center">성별</td>
													<td data-name = "name">
														<select class ="form-control" name ="gender" value="<%=memberDTO.getGender()%>">        												
        													<option>M</option>
        													<option>F</option>
        												</select>
													</td>
												</tr>
												<tr>
													<td class="text-center">생년월일</td>
													<td data-name = "name">									
														<input type="text" name="DOB" value ="<%=memberDTO.getDOB()%>" class="form-control">							
													</td>
												</tr>
												<tr>
													<td class="text-center">패스워드</td>
													<td data-name = "name">
														<input type="password" name="password"  value ="<%=memberDTO.getPassword()%>" class="form-control"/>
													</td>
												</tr>
											
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
								<button type = "submit"  class="btn btn-primary pull-right">수정하기</button>
							</div>
						</div>      						
      					</form>
						</div>						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal1">
	<div class="modal-dialog">
    	<div class="modal-content">
        	<div class="modal-header">
          		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          		<h4 class="modal-title">내 일정 만들기 </h4>
        	</div>      
        	<form name = "date" class="form" method="post" action="/tripAlchemist/login" accept-charset="UTF-8">
        		<div class="modal-body">      
        			<div class="form-group">
        				<div class = "form-group">
						<h4 id="title">여행 제목을 입력해주세요.</h4>
						<label class="sr-only"></label>
                    	<input type ="text" class = "form-control" placeholder="예 : 5박 6일 유럽 여행 명소여행" required autofocus>
					</div>
					
        				<h4 id="title">여행을 시작할 날짜와 끝낼 날짜를 입력해주세요.</h4>
                    	<label class="sr-only"></label>
                    	<input type ="text" class = "form-control" data-date-format="yyyy-mm-dd" placeholder="시작 날짜"  id ="start_date" required>
                    </div>     
                    <div class="form-group">
                        <label class="sr-only"></label>
                    	<input type ="text" class = "form-control"data-date-format="yyyy-mm-dd" placeholder="마지막 날짜" id="end_date" required>
                    </div>                                          				
				</div>
        		<div class="modal-footer">          			
          			<button type ="submit" class="btn btn-primary">만들기</button>
          			<a href="#" data-dismiss="modal" class="btn btn-default">닫기</a>          
        		</div>
        	</form>
      	</div>
    </div>
</div>          		
</body>
</html>