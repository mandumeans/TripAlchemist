%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String location = request.getParameter("location");
%>

<html>
	<body>
		<p>Start Date: <%=startDate %></p>
		<p>End Date: <%=endDate %></p>
		<p>Location: <%=location %></p>
	</body>
</html>

<% 
String site = new String("https://www.airbnb.com/s/"+location+"?checkin=09%2F23%2F2014&checkout=09%2F24%2F2014&source=bb");
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site); 
%>