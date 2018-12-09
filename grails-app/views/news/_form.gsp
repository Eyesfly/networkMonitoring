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
        var index = $(".nav-tabs").find("li").size();
        if(index>0){
            $('.nav-tabs li:eq(0) a').tab('show');
        }

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
    function addTabs(val) {

        var liDom = $(".nav-tabs").find("li");
        var divDom = $(".tab-content").find("div.tab-pane");
        var index = liDom.size();
        if(index==0){
            $(".nav-tabs").append("<li><a href='#div"+index+"' data-toggle='tab'>"+val+"</a></li>");
        }else{
            liDom.last().after("<li><a href='#div"+index+"' data-toggle='tab'>"+val+"</a></li>");
        }
        $.post("${request.contextPath}/news/ck",{id:index,name:val},function (data,status) {
            if(index==0){
                $(".tab-content").append(data);
            }else{
                divDom.last().after(data);
            }
            $('#tabModal').modal('hide');
            $('.nav-tabs li:eq("'+index+'") a').tab('show');
        },"html");
    }
    function renameTab(dom) {
        $("#nameText").val(dom);
        $("#tabUpdateName").val($(".nav-tabs li").find("a[href='#"+dom+"']").text());
        $('#tabUpdateModal').modal('show');
    }
    function rename(val) {
        var val = $('#tabUpdateName').val();
        var dom = $('#nameText').val();
        $(".nav-tabs li").find("a[href='#"+dom+"']").text(val);
        $("#"+dom).find("input[name='projectName']").val(val);
        $('#tabUpdateModal').modal('hide');
    }
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
        %{--<li class="active">--}%
            %{--<a href="#projectOverviewDiv" data-toggle="tab">--}%
                %{--项目概况--}%
            %{--</a>--}%
        %{--</li>--}%
        <g:each in="${newsContentList}" var="obj">
            <li ondblclick="renameTab('div${obj.sort}');">
                <a href="#div${obj.sort}" data-toggle="tab">${obj.name}</a>
            </li>
        </g:each>
        <span style="cursor: pointer;padding-left:10px;line-height: 40px;" onclick="$('#nameText').val('');$('#tabModal').modal('show');" ><span class="glyphicon glyphicon-plus"></span>添加</span>

    </ul>
    <div class="tab-content vertical-tab-content">
        %{--<div class="tab-pane fade in active" id="div0">--}%
            %{--<div style="margin:20px 0px;">--}%
                %{--<ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="content" id="content0" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default"></ckeditor:editor>--}%
            %{--</div>--}%
        %{--</div>--}%
        <g:each in="${newsContentList}" var="obj">
            <div class="tab-pane fade in" id="div${obj.sort}">
                <div style="margin:20px 0px;">
                    <input type="hidden" name="projectId" value="${obj.id}">
                    <input type="hidden" name="projectName" value="${obj.name}">
                    <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="content" id="content${obj.sort}" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default">${obj.content}</ckeditor:editor>
                </div>
            </div>
        </g:each>
    </div>
    <br/>

    <div class="text-center">
        <button type="button" class="butn butn-add" onclick="saveOrUpdate();" ><img src="${request.contextPath}/images/htgl/submit_ico.png" alt=""> 提交</button>　
        <button type="button" class="butn butn-reset" onclick="resetnewsForm();"><img src="${request.contextPath}/images/htgl/reset_ico.png" alt=""> 重置</button>　
        <button type="button" class="butn butn-add" onclick="backManager();"><img src="${request.contextPath}/images/htgl/table_arrow.png" alt=""> 返回</button>
    </div>

</form>

<div class="modal fade" id="tabModal" tabindex="-1" role="dialog" aria-labelledby="tabModalHead" aria-hidden="true" style="top: 30%;" >
    <div class="modal-dialog" style="min-width: 300px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">名称</h4>
            </div>
            <div class="modal-body" id="tabModalBody" style="text-align: center; min-height: 100px; line-height: 65px;">
                <input type="text" name="tabName" id="tabName" class="input w95">
            </div>

            <div class="modal-footer">
                <button class="btn btn-default margin" onclick="addTabs($('#tabName').val());" type="button">
                    <span class="glyphicon glyphicon-ok"></span>
                    添加
                </button>
                <button class="btn btn-default margin" data-dismiss="modal" type="button">
                    <span class="glyphicon glyphicon-remove"></span>
                    关闭
                </button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="tabUpdateModal" tabindex="-1" role="dialog" aria-labelledby="ttabUpdateHead" aria-hidden="true" style="top: 30%;" >
    <div class="modal-dialog" style="min-width: 300px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">修改名称</h4>
            </div>
            <div class="modal-body" id="tabUpdateModalBody" style="text-align: center; min-height: 100px; line-height: 65px;">
                <input type="hidden" id="nameText" class="input w95">
                <input type="text"  id="tabUpdateName" class="input w95">
            </div>

            <div class="modal-footer">
                <button class="btn btn-default margin" onclick="rename();" type="button">
                    <span class="glyphicon glyphicon-ok"></span>
                    添加
                </button>
                <button class="btn btn-default margin" data-dismiss="modal" type="button">
                    <span class="glyphicon glyphicon-remove"></span>
                    关闭
                </button>
            </div>
        </div>
    </div>
</div>