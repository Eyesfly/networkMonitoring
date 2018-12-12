<%@ page import="com.eyesfly.core.BaseUser" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
	<g:set var="currentUser" value="${BaseUser.findByUsername(sec.username())}"/>
	<g:set var="menuItems" value="${com.eyesfly.core.BaseUserBaseRole.findAllByBaseUser(currentUser)?.baseRole?.findAll{it.isDel==false}.collect{it.menuItems}?.toString().replace(' ','').replace('[','').replace(']','').split(',')}"/>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><g:layoutTitle default="区域工业环境大数据在线监测系统"/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap-switch.css">
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bootstrap-3.3.7/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bootstrap-table-1.11.0/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
	%{--<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bghtml/css/common.css">
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bghtml/css/index.css">--}%
	<link href="${request.contextPath}/css/ucap/htgl_common.css" rel="stylesheet">
	<link href="${request.contextPath}/css/ucap/htgl_table.css" rel="stylesheet">
	<link href="${request.contextPath}/css/ucap/htgl_form.css" rel="stylesheet">
	<script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
	<script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap-switch.js"></script>
	<script src="${request.contextPath}/js/bootstrap-table-1.11.0/bootstrap-table.min.js"></script>
	<script src="${request.contextPath}/js/bootstrap-table-1.11.0/locale/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/jquery-validation/jquery.validate.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/jquery-validation/localization/messages_zh.js"></script>
	<script type='text/javascript' src='${request.contextPath}/js/jquery-easyui-1.5.1/jquery.easyui.min.js'></script>
	<script type='text/javascript' src='${request.contextPath}/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js'></script>
	<script type='text/javascript' src='${request.contextPath}/js/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js'></script>
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/jstree-3.2.1/dist/themes/default/style.min.css"/>
	<script type="text/javascript" src="${request.contextPath}/js/jstree-3.2.1/dist/jstree.min.js"></script>
	<script type="text/javascript">
		$(function(){
			<g:if test="${flash.message}">
			showMessage('${flash.message}');
			</g:if>

			$.ajaxSetup({
				cache:false,
				error : function(jqXHR, textStatus, errorThrown){

					if (jqXHR.status==401){
						window.location.href="${request.contextPath}/";
					}
				},
				traditional : true
			});

			//菜单 显隐 颜色等
			$('.mainLeft li,.mainLeft h3').click(function() {
				$('.mainLeft li,.mainLeft h3').removeClass('active');
				$(this).addClass('active');
			});

		});
		function loadRemotePage(url,obj,title1,title2,title3) {
			$('#mainBodyDiv').html("<div style='width: 100%; text-align: center; margin-top: 150px;'></div>");
			if(typeof(obj)=="undefined"){
				obj = {};
			}
			$.post(url, obj,
					function (data, textStatus) {
						$('#mainBodyDiv').html('');
						$("#title").html("<h2>"+title1+"</h2>");
						if(typeof(title2) != "undefined"){
							$("#title h2").append("-<i>"+title2+"</i>")
						}
						if(typeof(title3) != "undefined"){
							$("#title h2").append("-<i>"+title3+"</i>")
						}
						$('#mainBodyDiv').html(data);
						$( ".datepicker" ).datetimepicker({language: 'zh-CN',autoclose: true,todayBtn: true,format: 'yyyy-mm-dd',minView: "month", todayHighlight: true });
						$(".bootstrapTable").bootstrapTable({});
						//初始日期控件
					}, "html");
		}

		function showMessage(message) {
			$('#messageModalBody').html(message);
			$('#messageModal').modal('show');
		}

		function indexFormatter(value, row, index) {
			return index+1;
		}
		$(function(){
			var img_height = $(window).height();
			$(".body_fiximg").height(img_height);
		});
	</script>
	<style type="text/css">
		/**{
			font-size:16px;
		}*/

		a:focus, a:hover{
			text-decoration: none;
		}
		.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6{
			 font-family: "Microsoft YaHei","宋体";
			 font-weight: bolder;
			 line-height: 43px;
			 color: #024c6e;
		}
		.btn-default{
			color: #333;
			background-color: #fff;
			border-color: #ccc;
		}
		.table-striped>tbody>tr:nth-of-type(even){
			background-color: #f9f9f9;
		}
		.table-striped>tbody>tr:nth-of-type(odd) {
			background-color: #fff;
		}
		.bootstrap-table .table>thead>tr>th{
			border-bottom: none;

			background-color: #f7f7f7;
		}
		.bootstrap-table .table{
			border-bottom: none;
			border-top: 2px solid #257295;
		}
	    .fixed-table-container{
			border: none;
		}
		.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{
			 border-top: none;
		}
		/*.fixed-table-container thead th{
        border-left:none;
    }*/
		body {
			background: #f5f5f5 url(${request.contextPath}/images/htgl/bg.jpg) no-repeat top center;
			padding: 0;
			margin: 0;
			font-family: "Microsoft YaHei","宋体";
			color: #626262;
			font-size: 14px;
		}
		.slide_menu dt {
			font-weight: normal;
		}
		.slide_menu dl {
			display: none;
		}
		.slide_menu ul li.active a {
			color: #000000;
		}
		.slide_menu ul li.active > a {
			color: #fff;
		}
		.slide_menu ul li i {
			background: url("") no-repeat;
		}
		.slide_menu ul li.active i {
			background: url("${request.contextPath}/js/bghtml/images/down.png") no-repeat;
		}
		.slide_menu ul li.active, .slide_menu ul li dl dt.active {
			background-color: #337ab7;
		}
		.slide_menu ul li:hover, .slide_menu ul li dl dt:hover {
			background-color: #337ab7;
		}
		.slide_menu ul li:hover > a, .slide_menu ul li dl dt:hover a {
			color: #fff;
		}
		.slide_menu ul li:hover, .slide_menu ul li dl dt a:hover, .slide_menu ul li.active, .slide_menu ul li dl dt.active a {
			background-image: url("${request.contextPath}/js/bghtml/images/slide_libg_active-5.png");
			background-repeat: no-repeat;
		}
		.slide_menu ul li dl dt a, .slide_menu ul li dl dt a {
			background-image: url("${request.contextPath}/js/bghtml/images/slide_libg.png");
			background-repeat: no-repeat;
		}
		.mainBtn button{
			/*position: absolute;*/
		}
		.fixed-table-container tbody td,.fixed-table-container thead th{
			border-left:none;
		}
		.bootstrap-table .table.table-no-bordered > tbody > tr > td, .bootstrap-table .table.table-no-bordered > thead > tr > th{
			border-right: none;
		}
		.zx {
			margin-top: 10px;
			width: 100%;
			height: 60px;
			border-top: 1px solid #dcdcdc;
		}
		.zx a{
			width: 123px;
			height: 34px;
			display: block;
			text-align: center;
			background-color: #fff;
			margin: 0 auto;
			line-height: 34px;
			margin-top: 15px;
		}
		label.error{
			color:red;
		}
		.zzbg{background:rgba(15, 14, 14,0.5);width: 100%;height: 100%;position: fixed;left: 0;top: 0;display:block;}
		.tck{background: #fff;width: 960px;height: 490px;position: fixed;z-index: 999;display: block;border-radius: 15px;}
		.tck .tsxx{width: 90%;text-align: center;margin: 20px auto;}
		.tck .tsxx span{display: inline-block;width: 100%;}
		.tck .tsxx span.title{font-size: 24px;text-align: center;color: #034766;margin-bottom: 25px;}
		.body_fiximg{ width: 100%; position: fixed; top:0; left: 0; background: url(${request.contextPath}/images/htgl/bjt.png) no-repeat left top; background-size: 100%; z-index: -99;}
	</style>
<g:layoutHead/>
</head>
<body>
%{--<div class="body_fiximg"></div>--}%
<div class="header">
	<div class="w1210">


		<img src="${request.contextPath}/images/logo1.png" style="width: 500px;height: 70px;margin-top: 20px;">


		<div class="topBar fr mt40">
			您好，${currentUser}
			%{--<sec:ifNotGranted roles="ROLE_000000_0_yonghudaorujiaose">--}%
				%{--<a href="${request.contextPath}/baseUser/info" style="background: none;padding-left: 10px;">个人中心</a>--}%
			%{--</sec:ifNotGranted>--}%
			%{--<a href="${request.contextPath}/web/index" style="background: none;padding-left: 10px;">返回首页</a>--}%
			<a href="${request.contextPath}/logout" style="background: none;"><span class="glyphicon glyphicon-log-out" style="font-size: 16px;"></span>&nbsp;注销</a>
			%{--<a href="${request.contextPath}/web/wechat" target="_blank" class="weixin">微信</a> <a href="${request.contextPath}/web/app" target="_blank" class="app">APP</a>--}%
		</div>
	</div>
</div>
<div class="container mt35 bgfff" style="width: auto;">
	<div class="padd20">
		<div class="main" style="min-height:auto;">
			<div class="mainLeft">
				<g:render template="/layouts/roleMenu"/>
			</div>
			<div class="mainRight bgfff" style="min-height: 600px;">
				<div id="title"></div>
				<div style="height:100%; width:100%;padding-top: 20px;" id="mainBodyDiv">
					<g:layoutBody/>
				</div>
			</div>

			<div class="clear"></div>
		</div>
	</div>
</div>

<g:render template="/layouts/footer"/>



%{--
	<div class="container" style="padding: 0px;">
		<div class="fl slide_menu">
			<g:render template="/layouts/roleMenu" model="['currentUser':currentUser]"/>
		</div>
		<div class="fr rightPart">
			<div class="main" style="height:100%; width:100%;padding-top: 20px;" id="mainBodyDiv">
				<g:layoutBody/>
			</div>
		</div>
	</div>
--}%

	<!-- 消息提示 -->
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalHead" aria-hidden="true" style="top: 30%;" >
		<div class="modal-dialog" style="min-width: 300px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title">信息提示</h4>
				</div>
				<div class="modal-body" id="messageModalBody" style="text-align: center; min-height: 100px; line-height: 65px;">

				</div>

				<div class="modal-footer">
					<button class="btn btn-default margin" data-dismiss="modal" type="button">
						<span class="glyphicon glyphicon-remove"></span>
						关闭
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
