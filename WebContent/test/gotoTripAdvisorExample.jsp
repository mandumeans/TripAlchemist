<%@include file="headerExam.jsp" %>
	<p>Hello World!</p>
	<form name="frm" method="post" action="action/gotoTripAdvisior_action.jsp">
		<table>
			<tr>
				<td>Start Date</td>
				<td><input type="text" name="startDate" value /></td>
			</tr>
			<tr>
				<td>End Date</td>
				<td><input type="text" name="endDate" value /></td>
			</tr>
			<tr>
				<td>Location</td>
				<td><input type="text" name="location" value /></td>
			</tr>
		</table>
		<input type="submit" name="submit" value="Find" />
	</form>
	
<%@include file="footerExam.jsp" %>