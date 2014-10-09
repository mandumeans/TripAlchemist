<%@include file="admin_header.jsp" %>

		<div id="content">
			<p class="title">Hotels</p>
			<div class="search">
				<form>
					<p>					
						<select>
							<option value="name">Hotel Name</option>
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
							<th class="tablehead">Hotel Name</th>
							<td class="tablebody"></td>
							<th class="tablehead">Address</th>
							<td class="tablebody"></td>
						</tr>
						<tr>
							<th class="tablehead">latitude</th>
							<td class="tablebody"></td>
							<th class="tablehead">longitude</th>
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
						<th>address</th>
						<th>latitude</th>
						<th>longitude</th>
					</tr>
					<tr>
						<td>1</td>
						<td>test name</td>
						<td>address example</td>
						<td>latitude example</td>
						<td>longitude example</td>
					</tr>
					<tr>
						<td>2</td>
						<td>test name2</td>
						<td>address example2</td>
						<td>latitude example2</td>
						<td>longitude example2</td>
					</tr>
				</table>
			</div>
		</div>
		
<%@include file="admin_footer.jsp" %>