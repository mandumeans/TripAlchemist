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

public class LoadtripServlet extends HttpServlet {
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
        PreparedStatement stmt = null;
        ResultSet selectRs = null;
		String email = null;
		String tripNum = null;
		
		if(memberDTO == null){
			
		} else {
			email = memberDTO.getEmail();
		}
		tripNum = req.getParameterValues("tripId")[0];
		
		JSONArray jArray = new JSONArray();
		
		try {
			conn = DBConnector.makeConnection();
			        	
        	String selectQuery = "SELECT mst.tripNum, title, startDat, endDat, mst.createby, seqDay, seqOrder,placeLat,placeLng,placeAddress,placeNum,placeName FROM tripalchemist.tripmst mst inner join tripalchemist.tripstep step on mst.tripNum = step.tripNum WHERE mst.tripNum = ? ORDER BY seqDay, seqOrder;";
        	stmt = conn.prepareStatement(selectQuery);  	
        	stmt.setString(1, tripNum);
        	selectRs = stmt.executeQuery();
        	
        	while(selectRs.next()){
                JSONObject obj = new JSONObject();
                obj.put("title",selectRs.getString("title"));
                obj.put("startDat",selectRs.getString("startDat"));
                obj.put("endDat",selectRs.getString("endDat"));
                obj.put("createby",selectRs.getString("createby"));
                obj.put("seqDay",selectRs.getString("seqDay"));
                obj.put("seqOrder",selectRs.getString("seqOrder"));
                obj.put("placeLat",selectRs.getString("placeLat"));
                obj.put("placeLng",selectRs.getString("placeLng"));
                obj.put("placeAddress",selectRs.getString("placeAddress"));
                obj.put("placeNum",selectRs.getString("placeNum"));
                obj.put("placeName",selectRs.getString("placeName"));
                jArray.add(obj);
            }

			PrintWriter out = resp.getWriter();
			out.print(jArray);
	        out.flush();
	        out.close();
		} catch (SQLException | ClassNotFoundException | NamingException e) {
			e.printStackTrace();
			resp.setStatus(500);
			PrintWriter out = resp.getWriter();
			out.print((new JSONObject()).put("result", "fail"));
			return;
		}
    }
}
