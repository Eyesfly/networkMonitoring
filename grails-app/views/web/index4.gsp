<%--
  Created by IntelliJ IDEA.
  User: sunpengfei
  Date: 2018/12/6
  Time: 8:59 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>区域工业环境大数据在线监测系统</title>
    <link rel="stylesheet" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
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
    </script>
</head>

<body>
<div style="width: 100%;">
    <div style="background: rgb(21, 78, 144);padding:10px;">
        <img src="${request.contextPath}/images/logo1.png" style="width: 500px;height: 70px;">
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
</body>
</html>