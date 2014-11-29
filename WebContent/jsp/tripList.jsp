<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="member.dto.ScheduleList" %>
<%@page import ="java.util.Vector"%>
<%@page import = "member.dto.ScheduleDao" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.ta.web.DBConnector" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<link href="../css/list.css" rel="stylesheet">
<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/list.js"></script>
</head>
<body>

<jsp:include page="navbar.jsp" flush="false">
        <jsp:param name="param" value="navbar"/>
</jsp:include>	  

<br><br><br><br><br>
<div class="container">
<div class="row">    
        <div class="col-xs-8 col-xs-offset-2">
		    <div class="input-group">
                <div class="input-group-btn search-panel">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    	<span id="search_concept"></span>메뉴<span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a href="#contains">제목</a></li>
                      <li><a href="#its_equal">작성자</a></li>                      
                    </ul>
                </div>
                <input type="hidden" name="search_param" value="all" id="search_param">         
                <input type="text" class="form-control" name="x" placeholder="정보를 입력해주세요." autofocus>
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                </span>
            </div>
        </div>
	</div>
<br><br>
                                             
    <div class="well well-sm">
        <strong>Category Title</strong>
        <div class="btn-group">
            <a href="#" id="list" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-th-list">
            </span>List</a> <a href="#" id="grid" class="btn btn-default btn-sm"><span
                class="glyphicon glyphicon-th"></span>Grid</a>
        </div>
    </div>
    
    <div id="products" class="row list-group">  
     <%
ScheduleDao bdao = new ScheduleDao();
 Vector<ScheduleList> vector = new Vector();
 vector = bdao.getAllBoard();

 	ScheduleList bean = new ScheduleList();

 		for(int i = 0 ; i < vector.size() ; i++){
  			
  			bean = vector.get(i);
  		
 				%>  
        <div class="item  col-xs-4 col-lg-4">
            <div class="thumbnail">
                 <img class="group list-group-image" src="../image/map.JPG" alt="" />
                <div class="caption">
                	<br>
                    <h3 class="group inner list-group-item-heading"><a href ="#"><%=bean.getTitle()%></a></h3>
                    <h4 class="text-right">By <%=bean.getCreateby()%></h4>                
                    <h4 class="text-right">여행 일수 : <%=bean.getStartDat()%>~<%=bean.getEndDat() %></h4> 
                                                
                    <div class="row">
                        <div class="col-xs-12 col-md-6">
 							                   	                           
                        </div>                        
                    </div>
                </div>
            </div>
        </div>   
         <%} %>                                  
    </div>  
    
</div>
</body>
</html>