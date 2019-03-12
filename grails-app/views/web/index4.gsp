<%--
  Created by IntelliJ IDEA.
  User: sunpengfei
  Date: 2018/12/6
  Time: 8:59 PM
--%>

<%@ page import="com.eyesfly.core.BaseUser" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:set var="currentUser" value="${com.eyesfly.core.BaseUser.findByUsername(sec.username())}"/>
    <title>区域工业环境大数据在线监测系统</title>
    <link rel="stylesheet" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${request.contextPath}/js/jquery-validation/jquery.validate.js"></script>
    <script type="text/javascript" src="${request.contextPath}/js/jquery-validation/localization/messages_zh.js"></script>
    <style type="text/css">
        .header {

            height: 115px;
        }
        .li{
            display: block;
            border-bottom: 1px solid #ecebeb;
            border-left: 6px solid #257295;
            border-left-color: transparent;
            padding-left: 48px;
            line-height: 50px;
            height: 50px;
            cursor: pointer;
        }
        .li a{
            font-size: 16px;
            color:#333333;
            text-decoration: none;
        }
        div.li.active {
            background: #fff;
            border-left-color: rgb(21, 78, 144);
        }
        .nav li{

            margin:0px 5px;
            background: rgb(23, 155, 238);
            border-radius: 4px 4px 0 0;
        }
        .nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover{
            background: rgb(21, 78, 144);
            color:#fff;
        }
        .nav-tabs>li>a{
            margin-right: 0px;
            color: #fff;
        }
        .nav-tabs>li>a:hover{
            background: rgb(21, 78, 144);
            /*color:#000000;*/
        }
        p{
            text-indent: 25px;
            padding:10px;
            line-height: 25px;
        }
        label.error{
            color:red;
        }
        img{
            width:100%;
            height: 100%;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $('.li').click(function(){
                $.each($('.li'),function (k,v) {
                    $(v).removeClass("active");
                });
                $(this).addClass("active");
            });
            $('.li').get(0).click();
        })

        function showProject(id){
            $.post("${request.contextPath}/web/showProject",{id:id},function (data,status) {
                    $("#content").html(data);
                    var index = $(".nav-tabs").find("li").size();
                    if(index>0){
                        $('.nav-tabs li:eq(0) a').tab('show');
                    }
            },'html');
        }

        $(function(){
            $('#passwordForm').validate({
                rules: {
                    confirmPass :{
                        equalTo: "#newPass"
                    }
                },messages: {
                    confirmPass :{
                        equalTo: "确认密码与新密码不一致"
                    }
                }
            });
        });
        function savePassword() {
            if($('#passwordForm').valid()){
                $.post("${request.contextPath}/web/passwordChange",$('#passwordForm').serialize(),function(data){
                    if(data.result){
                        $('#passwordModal').modal('hide');
                        alert("密码修改成功！");
                    }else{
                        $("#error").html(data.message);
                    }
                },"json");
            }
        }
    </script>
</head>

<body>
<div style="width: 100%;">
    <div style="background: rgb(21, 78, 144);padding:10px;">
        <div style="float: left;"><img src="${request.contextPath}/images/logo1.png" style="width: 500px;height: 70px;"></div>
        <div style="float: right;color: #fff;line-height: 50px;">
            您好，${currentUser}
            %{--<sec:ifNotGranted roles="ROLE_000000_0_yonghudaorujiaose">--}%
            %{--<a href="${request.contextPath}/baseUser/info" style="background: none;padding-left: 10px;">个人中心</a>--}%
            %{--</sec:ifNotGranted>--}%
            %{--<a href="${request.contextPath}/web/index" style="background: none;padding-left: 10px;">返回首页</a>--}%
            <span data-toggle="modal" style="cursor: pointer;" data-target="#passwordModal">修改密码</span>&nbsp;&nbsp;
            <a href="${request.contextPath}/logout" style="background: none;color: #fff;"><span class="glyphicon glyphicon-log-out" style="font-size: 16px;"></span>&nbsp;注销</a>
        </div>
        <div style="clear: both;"></div>
    </div>
    <div>
        <div style="background: #f6f4f4;height: 100%;margin:0px 30px 0px 0px;min-width: 220px;float: left;width: 20%;">
            <div style="border-top: 6px solid rgb(21, 78, 144);margin-top: 5px;height: 10px;">&nbsp;</div>
            <div>
                <g:each in="${list}" var="obj">
                    <div class="li" onclick="showProject('${obj.id}');">
                        <a href="javascript:void(0);">${obj.name}</a>
                    </div>
                </g:each>
            </div>
        </div>

        <div style="float: left;width: 75%;" id="content"></div>
        <div style="clear: both;"></div>
    </div>
</div>

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel" id="passwordModal">
    <div class="modal-dialog modal-lg" role="document" style="width: 500px;">
        <div class="modal-content mt150">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <div class="tck" style="height: auto;margin:0px auto; ">
                    <div class="tsxx" style="text-align: center;margin: 20px auto;">
                       %{-- <span class="title">修改密码</span>--}%
                        <form id="passwordForm" method="post">
                            <div style="color: red;" id="error"></div>
                            <div style="height: 62px;line-height: 62px;">
                                <span class="tx" style="display: inline;width: 80px;margin-left: 60px; float: left;line-height: 80px;">原密码：</span>
                                <span class="dx" style=" float: left;">
                                    <input style="display: inline;width: 221px;height: 44px;background-color: #f5f5f5;border-radius: 4px;border: solid 1px #dcdcdc;" type="password" id="oldPass" name="oldPass" required/>
                                </span>
                            </div>
                            <div style="height: 62px;line-height: 62px;clear: both;">
                                <span class="tx" style="display: inline;width: 80px;margin-left: 60px; float: left;line-height: 80px;">新密码：</span>
                                <span class="dx" style=" float: left;">
                                    <input style="display: inline;width: 221px;height: 44px;background-color: #f5f5f5;border-radius: 4px;border: solid 1px #dcdcdc;" type="password" id="newPass" name="newPass" required />
                                </span>
                            </div>
                            <div style="height: 62px;line-height: 62px;clear: both;">
                                <span class="tx" style="display: inline;width: 80px;margin-left: 60px; float: left;line-height: 80px;">密码确认：</span>
                                <span class="dx" style=" float: left;">
                                    <input style="display: inline;width: 221px;height: 44px;background-color: #f5f5f5;border-radius: 4px;border: solid 1px #dcdcdc;" type="password" id="confirmPass" name="confirmPass" required/>
                                </span>
                            </div>

                           %{-- <div class="zx" style="margin-top:10px;">
                                <a style="margin-top:10px;" href="javascript:void(0);" onclick="$('#passwordForm').submit();" >修改</a>
                            </div>--}%
                        </form>
                    </div>
                    <span class="gbbtn" data-dismiss="modal"></span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="savePassword();">修改</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>