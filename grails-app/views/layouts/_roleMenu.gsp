<%@ page import="com.eyesfly.core.BaseUserBaseRole; com.eyesfly.core.BaseUser; com.eyesfly.dictionary.Menu" %>
<g:set var="currentUser" value="${BaseUser.findByUsername(sec.username())}"/>
<g:set var="menuItems" value="${BaseUserBaseRole.findAllByBaseUser(currentUser)?.baseRole?.menuItems?.toString().replaceAll('\\[','').replaceAll('\\]','').replaceAll(' ','').split(',')}"/>
<div class="sideTitle">后台管理系统</div>
<div class="mt20"></div>
%{--<g:each in="${Menu.findAllByMenuIsNullAndVisible(true)}" var="pm" status="index">
    <g:set var="needShow" value="false"/>
    <g:each in="${pm.children}" var="pc">
        <g:if test="${pc.id.toString() in menuItems}">
            <g:set var="needShow" value="true"/>
        </g:if>
    </g:each>
    <g:if test="${pm.id.toString() in menuItems || needShow.equals('true')}">
        <h3><i><img src="${request.contextPath}/images/htgl/35680${index+1}.png" alt=""></i>
            <a href="javascript:void(0);"
                <g:if test="${pm.link}"> onclick="loadRemotePage('${request.contextPath}${pm.link}',{},'${pm.name}');"</g:if>>
                ${pm.name}
            </a>
        </h3>
        <g:if test="${!pm.children.isEmpty()}">
            <ul>
                <g:each in="${pm.children.findAll{it.visible == true}}" var="cm">
                    <g:if test="${cm.id.toString() in menuItems && cm.visible}">
                        <li onclick="loadRemotePage('${request.contextPath}${cm.link}',{},'${pm.name}','${cm.name}');" ><a href="javascript: void(0);">${cm.name}</a></li>
                    </g:if>
                </g:each>
            </ul>
        </g:if>
    </g:if>
</g:each>--}%
%{--<h3><i><img src="${request.contextPath}/images/htgl/356801.png" alt=""></i><a href="javascript://"
     onclick="loadRemotePage('${request.contextPath}/suggestion/list',{},'意见建议箱');">意见建议箱</a></h3>
<h3><i><img src="${request.contextPath}/images/htgl/356802.png" alt=""></i>内容管理</h3>
<ul>
    <li onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=1',{},'内容管理','要闻推送');" ><a href="javascript: void(0);">要闻推送</a></li>
    <li onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=2',{},'内容管理','法律政策');" ><a href="javascript: void(0);">法律政策</a></li>
</ul>--}%
<h3><i><img src="${request.contextPath}/images/htgl/356803.png" alt=""></i>系统管理</h3>
<ul>
    <li onclick="loadRemotePage('${request.contextPath}/baseUser/list',{},'系统管理','用户管理');"><a href="javascript:void(0);">用户管理</a></li>
    <li onclick="loadRemotePage('${request.contextPath}/baseRole/list',{},'系统管理','角色管理');"><a href="javascript:void(0);">角色管理</a></li>
    <li onclick="loadRemotePage('${request.contextPath}/monitoringPlace/index',{},'系统管理','采集地址');"><a href="javascript:void(0);">采集地址</a></li>
</ul>
%{--
<h3><i><img src="${request.contextPath}/images/htgl/356804.png" alt=""></i>统计分析</h3>
<ul>
    <li><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/statisticalAnalysis/index',{},'统计分析','概览');" >概览</a></li>
    <li><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/statisticalAnalysis/questionCount',{},'统计分析','咨询问题统计');">咨询问题统计</a></li>
    <li><a href="">问题解答统计</a></li>
    <li><a href="">答复质量统计</a></li>
    <li><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/statisticalAnalysis/onLineCount',{},'统计分析','活跃度统计');">活跃度统计</a></li>
</ul>
<h3><i><img src="${request.contextPath}/images/htgl/356805.png" alt=""></i>大数据</h3>
--}%

%{--
<ul>
    <li class="li1">
        <a>服务预警</a><i></i>
        <dl style="display: none;">
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/serviceCategory/index');" style="background-image: none;">预警设置</a></dt>
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/holiday/index');" style="background-image: none;">工作日设定</a></dt>
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/conditions/index');" style="background-image: none;">条件设定</a></dt>
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/baseRole/index');" style="background-image: none;">服务预警</a></dt>
        </dl>
    </li>
    <li class="li1">
        <a>系统管理</a><i></i>
        <dl style="display: none;">
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/menu/index');" style="background-image: none;">菜单管理</a></dt>
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/baseRole/index');" style="background-image: none;">角色管理</a></dt>
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/baseUser/index');" style="background-image: none;">用户管理</a></dt>
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/organization/index');" style="background-image: none;">机构管理</a></dt>
            <dt class=""><a href="javascript:void(0);" onclick="loadRemotePage('${request.contextPath}/menu/sensitiveWord');" style="background-image: none;">敏感词</a></dt>
        </dl>
    </li>
    <li class="li1">
        <a>信息发布</a><i></i>
        <dl style="display: none;">
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=1');" style="background-image: none;">法律咨询</a></dt>
<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=2');" style="background-image: none;">工作动态</a></dt>

<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=3');" style="background-image: none;">政策支持</a></dt>

<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=4');" style="background-image: none;">业务需求</a></dt>

<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=5');" style="background-image: none;">人员供给</a></dt>

        </dl>
    </li>
    <li class="li1">
        <a>检务咨询</a><i></i>
        <dl style="display: none;">
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/question/index');" style="background-image: none;">我要提问</a></dt>
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/question/myQuestion?status=${'待审核'.encodeAsURL()}');" style="background-image: none;">待审阅</a></dt>
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/question/myQuestion?status=${'待解答'.encodeAsURL()}');" style="background-image: none;">未解答</a></dt>
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/question/myQuestion?status=${'不合格'.encodeAsURL()}');" style="background-image: none;">不合格</a></dt>
<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=2');" style="background-image: none;">工作动态</a></dt>

<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=3');" style="background-image: none;">政策支持</a></dt>

<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=4');" style="background-image: none;">业务需求</a></dt>

<dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/news/list?categoryId=5');" style="background-image: none;">人员供给</a></dt>

        </dl>
    </li>
    <li class="li1">
        <a>意见建议</a><i></i>
        <dl style="display: none;">
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/suggestion/create');" style="background-image: none;">我要建议</a></dt>
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/suggestion/mySuggestion');" style="background-image: none;">我的建议</a></dt>
        </dl>
    </li>
    <li class="li1">
        <a>统计分析</a><i></i>
        <dl style="display: none;">
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/statisticalAnalysis/index');" style="background-image: none;">概览</a></dt>
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/statisticalAnalysis/questionCount');" style="background-image: none;">咨询问题统计</a></dt>
        </dl>
    </li>
    <li class="li1">
        <a>日志管理</a><i></i>
        <dl style="display: none;">
            <dt class=""><a href="javascript: void(0);" onclick="loadRemotePage('${request.contextPath}/traceLog/list');" style="background-image: none;">日志审计</a></dt>
        </dl>
    </li>
</ul>--}%

