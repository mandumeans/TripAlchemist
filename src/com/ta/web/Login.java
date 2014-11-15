package com.ta.web;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.IOException;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

import member.dto.MemberDTO;

import com.ta.web.DBConnector;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;  
    public Login() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");	
		String password = request.getParameter("password");
		
		response.setContentType("text/html;utf-8");		
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String sql ="select email, password, name, gender, DOB from user where email =?";
		String resUrl = null;
		
		try{
			try {
				conn = DBConnector.makeConnection();
				request.setCharacterEncoding("utf-8");
	        	
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, email);
				res = pstmt.executeQuery();
				if(res.next()){
					if(res.getString(2).equals(password)){
						HttpSession httpSession = request.getSession();
						MemberDTO memberDTO = new MemberDTO(email,password,res.getString(3),res.getString(4),res.getString(5));
						httpSession.setAttribute("member_info", memberDTO);
						response.sendRedirect("./jsp/main.jsp");
					}else{
						request.setAttribute("error_message", "비밀번호가 틀리다");
						resUrl ="./jsp/login.jsp";
					}
				}else{
					request.setAttribute("error_message", email+"는 없는 아이디이다.");
					resUrl ="./jsp/login.jsp";
				}
			} catch (ClassNotFoundException e) {
				
				e.printStackTrace();
			} catch (NamingException e) {
				e.printStackTrace();
			}        	
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(res != null){
				try{
					res.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
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
		if(resUrl != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(resUrl);
			requestDispatcher.forward(request, response);
		}
	}		
}
