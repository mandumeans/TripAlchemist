package com.ta.web;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Enumeration;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ta.web.DBConnector;

public class RecommandServlet extends HttpServlet {
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
		float lat = 37.549852F;
		float lng = 126.992038F;
		String latitude = req.getParameter("lat");
		String longitude = req.getParameter("lng");
		String theDay = req.getParameter("theDay");//	YYYY/MM/DD format
		try{
		lat = Float.parseFloat(latitude);
		lng = Float.parseFloat(longitude);
		} catch(NullPointerException e){
			e.printStackTrace();
		}
        Connection conn = null;
        CallableStatement cStmt = null;
        ResultSet rs = null;
     
        try{
        	conn = DBConnector.makeConnection();
            cStmt = conn.prepareCall("{call hotelRecommendation(?, ?, ?)}");
            cStmt.setFloat(1, lat);
            cStmt.setFloat(2, lng);
            cStmt.setString(3, theDay);
            boolean result = cStmt.execute();
			PrintWriter out = resp.getWriter();
			JSONArray ja = new JSONArray();
            while(result){
            	rs = cStmt.getResultSet();
				while (rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("hotelNum", rs.getString("hotelNum"));
					obj.put("hotelRoomNum", rs.getString("hotelRoomNum"));
					obj.put("rank", rs.getString("rankSum"));
					obj.put("name", rs.getString("hotelName"));
					obj.put("roomName", rs.getString("hotelRoomName"));
					obj.put("price", rs.getString("hotelPrice"));
					obj.put("rate", rs.getString("hotelRate"));
					obj.put("address", rs.getString("hotelAddress"));
					obj.put("lat", rs.getString("hotelLat"));
					obj.put("lng", rs.getString("hotelLng"));
					ja.add(obj);
				}
            	
            	result = cStmt.getMoreResults();
            }

			out.print(ja);
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
