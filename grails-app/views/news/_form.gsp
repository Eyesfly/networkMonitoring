<%@ page import="com.eyesfly.core.BaseUser;" %>
<ckeditor:config var="toolbar_Mytoolbar">
    [
        [ 'RemoveFormat', 'Styles','Format','Font','FontSize', '-', 'TextColor', 'BGColor', 'Bold', 'Italic', '-', 'Paste', 'PasteText', '-', 'Link', 'Unlink', '-','Image','Flash','-'],
        [ 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']
    ]
</ckeditor:config>
<ckeditor:resources/>
<script>
    $(function() {
        $( ".form_date" ).datetimepicker({minView: "month",language: 'zh-CN',autoclose: true,format: 'yyyy-mm-dd',todayBtn:true,endDate: new Date() });
    });
    $('#newsForm').validate({
        rules: {
            title:{
                required: true,
            },
            content:{
                required: true
            }
        }
    });
</script>
<form id="newsForm" method="post" style="font-size: 14px;" enctype="multipart/form-data">
    <input name="id" id="id" type="hidden" value="${news?.id}"/>
    <div class="row1">
        <div class="col-1 text-right"><span class="text-red">*</span> <b>标　　题：</b></div>
        <div class="col-9">
            <input type="text" class="input w95"  name="name" value="${news?.name}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-1 text-right"><b>发布时间：</b></div>
        <div class="col-9">
            <input type="text" class="input w200 form_date" readonly name="publishDate" value="${news?.publishDate?.format('yyyy-MM-dd')}"/>
        </div>
    </div>

    <ul class="nav nav-tabs  vertical-tab">
        <li class="active">
            <a href="#projectOverviewDiv" data-toggle="tab">
                项目概况
            </a>
        </li>
        <li>
            <a href="#result1Div" data-toggle="tab">第一次场地<br/>测试结果</a>
        </li>
        <li>
            <a href="#result2Div" data-toggle="tab">第二次场地<br/>测试结果</a>
        </li>
        <li>
            <a href="#result3Div" data-toggle="tab">第三次场地<br/>测试结果</a>
        </li>
        <li>
            <a href="#result4Div" data-toggle="tab">第四次场地<br/>测试结果</a>
        </li>
        <li>
            <a href="#result5Div" data-toggle="tab">施工后测试</a>
        </li>
    </ul>
    <div class="tab-content vertical-tab-content">
        <div class="tab-pane fade in active" id="projectOverviewDiv">
            <div style="margin:20px 0px;">
                <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="projectOverview" id="projectOverview" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default">${news?.projectOverview}</ckeditor:editor>

            </div>
        </div>
        <div class="tab-pane fade" id="result1Div">
            <div style="margin:20px 0px;">
                <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="result1" id="result1" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default">${news?.result1}</ckeditor:editor>

            </div>
        </div>
        <div class="tab-pane fade" id="result2Div">
            <div style="margin:20px 0px;">
                <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="result2" id="result2" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default">${news?.result2}</ckeditor:editor>

            </div>
        </div>
        <div class="tab-pane fade" id="result3Div">
            <div style="margin:20px 0px;">
                <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="result3" id="result3" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default">${news?.result3}</ckeditor:editor>

            </div>
        </div>
        <div class="tab-pane fade" id="result4Div">
            <div style="margin:20px 0px;">
                <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="result4" id="result4" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default">${news?.result4}</ckeditor:editor>

            </div>
        </div>
        <div class="tab-pane fade" id="result5Div">
            <div style="margin:20px 0px;">
                <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="result5" id="result5" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default">${news?.result5}</ckeditor:editor>

            </div>
        </div>
    </div>
    <br/>

    <div class="text-center">
        <button type="button" class="butn butn-add" onclick="saveOrUpdate();" ><img src="${request.contextPath}/images/htgl/submit_ico.png" alt=""> 提交</button>　
        <button type="button" class="butn butn-reset" onclick="resetnewsForm();"><img src="${request.contextPath}/images/htgl/reset_ico.png" alt=""> 重置</button>　
        <button type="button" class="butn butn-add" onclick="backManager();"><img src="${request.contextPath}/images/htgl/table_arrow.png" alt=""> 返回</button>
    </div>

</form>