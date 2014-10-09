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
						<input type="text" name="searchbox" value />
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
					<tr>
						<td>1</td>
						<td>test name</td>
						<td>adsf.test.com</td>
						<td>Male</td>
					</tr>
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