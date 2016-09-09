<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<title>Bucket Item's list</title>
</head>
<body>
    <br>
    <div style="text-align: center">
        <h2>
            Cloud Data Operations Book<br> <br>
        </h2>
    </div>
    <div style="width: 80%; margin-left: 5%">
        <a href="/BucketOperations/">
            <button type="button" class="btn btn-primary">
                <span class="glyphicon glyphicon-home"> </span>
                &nbsp; Home
            </button>
        </a>
        <c:choose>
            <c:when test="${message ne null}">
                <h3>
                    Bucket listing for: -
                    <span style="font-weight: bold; font-style: italic; color: #4099FF;">
                        <c:out value="${bucketName}" />
                    </span>
                </h3>
                <table class="table table-hover table-responsive table-bordered">
                    <thead>
                        <tr class="info">
                            <th>Name</th>
                            <th>Size (in Bytes)</th>
                            <th>Type</th>
                            <th>Last Modified</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <c:forEach var="items" items="${itemsList}">
                        <tbody>
                            <tr>
                                <td><c:out value="${items.fileName}" /></td>
                                <td><c:out value="${items.size}" /></td>
                                <td><c:out value="${items.type}" /></td>
                                <td><c:out value="${items.lastModified}" /></td>
                                <td><button type="button" class="btn btn-danger" data-toggle="modal"
                                        data-target="#warning-modal" id="<c:out value="${items.fileName}" />">
                                        <span class="glyphicon glyphicon-remove"></span>
                                        &nbsp; Delete
                                    </button>
                                    <button type="submit" class="btn btn-success download-button"
                                        value="<c:out value="${items.fileName}" />">
                                        <span class="glyphicon glyphicon-cloud-download"></span>
                                        &nbsp; Download
                                    </button></td>
                            </tr>
                        </tbody>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <br>
                <h2>There is no such bucket or you do not have access to this bucket.</h2>
            </c:otherwise>
        </c:choose>
        <c:out value="${map.msg}"></c:out>
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
                    <button type="button" class="btn btn-success" data-dismiss="modal">No! I want to go back</button>
                    <button type="submit" class="btn btn-danger" id="deleteMe" value="">
                        <span class="glyphicon glyphicon-remove"> </span>
                        &nbsp; Yes! Delete it
                    </button>
                </div>
            </div>

        </div>
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
</body>
<script type="text/javascript" src="js/bucketlist.js"></script>
</html>