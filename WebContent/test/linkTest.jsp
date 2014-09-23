<%@include file="headerExam.jsp" %>
<script type="text/javascript">
	$(document).ready(function () {
		var nowTemp = new Date();
		var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0); 
        var checkin = $('#start_date').datepicker({
        	onRender: function(date) {
        	return date.valueOf() < now.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function(ev) {
        	if (ev.date.valueOf() > checkout.date.valueOf()) {
            	var newDate = new Date(ev.date)
                newDate.setDate(newDate.getDate() + 1);
                checkout.setValue(newDate);
            }
            checkin.hide();
            $('#end_date')[0].focus();
       }).data('datepicker');
       var checkout = $('#end_date').datepicker({
       		onRender: function(date) {
            return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
            }
       }).on('changeDate', function(ev) {
       		checkout.hide();
       }).data('datepicker');
    });
</script>
	<table>
		<tr>
			<td>Start Date</td>
			<td><input type="text" class ="form-control" data-date-format="yyyy-mm-dd" placeholder="Starting Date"  id="start_date" name="startDateJ" value /></td>
		</tr>
		<tr>
			<td>End Date</td>
			<td><input type="text" class ="form-control" data-date-format="yyyy-mm-dd" placeholder="Ending Date" id="end_date" name="endDateJ" value /></td>
		</tr>
		<tr>
			<td>Location</td>
			<td><input type="text" name="locationJ" id="location" value /></td>
		</tr>
	</table>
	<input type="button" name="find" value="Find Place" onclick="bnbFunction()"/>
	<script>
	function bnbFunction(){
		var startDate = document.getElementById("start_date").value;
		var endDate = document.getElementById("end_date").value;
		var loc = document.getElementById("location").value;

		console.log(startDate);
		console.log(endDate);
		console.log(loc);
		location.replace("https://www.airbnb.com/s/"+loc+"?checkin="+startDate+"&checkout="+endDate+"&source=bb")
	}
	</script>
<%@include file="footerExam.jsp" %>