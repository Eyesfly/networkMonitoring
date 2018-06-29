<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!request.xhr}">
        <meta name="layout" content="center">
    </g:if>
</head>
<body>
<div class="wdxx">
    <span>我的信息</span>
</div>
<div class="pad20">
    <ul>
        <li class="to">
            <span class="tx">头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像：</span>
            <g:if test="${user.aviator}">
                <img src="${request.contextPath}/baseUser/userAviator" class="zxz"/>
            </g:if>
            <g:else>
                <img src="${request.contextPath}/images/grzx/nouser.jpg" class="zxz" />
            </g:else>
            <a href="javascript:void(0);" data-toggle="modal" data-target="#aviatorModal">修改头像</a>
            <div class="clear"></div>
        </li>
        <li>
            <span class="tx">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</span>
            <span class="dz">${user?.realName}</span>
        </li>
        <li>
            <span class="tx">身份证号：</span>
            <span class="dz">${user?.idCard}</span>
        </li>
        <li>
            <span class="tx">手机号码：</span>
            <span class="dz">${user?.mobile}</span>
        </li>
        <li>
            <span class="tx">法律身份：</span>
            <span class="dz">${user?.identity?.name}</span>
        </li>
        <li>
            <span class="tx">工作单位：</span>
            <span class="dz">${user?.ascripteOrg?.name}</span>
        </li>
        <li>
            <span class="tx">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务：</span>
            <span class="dz">${user?.duty}</span>
        </li>
    </ul>
    <div class="tix1">
        <a href="${request.contextPath}/baseUser/infoEdit"><i></i>修改</a>
    </div>

</div>
</body>
</html>
