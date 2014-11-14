package com.ta.web;

import java.io.IOException;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

import java.sql.SQLException;
import java.sql.Connection;

import java.sql.PreparedStatement;

import com.ta.web.DBConnector;

import member.dto.MemberDTO;

@WebServlet("/Update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Update() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String DOB =request.getParameter("DOB");
		String password = request.getParameter("password");
		
		response.setContentType("text/plain;charset=UTF-8");
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String query ="update user set name=?, gender =?, DOB =?, password=? where email =?";     
        
        HttpSession httpSession = request.getSession();
        MemberDTO memberDTO = (MemberDTO)httpSession.getAttribute("memberDTO");
        if(memberDTO != null){
        	try{
        		try { 
        		conn = DBConnector.makeConnection();
        		request.setCharacterEncoding("utf-8");
        		
        		pstmt = conn.prepareStatement(query);
        		pstmt.setString(1, name);
        		pstmt.setString(2, gender);
        		pstmt.setString(3, DOB);
        		pstmt.setString(4, password);
        		
        		pstmt.executeUpdate();
        		
        		memberDTO = new MemberDTO(memberDTO.getEmail(), password, name, gender,DOB);
        		httpSession.setAttribute("memberDTO", memberDTO);
        		
        		 response.sendRedirect("./jsp/myprofile.jsp");
        		} catch (ClassNotFoundException e) {
    				
    				e.printStackTrace();
    			} catch (NamingException e) {
    				e.printStackTrace();
    			}     
        		}
        		catch(SQLException e){
        			e.printStackTrace();
        		}finally{        
        			if(pstmt != null){
        				try{
        					pstmt.close();
        				}catch(SQLException e){
        					e.printStackTrace();
        				}
        			}
        			if(conn != null){
        				try{
        					conn.close();
        				}catch(SQLException e){
        					e.printStackTrace();
        				}
        			}
        		}
        		
        	       
	}
	}
}

