package member.dto;

import java.sql.*;
import java.util.Vector;
import com.ta.web.DBConnector;
import member.dto.LandmarkList;;

public class LandmarkDao {
	Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs =null;
    
    public void conn(){
    	try{
    		conn = DBConnector.makeConnection();
    	}
    	catch(Exception e){
    		e.printStackTrace();
    		
    	}
    }
    public Vector<LandmarkList> getAllLandmark(){
    	  Vector<LandmarkList> vector = new Vector<>();
    	  LandmarkList bean;
    	
    	  try {
    	   // 커넥션 연결
    		
    	   this.conn();
    	   // 쿼리 준비
    	 
    	   String sql = "SELECT landmarkNum, name, address, lat, lng, likes, createby FROM tripalchemist.landmark ORDER BY createdat desc";
    	   // 쿼리 실행
    	   stmt = conn.prepareStatement(sql);
    	   // 쿼리 실행후 결과를 resultset이 받아줌
    	   rs =stmt.executeQuery();
    	   // 반복문을 이용하여 데이터를 빈클래스에 담은후에 그빈 클래스를 백터에 저장
    	   while(rs.next()){
    	    bean = new LandmarkList();
    	    bean.setLandmarkNum(rs.getInt(1));
    	    bean.setName(rs.getString(2));
    	    bean.setAddress(rs.getString(3));
    	    bean.setLat(rs.getFloat(4));
    	    bean.setLng(rs.getFloat(5));
    	    bean.setCreateby(rs.getString(6));
    	    
    	    // 빈클래스에 담은 데이터를 백터에 추가
    	    vector.add(bean);
    	   }   
    	   conn.close();
    	   stmt.close();
    	   rs.close();
    	  } catch (Exception e) {
    	   e.printStackTrace();
    	  }  
    	  return vector;
    }

  	  	
}
