<script>
    $(function(){
        $('#roleForm').validate({
            errorPlacement: function(error, element) {
                $(element).closest("div").append( error );
            }
        });
        $("#orgTree1Div").on('changed.jstree', function (e, data) {
            var node = data.instance.get_node(data.selected[0]);
            $("input[name='organization']").val(node.id);
            $("input[name='organizationName']").val(node.text);
        }).jstree({
            'core' : {
                "multiple": false,
                'data': {
                    'url': "${request.contextPath}/organization/orgJson1",
                    "dataType": "json"
                }
            },
            "types" : {
                "root" : {
                    "icon" : "glyphicon glyphicon-folder-open"
                }
            },
            "checkbox": {
                "three_state": false
            },
            "plugins": ["types","wholerow","checkbox"]
        });
    });
</script>
<form id="roleForm" method="post">
    <input type="hidden" name="id" value="${baseRole?.id}"/>
    <sec:ifAnyGranted roles="ROLE_SUPERADMIN">
        <div class="row1">
            <div class="col-2 text-right"><span class="text-red"></span> 机&emsp;&emsp;构：</div>
            <div class="col-8">
                <input type="hidden" name="organization" value="${baseRole?.organization?.id}"/>
                <input class="input w360" type="text" name="organizationName" readonly value="${baseRole?.organization?.name}" onclick="$('#orgTree1Modal').modal('show');"/>
            </div>
        </div>
    </sec:ifAnyGranted>

    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 角色名称：</div>
        <div class="col-8">
            <input class="input w360" type="text" name="name" required value="${baseRole?.name}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red"></span> 角色描述：</div>
        <div class="col-8">
            <textarea class="form-control w70" rows="5" name="description" >${baseRole?.description}</textarea>
        </div>
    </div>

    <div class="text-center">
        <button type="button" class="butn butn-add" onclick="saveOrUpdate();"><img src="${request.contextPath}/images/htgl/submit_ico.png" alt=""> 提交</button>　
        <button type="button" class="butn butn-reset" onclick="resetRoleForm()"><img src="${request.contextPath}/images/htgl/reset_ico.png" alt=""> 重置</button>　　　　　　　　　　　　
    </div>

</form>

<div class="modal" id="orgTree1Modal" tabindex="-1" role="dialog" aria-labelledby="orgTree1ModalHead" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">选择机构</h4>
            </div>
            <div class="modal-body">
                <div id="orgTree1Div" style="max-height: 350px;overflow-y: scroll;"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-blue margin" type="button" data-dismiss="modal" >确定</button>
                <button class="btn btn-blue margin" type="button" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>