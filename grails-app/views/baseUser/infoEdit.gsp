<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!request.xhr}">
        <meta name="layout" content="center">
    </g:if>
    <style>
    @media screen and (min-width:991px) {
        .orgTree {
            width: 500px;
            height: auto;
            max-height: 450px;
            left: 30%;
        }
    }
    </style>
    <script>
        $(function() {
            $("#orgTreeDiv").on('changed.jstree', function (e, data) {
                var node = data.instance.get_node(data.selected[0]);
                $("input[name='ascripteOrg']").val(node.id);
                $("input[name='ascripteOrgName']").val(node.text);
            }).jstree({
                'core': {
                    "multiple": false,
                    'data': {
                        'url': "${request.contextPath}/organization/orgJson",
                        "dataType": "json",
                        'data': function (node) {
                            return {'id': node.id};
                        }
                    }
                },
                "types": {
                    "root": {
                        "icon": "glyphicon glyphicon-folder-open"
                    }
                },
                "checkbox": {
                    "three_state": false
                },
                "plugins": ["types", "wholerow", "checkbox"]
            });
            $('#infoForm').validate({
                rules: {
                    mobile:{
                        isMobile: true
                    }
                }
            });
        });

        $.validator.addMethod("isMobile", function (value, element) {
            var reg = /^1[34578]\d{9}$/;
            return this.optional(element) || reg.test(value);
        }, "请输入正确的手机号码");

        function saveInfo(){
            if($('#infoForm').valid()){
                $.post("${request.contextPath}/baseUser/updateInfo",$("#infoForm").serialize(),function(data){
                    alert(data.message);
                    if(data.result){
                        setTimeout(back, 2000);
                    }
                },"json");
            }
        }
        function back(){
            location.href = "${request.contextPath}/baseUser/info";
        }
    </script>
</head>
<body>
<div class="wdxx">
    <span>我的信息</span>
</div>
<div class="pad20">
    <form id="infoForm" method="post">
        <input type="hidden" name="id" value="${user?.id}"/>
        <ul>
            <li class="to">
                <span class="tx">头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像：</span>
                <g:if test="${user.aviator}">
                    <img src="${request.contextPath}/baseUser/userAviator" class="zxz"/>
                </g:if>
                <g:else>
                    <img src="${request.contextPath}/images/grzx/nouser.jpg" class="zxz" />
                </g:else>
                <a href="javascript:void(0);"  data-toggle="modal" data-target="#aviatorModal">修改头像</a>
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
                <span class="dx">
                    <input type="text" name="mobile" required class="inp" value="${user?.mobile}"/>
                </span>
            </li>
            <li>
                <span class="tx">法律身份：</span>
                <span class="dx">
                    <g:select class="set" name="identity" from="${com.bjrxht.dictionary.Identity.findAll()}"
                              optionKey="id" optionValue="name" noSelection="['':'-请选择-']" value="${user?.identity?.id}"/>
                </span>
            </li>
            <li>
                <span class="tx">工作单位：</span>
                <span class="dx">
                    <input type="hidden" name="ascripteOrg" value="${user?.ascripteOrg?.id}">
                    <input type="text" name="ascripteOrgName" readonly class="inp" value="${user?.ascripteOrg?.name}" onclick="$('#orgModal').modal('show');"/>
                </span>
            </li>
            <li>
                <span class="tx">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务：</span>
                <span class="dx">
                    <input type="text" name="duty" class="inp" value="${user?.duty}"/>
                </span>
            </li>
        </ul>
        <div class="tix">
            <a href="javascript:void(0);" onclick="saveInfo();"><i></i>提交</a>
        </div>
    </form>
</div>
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="aviatorModalLabel" id="orgModal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content mt150">
            <div class="tck orgTree">
                <div class="tsxx">
                    <span class="title">选择工作单位</span>
                </div>
                <div id="orgTreeDiv" style="max-height: 300px;overflow-y: scroll;margin:-20px 10px 0 10px;"></div>
                <div class="zx" style="margin-top:0px;">
                    <a style="margin-top:10px;" href="javascript:void(0);" data-dismiss="modal">确定</a>
                </div>
                <span class="gbbtn" data-dismiss="modal"></span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
