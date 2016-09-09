<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<title>Bucket Operations</title>
</head>
<body>
    <br>
    <div style="text-align: center">
        <h2>
            Cloud Data Operations Book<br> <br>
        </h2>
    </div>
    <div align="center" style="margin: 1%;">
        <a href="/BucketOperations/bucketlist-form.jsp">
            <button class="btn btn-primary" type="button">
                <span class="glyphicon glyphicon-cloud"></span>
                <span class="glyphicon glyphicon-search"></span>
                &nbsp; Get the bucket items
            </button>
        </a>
    </div>
    <div align="center" style="margin: 1%;">
        <a href="/BucketOperations/upload-file.jsp">
            <button style="color: #272727" class="btn btn-warning" type="button">
                <span class="glyphicon glyphicon-cloud-upload"></span>
                &nbsp; Upload a file to cloud
            </button>
        </a>
    </div>
    <div align="center" style="margin: 1%;">
        <button style="color: #000000" class="btn btn-success disabled" type="button">
            <span class="glyphicon glyphicon-cloud-upload"></span>
            &nbsp; Upload a file to cloud (Resumable)
        </button>
    </div>
</body>
</html>