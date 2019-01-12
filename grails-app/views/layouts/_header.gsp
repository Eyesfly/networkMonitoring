<style type="text/css">
.glyphicon {
    position: relative;
    top: 1px;
    display: inline-block;
    font-family: 'Glyphicons Halflings';
    font-style: normal;
    font-weight: 400;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}
.glyphicon-log-out:before {
    content: "\e163";
}
@font-face {
    font-family: 'Glyphicons Halflings';

    src: url('${request.contextPath}/js/bootstrap-3.3.7/fonts/glyphicons-halflings-regular.eot');
    src: url('${request.contextPath}/js/bootstrap-3.3.7/fonts/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'), url('${request.contextPath}/js/bootstrap-3.3.7/fonts/glyphicons-halflings-regular.woff2') format('woff2'), url('${request.contextPath}/js/bootstrap-3.3.7/fonts/glyphicons-halflings-regular.woff') format('woff'), url('${request.contextPath}/js/bootstrap-3.3.7/fonts/glyphicons-halflings-regular.ttf') format('truetype'), url('${request.contextPath}/js/bootstrap-3.3.7/fonts/glyphicons-halflings-regular.svg#glyphicons_halflingsregular') format('svg');
}
.mt15{
    margin-top: 15px !important;
}
</style>
<div class="t1">
    <div class="w1200">
        %{--<div class="head_icon fl" style="margin-bottom: -73px;"><img src="${request.contextPath}/images/grzx/top_icon.png" alt=""></div>
        <div class="logo fl mt15"  style=""><img src="${request.contextPath}/images/grzx/logo1.png" alt=""></div>
--}%
        %{--<div class="tl fl">
            <a href="">
                <img src="${request.contextPath}/images/grzx/logo.jpg"/>
            </a>
        </div>--}%
        <div class="tr fr">
            <span class="yh">${currentUser}，欢迎您！
                <g:if test="${'5' in com.bjrxht.core.BaseUserBaseRole.findAllByBaseUser(currentUser)?.baseRole?.type}">
                    <a href="${request.contextPath}/workspace/index">进入后台</a>
                </g:if>
                <a href="${request.contextPath}/web/index">返回首页</a>
            </span>
            <a class="zx" href="${request.contextPath}/logout" style="color: #fff;padding: 5px 10px;border-top: none;"><span class="glyphicon glyphicon-log-out" style="font-size: 16px;"></span>&nbsp;注销</a>
        </div>
    </div>
</div>