<%@include file="admin_header.jsp" %>

		<div id="content">
			<p class="title">Users</p>
			<div class="search">
				<form>
					<p>
						<select>
							<option value="name">User Name</option>
							<option value="e-mail">E-mail</option>
						</select>
						<input type="text" name="searchbox" value="" />
						<input type="button" name="search" value="Search" />
					</p>
				</form>
			</div>
			<div class="info_detail">
				<form>
					<table>
						<tr>
							<th class="tablehead">Name</th>
							<td class="tablebody"></td>
							<th class="tablehead">E-mail</th>
							<td class="tablebody"></td>
						</tr>
						<tr>
							<th class="tablehead">Date of Birth</th>
							<td class="tablebody"></td>
							<th class="tablehead">Gender</th>
							<td class="tablebody"></td>
						</tr>
						<tr>
							<th class="tablehead">Date created</th>
							<td class="tablebody"></td>
							<th class="tablehead">Date modified</th>
							<td class="tablebody"></td>
						</tr>
					</table>
					<div class="button-line">
						<input type="button" name="modify" value="Modify" />
					</div>
				</form>
			</div>
			<div class="list">
				<table>
					<tr>
						<th>Number</th>
						<th>Name</th>
						<th>E-mail</th>
						<th>Gender</th>
					</tr>
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	out.println("before try.");

	try{
		conn = DBConnector.makeConnection();
		
		request.setCharacterEncoding("utf-8");                                // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
		
//		stmt = conn.createStatement();
		String sql ="select * from user";
		stmt = conn.prepareStatement(sql);
		
		rs = stmt.executeQuery(sql);

		while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
			int i = 1;
			String name = rs.getString("name");
			String email = rs.getString("email");
			String gender = rs.getString("gender");
			Timestamp register = rs.getTimestamp("reg_date");
%>		
					<tr>
						<td><%=i %></td>
						<td><%=name %></td>
						<td><%=email %></td>
						<td><%=gender %></td>
					</tr>
<%
		}
	}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
		out.println("There is no memeber.");
		}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
		if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제�
		if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
		}
%>
					<tr>
						<td>2</td>
						<td>test name2</td>
						<td>adsf2.test.com</td>
						<td>Female</td>
					</tr>
				</table>
			</div>
		</div>
		
<%@include file="admin_footer.jsp" %>