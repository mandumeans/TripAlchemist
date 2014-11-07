package com.ta.web;

import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.ta.web.DBConnector;

public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
    }
	
	@SuppressWarnings("unchecked")
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain;charset=UTF-8");
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try{
        	conn = DBConnector.makeConnection();
            String query = "INSERT INTO user(`email`,`name`,`password`,`DOB`,`gender`,`auth`,`createdat`,`modifydat`) VALUES(?,?,?,?,'M','0',NOW(),NOW());";
            
        	stmt = conn.prepareStatement(query);
            
        
			String email = req.getParameter("email");
			String name = req.getParameter("name");
			String pw = req.getParameter("password");
			String dob = req.getParameter("dob");
			//String gender = req.getParameter("gender");
        	
			stmt.setString(1, email);
			stmt.setString(2, name);
			stmt.setString(3, pw);
			stmt.setString(4, dob);
        	//stmt.setString(5, gender);
        	
        	stmt.executeUpdate();
            
            
    		PrintWriter out = resp.getWriter();
    		
            resp.sendRedirect("./jsp/index.jsp");
            out.flush();
            out.close();    
        } catch(SQLException e){
			e.printStackTrace();
        } catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		}
    }
	
}
