<%@ page import="com.eyesfly.core.BaseUserBaseRole; com.eyesfly.core.BaseUser; com.eyesfly.dictionary.Menu" %>
<g:set var="currentUser" value="${BaseUser.findByUsername(sec.username())}"/>
<g:set var="menuItems" value="${BaseUserBaseRole.findAllByBaseUser(currentUser)?.baseRole?.menuItems?.toString().replaceAll('\\[','').replaceAll('\\]','').replaceAll(' ','').split(',')}"/>
<div class="sideTitle">后台管理系统</div>
<div class="mt20"></div>

<h3><i><img src="${request.contextPath}/images/htgl/356803.png" alt=""></i>系统管理</h3>
<ul>
    <li onclick="loadRemotePage('${request.contextPath}/baseUser/list',{},'系统管理','用户管理');"><a href="javascript:void(0);">用户管理</a></li>
    <li onclick="loadRemotePage('${request.contextPath}/baseRole/list',{},'系统管理','角色管理');"><a href="javascript:void(0);">角色管理</a></li>
    %{--<li onclick="loadRemotePage('${request.contextPath}/monitoringPlace/index',{},'系统管理','采集地址');"><a href="javascript:void(0);">采集地址</a></li>--}%
</ul>
<h3><i><img src="${request.contextPath}/images/htgl/356803.png" alt=""></i>内容管理</h3>
<ul>
    <li onclick="loadRemotePage('${request.contextPath}/news/list',{},'项目管理','');"><a href="javascript:void(0);">项目管理</a></li>
</ul>

