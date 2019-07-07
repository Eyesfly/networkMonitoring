<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/31
  Time: 19:08
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/js/echarts/echarts3.min.js"></script>
    <style type="text/css">
        .child{
            width: 100%;
            padding:0px;
            margin:0px;
        }
    </style>
</head>

<body>
<div class="child">
    <div style="background: rgb(21, 78, 144);padding:10px;">
        <img src="${request.contextPath}/images/logo1.png" style="width: 500px;height: 70px;">
    </div>
    <div>
        <div class="col-xs-6 col-sm-12">
            <img src="${request.contextPath}/images/t1.png" style="width: 99%;height: 80%;">
        </div>
        <div class="col-xs-6 col-sm-12" >
            <img src="${request.contextPath}/images/t2.png" style="width: 99%;">
        </div>
    </div>

</div>

</body>
</html>