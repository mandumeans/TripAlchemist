<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String errMessage = (String)request.getAttribute("error_message");
%>
오류 내용 <%=errMessage %>
</body>
</html>