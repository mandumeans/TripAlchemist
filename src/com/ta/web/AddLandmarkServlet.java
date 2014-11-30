package com.ta.web;

import java.net.URLDecoder;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Enumeration;
import java.util.Iterator;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dto.MemberDTO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.ta.web.DBConnector;

public class AddLandmarkServlet extends HttpServlet {
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
		String resUrl = null;
    
		MemberDTO memberDTO =(MemberDTO)req.getSession().getAttribute("member_info");
		
		if(memberDTO == null){
			req.setAttribute("error_message", "로그인을 해주세요.");

    		PrintWriter out = resp.getWriter();

    		//servlet code
    		resp.setContentType("text/html");  
    		out.println("<script type=\"text/javascript\">");  
    		out.println("alert('로그인을 해주세요.');");  
    		out.println("location.href = './jsp/AddLandmark.jsp';");  
    		out.println("</script>");
    		
            out.flush();
            out.close();  
			return;
		} 
		
        try{
        	
        	conn = DBConnector.makeConnection();
        	req.setCharacterEncoding("utf-8");
        	
            String query = "insert into landmark(`name`,`address`,`lat`,`lng`,`likes`,`createdat`,`modifydat`,`createby`,`modifyby`) values(?,?,?,?,'0',NOW(),NOW(),?,'');";
            
        	stmt = conn.prepareStatement(query);
            
        
			String name = req.getParameter("placeName");
			String address = req.getParameter("address");
			String lat = req.getParameter("lat");
			String lng = req.getParameter("lng");
        	
			stmt.setString(1, name);
			stmt.setString(2, address);
			stmt.setString(3, lat);
			stmt.setString(4, lng);
			stmt.setString(5, memberDTO.getEmail());
        	
        	stmt.executeUpdate();
            
            
    		PrintWriter out = resp.getWriter();
    		
            resp.sendRedirect("./jsp/AddLandmark.jsp");
            
           
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
