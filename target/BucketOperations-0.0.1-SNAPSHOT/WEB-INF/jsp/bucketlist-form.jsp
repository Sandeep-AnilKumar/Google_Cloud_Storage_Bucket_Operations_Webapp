<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<title>Bucket List Form</title>
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
        <form method="post" action="/BucketOperations/bucketlist.jsp">
            <input type="text" name="bucket-name" class="form-control" style="width: 50%; float: left"
                placeholder="Enter the name of the bucket to list the items: " required />
            <button class="btn btn-primary" type="submit" style="float: left; margin-left: 1%">
                <span class="glyphicon glyphicon-cloud"></span>
                <span class="glyphicon glyphicon-search"></span>
                &nbsp; Get the list of items
            </button>
        </form>
    </div>
</body>
</html>