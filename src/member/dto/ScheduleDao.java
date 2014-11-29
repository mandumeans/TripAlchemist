/*package member.dto;

import java.sql.*;
import java.util.Vector;
import com.ta.web.DBConnector;
import member.dto.MemberDTO;


public class ScheduleDao {
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
    public Vector<ScheduleList> getAllBoard(){
    	  Vector<ScheduleList> vector = new Vector<>();
    	  ScheduleList bean;
    	
    	  try {
    	   // 커넥션 연결
    		
    	   this.conn();
    	   // 쿼리 준비
    	 
    	   String sql = "select title,startDat, endDat,createdat, createby from tripmst";
    	   // 쿼리 실행
    	   stmt = conn.prepareStatement(sql);
    	   // 쿼리 실행후 결과를 resultset이 받아줌
    	   rs =stmt.executeQuery();
    	   // 반복문을 이용하여 데이터를 빈클래스에 담은후에 그빈 클래스를 백터에 저장
    	   while(rs.next()){
    	    bean = new ScheduleList();
    	    bean.setTitle(rs.getString(1));
    	    bean.setStartDat(rs.getString(2));
    	    bean.setEndDat(rs.getString(3));
    	    bean.setCreatedat(rs.getString(4));
    	    bean.setCreateby(rs.getString(5));
    	    
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
    public ViewBean getDetail(int tripNum) throws Exception{
    	ViewBean board = null;
    	try{
    		this.conn();
    		String query = "select * from tripstep where = tripNum";
     	    stmt = conn.prepareStatement(query);
     	    stmt.setInt(1, tripNum);
     	    rs =stmt.executeQuery();
     	    
     	    if(rs.next()){
     	    	board = new ViewBean();
     	    	
     	    	board.setStepNum(rs.getInt(1));
     	    	board.setSeqOrder(rs.getString(2));
     	    	board.setSeqDay(rs.getString(3));
     	    	board.setPlaceNum(rs.getInt(4));
     	    	board.setCreateby(rs.getString(5));
     	    	board.setCreatedat(rs.getString(6));
     	    	board.setHotelNum(rs.getInt(7));
     	    	board.setHotelRoomNum(rs.getInt(8));
     	    	board.setModifyby(rs.getString(9));
     	    	board.setModifydat(rs.getString(10));
     	    	board.setPlaceLat(rs.getFloat(11));
     	    	board.setPlaceLng(rs.getFloat(12));
     	    	board.setPlaceAddress(rs.getString(13));
     	    	board.setPlaceName(rs.getString(14));
     	    	
     	    }
     	    return board;
    	}catch(Exception ex){
    		System.out.println("error" +ex);
    	}finally{
    		if(rs != null)try{rs.close();}catch(SQLException ex){}
    		if(stmt !=null)try{stmt.close();} catch(SQLException ex){}
    		if(conn != null)try{conn.close();}catch(SQLException ex){}    		
    	}
    }
  	  
	
}*/
