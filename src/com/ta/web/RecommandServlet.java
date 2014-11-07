package com.ta.web;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

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
		float lat = 37.46831856835604F;
		float lng = 37.46831856835604F;
		String latitude = req.getParameter("lat");
		String longitude = req.getParameter("lng");
		try{
		//lat = Float.parseFloat(latitude);
		//lng = Float.parseFloat(longitude);
		} catch(NullPointerException e){
			e.printStackTrace();
		}
        Connection conn = null;
        CallableStatement cStmt = null;
        ResultSet rs = null;
        
        try{
        	conn = DBConnector.makeConnection();
            cStmt = conn.prepareCall("{call hotelRecommendation(?, ?)}");
            cStmt.setFloat(1, lat);
            cStmt.setFloat(2, lng);
            boolean result = cStmt.execute();
			PrintWriter out = resp.getWriter();
			JSONArray ja = new JSONArray();
            while(result){
            	rs = cStmt.getResultSet();
				while (rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("name", rs.getString("name"));
					obj.put("address", rs.getString("address"));
					obj.put("lat", rs.getString("lat"));
					obj.put("lng", rs.getString("lng"));
					ja.add(obj);
				}
            	
            	result = cStmt.getMoreResults();
            }

//			PrintWriter out = resp.getWriter();
//			JSONArray ja = new JSONArray();
//			while (rs.next()) {
//				JSONObject obj = new JSONObject();
//				obj.put("name", rs.getString("name"));
//				obj.put("address", rs.getString("address"));
//				obj.put("lat", rs.getString("lat"));
//				obj.put("lng", rs.getString("lng"));
//				ja.add(obj);
//			}
//            out.print(ja);
//            out.flush();
//            out.close();    
        } catch(SQLException e){
			e.printStackTrace();
        } catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		}
    }
}
