<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="js/bootstrap-filestyle.min.js"></script>
<title>Upload a file to Bucket</title>
</head>
<body>
    <br>
    <div style="text-align: center">
        <h2>
            Cloud Data Operations Book<br> <br>
        </h2>
    </div>
    <div style="margin-left: 5%;">
        <a href="/BucketOperations/">
            <button type="button" class="btn btn-primary" style="margin-bottom: 1%;">
                <span class="glyphicon glyphicon-home"> </span>
                &nbsp; Home
            </button>
        </a>
        <div id="messages" class="hide" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            <div id="messages_content"></div>
        </div>
        <form id="uploadForm" method="post" action="javascript:;"
            enctype="multipart/form-data">
            <div style="width: 65%; float: left;">
                <input type="file" class="filestyle" data-buttonText="Find file" data-buttonBefore="true"
                    data-placeholder="No file chosen" name="uploadFile" id="chosenFile" data-name="uploadFile">
            </div>
            <input type="hidden" name="fileName" id="fileName" value="" />
            <button class="btn btn-warning uploadButton" type="submit" style="float: left; margin-left: 1%">
                <span class="glyphicon glyphicon-cloud-upload"></span>
                &nbsp; Upload File
            </button>
        </form>
    </div>
    <!-- Success Modal -->
    <div id="success-modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header alert alert-success">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Success !!</h4>
                </div>
                <div class="modal-body">
                    <p id="success-message"></p>
                </div>
                <div class="modal-footer">
                    <a href="/BucketOperations/"><button type="button" class="btn btn-success">Close</button></a>
                </div>
            </div>
        </div>
    </div>
    <!-- Delete Modal -->
    <div id="warning-modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header alert alert-danger">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">WARNING!</h4>
                </div>
                <div class="modal-body">
                    <p id="message-fileName"></p>
                </div>
                <div class="modal-footer">
                    <a href="/BucketOperations/">
                        <button type="button" class="btn btn-success">Close</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	$('.uploadButton').on('click', function(e) {
		$('#fileName').val($('#chosenFile').val());
	});

	$('#uploadForm').submit(function(e) {
		e.preventDefault();
        var fd = new FormData();
        fd.append('fileName', $('#fileName').val());
        fd.append('uploadFile', $('#chosenFile').get(0).files[0]);
		$.ajax({
			cache : false,
			type : 'POST',
			processData: false, 
            contentType: false,
			url : '/BucketOperations/upload-normal-file.jsp',
			data : fd,
			success : function(data) {
				$('#success-message').html(data);
				$('#success-modal').modal('show');
			},
			error : function(jqXHR, textStatus, errorThrown) {
				$('#message-fileName').html("Error Uploading file");
				$('#warning-modal').modal('show');
				console.log(textStatus, errorThrown);
			}
		});
	});
</script>
</html>