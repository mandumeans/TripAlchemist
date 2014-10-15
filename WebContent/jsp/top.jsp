<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
 <%@ page import ="com.ta.web.DBConnector" %>
<%
	int error =0;
	try {
		error = Integer.parseInt(request.getParameter("error"));
	}catch(Exception ex){
	}
	if(error!=0){
		try{
			out.println("<script>alert('아이디 또는 패스워트를 확인하세요.');</script>");
		}catch(Exception e){
		}
	}
%>
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
				
			con = DBConnector.makeConnection();
			
			stmt = con.prepareStatement("SELECT *FROM user WHERE email = ?");
			stmt.setString(1,email);
			rs = stmt.executeQuery();
				
			if(rs.next()){
				savePassword = rs.getString("password");
				if(savePassword.equals(password)){
					session.setAttribute("userName",rs.getString("name"));
					session.setAttribute("userEmail",rs.getString("email"));
					error = 0;
					response.sendRedirect("top.jsp");
				}else{
						error = 1;
					}
			}else{
				error=1;
			}
			response.sendRedirect("top.jsp?error =" +error);
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
   		<div class="row">
      		<div class="col-md-12">
         		<nav class="navbar navbar-default navbar-fixed-top" >
            		<div class="navbar-header">
               			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
               				<span class="sr-only">Toggle navigation</span>
               				<span class="icon-bar"></span>
               				<span class="icon-bar"></span>
               				<span class="icon-bar"></span>
               			</button>
               			<div class ="nav-arr">
               				<a class="navbar-brand" href="index.jsp">TripAlchemist</a>
               			</div>
            		</div>
            		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
               			<div class ="nav-arr">
               				<ul class="nav navbar-nav">
                  				<li><a href="#">여행 일정 찾기</a></li>
                  				<li><a href="#">명소 찾기</a></li>
                  				<li class= "active">
                  					<% if(session.getAttribute("userName")==null){ %>
                  					<a href="#myModal" data-toggle="modal" data-target="#myModal">내 일정 만들기</a>
                  					<%}else{ %> <a href ="../test/mapExample.jsp">내 일정 만들기</a>
                  					<%} %>
                  				</li>                  		
               				</ul>               		
              			</div>              
              			<div class ="nav-array">
               				<ul class="nav navbar-nav navbar-right">
                 				<% if(session.getAttribute("userName")==null){ %>
                  				<li class="dropdown">
                     				<a href="#" class="dropdown-toggle" data-toggle="dropdown">로그인 <b class="caret"></b></a>
                     				<ul class="dropdown-menu" style="padding: 15px;min-width: 250px;">
                        				<li>
                           					<div class="row">
                              					<div class="col-md-12">
                                 					<form name = "form" class="form" method="post" accept-charset="UTF-8">
                                    					<div class="form-group">
                                       						<label class="sr-only" for="exampleInputEmail2">Email address</label>
                                       						<input name ="email" type="email" class="form-control"  placeholder="이메일을 입력하세요." required>
                                    					</div>
                                    					<div class="form-group">
                                       						<label class="sr-only" for="exampleInputPassword2">Password</label>
                                       						<input name ="password" type="password" class="form-control"  placeholder="패스워드를 입력하세요." required>
                                    					</div>
                                    					<div>
                                       						<a href="#">비밀번호를 잊어버렸나요?</a><p></p>
                                    					</div>
                                    					<div class="form-group">
                                       						<button type="submit" class="btn btn-success btn-block">로그인</button>
                                    					</div>
                                 					</form>
                              					</div>
                           					</div>
                        				</li>                        
                     				</ul>
                  				</li>
                				<%}else{ %>
                				<li class="dropdown">
                     				<a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=session.getAttribute("userName")%>님 <b class="caret"></b></a>
                     				<ul class="dropdown-menu" style="padding: 15px;min-width: 250px;">
                						<li><a href="mypage.jsp">마이페이지</a></li>
                						<li class ="divider"></li>
                						<li><a href ="logout.jsp">로그아웃</a></li>
                	 				</ul>
                	 			</li>
                				<%} %> 
               				</ul>
               			</div>
            		</div>                       
         		</nav>
      		</div>
      		<div class="modal fade" id="myModal">
				<div class="modal-dialog">
      				<div class="modal-content">
        				<div class="modal-header">
          					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          					<h4 class="modal-title">로그인 </h4>
        				</div>
        				<form name = "form" class="form" method="post" accept-charset="UTF-8">
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
   		</div>
	</div>
