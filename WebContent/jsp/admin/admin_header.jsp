<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ page import ="java.sql.*" %>
 <%@ page import ="com.ta.web.DBConnector" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Trip Alchemist Admin Office</title>
		<link href="../../CSS/bootstrap.min.css" rel="stylesheet">
		<link href ="../../CSS/datepicker.css" rel="stylesheet">
		<link href="../../CSS/index.css" rel="stylesheet">
		<link href="../../CSS/main.css" rel="stylesheet">
		<link href="admin-css/admin_jy.css" rel="stylesheet">

		<script type="text/javascript" src="../../js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
		<script type ="text/javascript" src ="../../js/bootstrap-datepicker.js"></script>
	</head>
	<body>
		<div id="wrapper">
		<div id="left_menu">
			<ul>
				<li><a href="manage_users.jsp">Users</a></li>
				<li><a href="manage_landmarks.jsp">Landmarks</a></li>
				<li><a href="manage_hotels.jsp">Hotels</a></li>
			</ul>
		</div>