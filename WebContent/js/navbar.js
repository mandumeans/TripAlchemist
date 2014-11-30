/**
 * 
 */

$(document).ready(function() {

	var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp
			.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
	
	var checkin = $('#start_date').datepicker({
		onRender : function(date) {
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
		onRender : function(date) {
			return date.valueOf() < checkin.date.valueOf() ? 'disabled' :  '';
		}
	}).on('changeDate',	function(ev) {
		checkout.hide();
		var totalDays = ((checkout.date - checkin.date) / 86400000) + 1;
		$('#days').empty();
		if(totalDays > 60){
			alert('60일 이상의 여행계획은 불가능 합니다.');

			checkout.setValue(checkin.date);
			$('#days').append('(1일)');
		} else {
			$('#days').append('(' + totalDays + '일)');
		}
	}).data('datepicker');
	
}); // document.ready end