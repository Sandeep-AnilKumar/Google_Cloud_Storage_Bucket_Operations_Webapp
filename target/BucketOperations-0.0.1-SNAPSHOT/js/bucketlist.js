$('#warning-modal').on(
		'show.bs.modal',
		function(e) {
			var $id = e.relatedTarget.id;
			$('#message-fileName').html(
					"Are you sure you want to delete '" + $id + "' file?");
			var $modal = $(this);
			$modal.find('#deleteMe').val($id);
		});
$('#deleteMe').on('click', function(e) {
	$.ajax({
		cache : false,
		type : 'POST',
		url : '/BucketOperations/delete.jsp',
		data : 'fileName=' + $('#deleteMe').val(),
		success : function(data) {
			$('#warning-modal').modal('hide');
			$('#success-message').html(data);
			$('#success-modal').modal('show');
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(textStatus, errorThrown);
		}
	});
});
$('.download-button').on('click', function(e) {
	e.preventDefault();
	var x = $(this).val();
	$.ajax({
		cache : false,
		type : 'GET',
		url : '/BucketOperations/download-item.jsp',
		data : 'fileName=' + x,
		success : function(data) {
			$('#success-message').html(data);
			$('#success-modal').modal('show');
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(textStatus, errorThrown);
		}
	});
});