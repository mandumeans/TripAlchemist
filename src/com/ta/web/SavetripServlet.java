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

public class SavetripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
    }
	
	@SuppressWarnings("unchecked")
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json;charset=UTF-8");
		req.setCharacterEncoding("utf-8");
		MemberDTO memberDTO =(MemberDTO)req.getSession().getAttribute("member_info");
		Connection conn = null;
        Statement normalStmt = null;
        PreparedStatement stmt = null;
        ResultSet selectRs = null;
        
		String title = null;
		String email = null;
		String sDate = null;
		String eDate = null;
		String resUrl = null;
		String tripNum = null;
		
		if(memberDTO == null){
//			req.setAttribute("error_message", "로그인을 해주세요.");
//			resUrl ="./jsp/login.jsp";
//			RequestDispatcher requestDispatcher = req.getRequestDispatcher(resUrl);
//			requestDispatcher.forward(req, resp);
//			return;
		} else {
			title = URLDecoder.decode(req.getParameterValues("title")[0], "UTF-8");
			email = memberDTO.getEmail();
			sDate = req.getParameterValues("sDate")[0];
			eDate = req.getParameterValues("eDate")[0];
		}
		System.out.println("Value : " + email + " / " + sDate + " / " + eDate);
		
		JSONParser parser = new JSONParser();
		
		JSONArray jArray;
		
		try {
			conn = DBConnector.makeConnection();
			//normalStmt = conn.createStatement();
			//String UTFQuery = "SET NAMES utf8;SET collation_connection = 'utf8_general_ci';SET default-character-set = utf8;SET default-character-set = 'utf8';SET character_set_server =  'utf8';";
			//normalStmt.execute(UTFQuery);
			
            String mstQuery = "INSERT INTO `tripalchemist`.`tripmst`(`title`,`startDat`,`endDat`,`description`,`public`,`createdat`,`modifydat`,`createby`,`modifyby`)"
            												+ "VALUES(?,?,?,?,?,NOW(),NOW(),?,'');";	            
        	stmt = conn.prepareStatement(mstQuery);	        	
			stmt.setString(1, title);
			stmt.setString(2, sDate);
			stmt.setString(3, eDate);
			stmt.setString(4, "");
        	stmt.setString(5, "Y");
        	stmt.setString(6, email);		        	
        	stmt.executeUpdate();
        	
        	String selectQuery = "SELECT * FROM `tripalchemist`.`tripmst` WHERE createby = ? ORDER BY createdat desc;";
        	stmt = conn.prepareStatement(selectQuery);  	
        	stmt.setString(1, email);
        	selectRs = stmt.executeQuery();
        	
        	if(selectRs.next()){
                JSONObject obj = new JSONObject();
                tripNum = selectRs.getString("tripNum");
            }

    		System.out.println(req.getParameter("myData"));
			jArray = (JSONArray)parser.parse(req.getParameter("myData"));
			Iterator<JSONObject> it = jArray.iterator();
			while (it.hasNext()) {
				JSONObject jObject = it.next();
				Long day = (Long) jObject.get("day");
				Long order = (Long) jObject.get("order");
				Double lat = (Double) jObject.get("lat");
				Double lng = (Double) jObject.get("lng");
				String address = URLDecoder.decode((String) jObject.get("address"), "UTF-8");
				String name = URLDecoder.decode((String) jObject.get("name"), "UTF-8");
				String type = (String) jObject.get("type");
				String hotelNum = (String) jObject.get("hotelNum");
				String hotelRoomNum = (String) jObject.get("hotelRoomNum");
				String stepQuery = null;
				System.out.println("Value2 : " + address + " / " + name);
				if (hotelNum.equals("") || hotelRoomNum.equals("")){
					//no reservation
					stepQuery = "INSERT INTO `tripalchemist`.`tripstep`(`tripNum`,`seqDay`,`seqOrder`,`placeNum`,`placeName`,`placeLat`,`placeLng`,`placeAddress`,`createby`,`modifyby`)"
							+ "VALUES(?,?,?,?,?,?,?,?,?,'');";	   
					stmt = conn.prepareStatement(stepQuery);	
					stmt.setString(1, tripNum);	     	
					stmt.setString(2, day.toString());	
					stmt.setString(3, order.toString());
					stmt.setInt(4, Integer.parseInt(type.equals("")?"0":type));
					stmt.setString(5, name);
					stmt.setString(6, lat.toString());
					stmt.setString(7, lng.toString());	
					stmt.setString(8, address);	
					stmt.setString(9, email);		  
				} else {
					//reservation
					stepQuery = "INSERT INTO `tripalchemist`.`tripstep`(`tripNum`,`seqDay`,`seqOrder`,`placeNum`,`placeName`,`placeLat`,`placeLng`,`placeAddress`,`hotelNum`,`hotelRoomNum`,`createby`,`modifyby`)"
							+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,'');";	   
					stmt = conn.prepareStatement(stepQuery);	
					stmt.setString(1, tripNum);	     	
					stmt.setString(2, day.toString());	
					stmt.setString(3, order.toString());
					stmt.setInt(4, Integer.parseInt(type.equals("")?"0":type));
					stmt.setString(5, name);
					stmt.setString(6, lat.toString());
					stmt.setString(7, lng.toString());	
					stmt.setString(8, address);	
					stmt.setInt(9, Integer.parseInt(hotelNum));	
					stmt.setInt(10, Integer.parseInt(hotelRoomNum));	
					stmt.setString(11, email);		  
				}
				stmt.executeUpdate();
						
			}

			PrintWriter out = resp.getWriter();
			out.print((new JSONArray()).add((new JSONObject()).put("result", "success")));
	        
	        out.flush();
	        out.close();
		} catch (SQLException | ClassNotFoundException | NamingException | ParseException e) {
			e.printStackTrace();
			resp.setStatus(500);
			PrintWriter out = resp.getWriter();
			out.print((new JSONArray()).add((new JSONObject()).put("result", "fail")));
			return;
		}
    }
}
