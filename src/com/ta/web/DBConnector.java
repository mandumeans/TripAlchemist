package com.ta.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class DBConnector {
	public static Connection makeConnection() throws SQLException, NamingException, ClassNotFoundException{
		//Context initCtx = new InitialContext();
		//Context envCtx = (Context)initCtx.lookup("java:comp/env");
		//DataSource ds = (DataSource)envCtx.lookup("jdbc/tripalchemist");
		//return ds.getConnection();
		Class.forName("com.mysql.jdbc.Driver");
		String DB_SERVER = "192.186.223.97:3306";//자신의 DB 포트
		String DB_SERVER_USERNAME = "ta";//자신의 DB아이디
		String DB_SERVER_PASSWORD = "test";//자신의 DB비밀번호
		//String DB_DATABASE = "data";//DB내에 존재하는 database
		String DB_DATABASE = "tripalchemist";//DB내에 존재하는 database
		Connection c = DriverManager.getConnection("jdbc:mysql://"+DB_SERVER+"/"+DB_DATABASE+"?useUnicode=true&amp;characterEncoding=UTF-8&amp;characterSetResults=UTF-8", DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
		return c;
	}
}
