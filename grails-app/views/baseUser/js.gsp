<script>
    function queryParams(params){
        params.max=params.limit;
        params.keywords = $("#keywords").val();
        return params;
    }

    function doSearch(){
        $("#baseUserTable").bootstrapTable("refresh",[]);
    }

    function indexFormatter(value, row, index) {
        return index+1;
    }

    function operateFormatter(value, row, index) {
        var str = [];
        if(row.username!=="superadmin"){
            str.push('<a class="btn btn-primary" href="javascript:showUser(\''+row.id+'\')">查看</a>&nbsp;&nbsp;');
            if(row.enabled){
                str.push('<a class="btn btn-primary" href="javascript:enabledUser(\''+row.id+'\',0)">停用</a>&nbsp;&nbsp;');
            }else{
                str.push('<a class="btn btn-danger" href="javascript:enabledUser(\''+row.id+'\',1)">启用</a>&nbsp;&nbsp;');
            }
            str.push('<a class="btn btn-primary" href="javascript:editUser(\''+row.id+'\')">编辑</a>&nbsp;&nbsp;');
        }
        return str.join('');
    }

    function enabledUser(userId,enabled){
        $.post("${request.contextPath}/baseUser/enabledUser",{userId:userId,enabled:enabled},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            if(data.result){
                $("#baseUserTable").bootstrapTable("refresh",[]);
            }
        },"json");
    }

    function saveRole(){
        $.post("${request.contextPath}/baseUser/configureUser",{userId:$("#userId").val(),role:$("#newRole").val()},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            if(data.result){
                $("#roleModal").modal('hide');
                $("#baseUserTable").bootstrapTable("refresh",[]);
            }
        },"json");
    }

    function newUser(){
        loadRemotePage('${request.contextPath}/baseUser/create',{},'系统管理','用户管理',"新增用户");
    }

    function editUser(userId){
        loadRemotePage('${request.contextPath}/baseUser/edit',{userId:userId},'系统管理','用户管理',"编辑用户");
    }

    function saveOrUpdate() {
        if($("#userForm").valid()){
            $.post("${request.contextPath}/baseUser/saveOrUpdate",$("#userForm").serialize(),function(data){
                $("#messageModalBody").html(data.message);
                $("#messageModal").modal('show');
                if(data.result){
                    loadRemotePage('${request.contextPath}/baseUser/list',{},'系统管理','用户管理');
                }
            },"json");
        }
    }

    function delUser(userId){
        $.post("${request.contextPath}/baseUser/delUser",{userId:userId},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            if(data.result){
                loadRemotePage('${request.contextPath}/baseUser/list',{},'系统管理','用户管理');
            }
        },"json");
    }

    function delAll(){
        var selectRows=$('#baseUserTable').bootstrapTable('getSelections');
        if (selectRows.length <= 0) {
            $("#messageModalBody").html("请选择要删除的用户");
            $("#messageModal").modal('show');
            return;
        }else {
            var ids=[];
            for (var i = 0; i < selectRows.length; i++) {
                ids.push(selectRows[i].id);
            }
            $.post("${request.contextPath}/baseUser/delAll",{ids:ids.join(',')},function (data, textStatus) {
                $("#messageModalBody").html(data.message);
                $("#messageModal").modal('show');
                if(data.result){
                    $('#baseUserTable').bootstrapTable('refresh',{});
                }
            }, "json");
        }
    }

    function showUser(userId){
        loadRemotePage('${request.contextPath}/baseUser/show',{userId:userId},'系统管理','用户管理',"查看用户");
    }

    function showImportModal(){
        $("#importModal").modal('show');
    }

    function importExcel(type){
        var form = new FormData(document.getElementById("uploadForm"+type));
        $.ajax({
            url:"${request.contextPath}/baseUser/uploadExcel/"+type,
            type:"post",
            data:form,
            cache: false,
            processData: false,
            contentType: false,
            success:function(data){
                $('#importModal').modal('hide');
                $("#operateModalBody").html(data.message);
                $("#operateModal").modal('show');
                $("#baseUserTable").bootstrapTable("refresh",[]);
            },
            error:function(e){
                $('#importModal').modal('hide');
                $("#operateModalBody").html("网络错误，请重试！");
                $("#operateModal").modal('show');
            }
        });
    }

    function exportUser() {
        var selectRows=$('#baseUserTable').bootstrapTable('getSelections');
        if (selectRows.length <= 0) {
            return;
        }else {
            var obj=new Object();
            obj.keywords = $("#keywords").val();
            if ($("input[name='btSelectAll']").is(":checked")) {
                obj.ids = "all";
            } else {
                var ids=[];
                for (var i = 0; i < selectRows.length; i++) {
                    ids.push(selectRows[i].id);
                }
                obj.ids = ids.join(',');
            }
            location.href = '${request.contextPath}/baseUser/exportUser?ids='+obj.ids+'&keywords='+obj.keywords;
        }

    }

    function backUserManager(){
        loadRemotePage('${request.contextPath}/baseUser/list',{},'系统管理','用户管理');
    }

    function resetUserForm(){
        $("#userForm input.w360").val("");
        $("#userForm .form-control.w360").val("true");
        $("#userForm").validate().resetForm();
    }

</script>