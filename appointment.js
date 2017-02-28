$(document).ready((function(){
	getAppointments();
	btnSwitch();
	  
	$("#btnNewAppointment").click(function(){
		$("#btnAddAppointment").show();
 		$("#btnCancelAppointment").show();
		$("#appointmentForm").show();
		$("#btnNewAppointment").hide();						   
	});
  
	$("#btnCancelAppointment").click(function(){
		btnSwitch();
		$("#btnNewAppointment").show();						   
	});
	
	$("#btnSearchAppointment").click(function(){
		var search=$("#appointmentSearch").val();
		$.ajax('http://localhost/AppointmentSystemATT/search.pl?search='+search,{
			"type": "GET", 
			dataType:"JSON",		
			"data": '',
			"success":loadOnSuccess,
			"error":failure
		});
	});
  
	$('.datepicker').datepicker({
		format: 'mm/dd/yyyy',
		startDate: '-1d',
		todayHighlight: true,
        autoclose: true,
	});
	
	$('#appointmentTime').timepicker();
}));

function btnSwitch(){
	$("#btnAddAppointment").hide();
	$("#btnCancelAppointment").hide();
	$("#appointmentForm").hide();
};

function getAppointments(){
	$.ajax('http://localhost/AppointmentSystemATT/select.pl',{
		"type": "GET", 
		dataType:"JSON",		
		"data": '',
		"success":loadOnSuccess,
		"error":failure
	});
}

function loadOnSuccess(data){
	if(data.length==0){
		failure();
	}
	else { 
		var tableData='<table border="1" class=""table table-hover""><tr><td colspan="3" align="center"><strong>Appointment Table</strong></td></tr>';
			tableData+='<tr><th>Appointment Date</th><th>Appointment Time </th><th>Description</th></tr>';		
			$.each(data,function(index,item){
				var datetime = data[index].datetime.split(' ');
				tableData+='<tr>';
				tableData+='<td>'+datetime[0]+'</td>';
				tableData+='<td>'+datetime[1]+'</td>';
				tableData+='<td>'+item.description+'</td>';
				tableData+='</tr>';
			});
	tableData+='</table>';
	$('#displayAppointment').html(tableData);
  }
}

function failure(){
	var noDataError='No Appointment scheduled in the System. Please Enter Appointment/s';		
	$('#displayAppointment').html(noDataError);
}