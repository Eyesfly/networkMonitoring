<script>

    $.validator.addMethod("isMobile", function (value, element) {
        var reg = /^1[345678]\d{9}$/;
        return this.optional(element) || reg.test(value);
    }, "请输入正确的手机号码");
    $.validator.addMethod("isIdCard",function(value,element){
        if(checkID_Card(value)){
            return true;
        }
        return false;
    },"请填写正确的身份证号");
    $('#userForm').validate({
        rules: {
            idCard:{
                isIdCard: true,
                remote: "${request.contextPath}/baseUser/checkUnique/${baseUser?.id}"
            },
            mobile:{
                isMobile: true
            },
            password2 :{
                equalTo: "#password"
            }
        },
        messages:{
            idCard:{
                remote: "该身份证号已注册"
            }
        },
        errorPlacement: function(error, element) {
            $(element).closest("div").append( error );
        }
    });

    $(function(){
        initTree($("#orgTreeDiv"));
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

    function initTree(tree){
        tree.on('changed.jstree', function (e, data) {
            var node = data.instance.get_node(data.selected[0]);
        }).jstree({
            'core' : {
                "multiple": false,
                'data': {
                    'url': "${request.contextPath}/organization/orgJson?type=1&pid="+$("input[name='organization']").val(),
                    "dataType": "json",
                    'data' : function (node) {
                        return { 'id' : node.id };
                    }
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
    }
    function showAscripteOrg(){
        $("#orgTreeDiv").jstree(true).destroy ();
        initTree($("#orgTreeDiv"));
        $('#orgTreeModal').modal('show');
    }
</script>
<form id="userForm" method="post">
    <input type="hidden" name="id" value="${baseUser?.id}"/>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 单位名称：</div>
        <div class="col-8">
            <input type="hidden" name="organization" value="${baseUser?.organization?.id}"/>
            <input class="input w360" type="text" name="organizationName" readonly required value="${baseUser?.organization?.name}" onclick="$('#orgTree1Modal').modal('show');"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 姓　　名：</div>
        <div class="col-8">
            <input class="input w360" type="text" name="realName" required value="${baseUser?.realName}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 手机号码：</div>
        <div class="col-8">
            <input class="input w360" type="text" name="mobile" required value="${baseUser?.mobile}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 是否允许登录：</div>
        <div class="col-8">
            <select class="form-control w360" name="enabled" >
                <option value="true" <g:if test="${baseUser?.enabled == true}">selected</g:if>>是</option>
                <option value="false" <g:if test="${baseUser?.enabled == false}">selected</g:if>>否</option>
            </select>
        </div>
    </div>

    <div class="text-center">
        <button type="button" class="butn butn-add" onclick="saveOrUpdate();"><img src="${request.contextPath}/images/htgl/submit_ico.png" alt=""> 提交</button>　
        <button type="button" class="butn butn-reset" onclick="resetUserForm()"><img src="${request.contextPath}/images/htgl/reset_ico.png" alt=""> 重置</button>　　　　　　　　　　　　
    </div>

</form>

<div class="modal" id="orgTreeModal" tabindex="-1" role="dialog" aria-labelledby="orgTreeModalHead" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">选择归属机构</h4>
            </div>
            <div class="modal-body">
                <div id="orgTreeDiv" style="max-height: 350px;overflow-y: scroll;"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-blue margin" type="button" data-dismiss="modal" >确定</button>
                <button class="btn btn-blue margin" type="button" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="orgTree1Modal" tabindex="-1" role="dialog" aria-labelledby="orgTree1ModalHead" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">选择管理机构</h4>
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
