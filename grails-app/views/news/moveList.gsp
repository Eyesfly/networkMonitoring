<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/13
  Time: 10:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!request.xhr}">
        <meta name="layout" content="main">
    </g:if>
    <style type="text/css">
    .video-list-btn{
        padding-bottom: 20px;
    }
    </style>
</head>

<body>
<iframe frameborder="0" scrolling="no" src="http://192.168.137.168:8028/powercms/api/ContentApi-httpUpload.action?userName=${sec.username()}&token=ucap&categoryUstr=amjei_0&returnType=cflash" style="width: 100%;height:950px;"></iframe>
</body>
</html>