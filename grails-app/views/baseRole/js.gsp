<script>
    function queryParams(params){
        params.keywords=$("#keywords").val();
        params.max=params.limit;
        return params;
    }

    function queryUserParams(params){
        params.keywords=$("#keywords").val();
        params.max=params.limit;
        return params;
    }

    function doSearch(){
        $("#baseRoleTable").bootstrapTable("refresh",[]);
    }

    function doSearch1(){
        $("#baseUserTable").bootstrapTable("refresh",[]);
    }

    function indexFormatter(value, row, index) {
        return index+1;
    }

    function operateFormatter(value, row, index) {
        var str = [];
        str.push('<a class="btn btn-primary" href="javascript:configUser(\''+row.id+'\')">分配</a>&nbsp;&nbsp;');
        str.push('<a class="btn btn-primary" href="javascript:showRole(\''+row.id+'\')">查看</a>&nbsp;&nbsp;');
        if(row.type == 1 || row.type == 2 || row.type == 3){
            str.push('<a class="btn btn-primary" href="javascript:editRole(\''+row.id+'\')">编辑</a>&nbsp;&nbsp;');
            str.push('<a class="btn btn-primary" href="javascript:confirm(\'确认要删除该角色吗？\',function(){delRole(\''+row.id+'\')})">删除</a>&nbsp;&nbsp;');
        }else if(row.type == 5){
            str.push('<a class="btn btn-primary" href="javascript:showTreeModal(\''+row.id+'\')">关联功能</a>&nbsp;&nbsp;');
        }
        return str.join('');
    }

    function configUser(roleId) {
        loadRemotePage('${request.contextPath}/baseRole/userList',{roleId:roleId},"系统管理","角色管理","分配用户");
    }

    function userOperateFormatter(value, row, index){
        var str = [];
        str.push('<a class="btn btn-primary" href="javascript:confirm(\'确认要移除该用户吗？\', function(){removeUser(\''+row.id+'\')})">移除</a>&nbsp;&nbsp;');
        return str.join('');
    }

    function removeUser(userId){
        $.post("${request.contextPath}/baseRole/removeUser",{userId:userId,roleId:$("#roleId").val()},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            if(data.result){
                $("#baseUserTable").bootstrapTable("refresh",[]);
            }
        },"json");
    }

    function showOrgUserModal(roleId){
        $.post("${request.contextPath}/baseRole/orgUserTree",{roleId:roleId},function(data){
            $("#orgUserModalBody").html(data);
            $("#orgUserModal").modal('show');
        },"html");
    }


    function newRole(){
        loadRemotePage('${request.contextPath}/baseRole/create',{},"系统管理","角色管理","新增角色");
    }

    function editRole(roleId){
        loadRemotePage('${request.contextPath}/baseRole/edit',{roleId:roleId},"系统管理","角色管理","编辑角色");
    }

    function saveOrUpdate() {
        if($("#roleForm").valid()){
            $.post("${request.contextPath}/baseRole/saveOrUpdate",$("#roleForm").serialize(),function(data){
                $("#messageModalBody").html(data.message);
                $("#messageModal").modal('show');
                if(data.result){
                    loadRemotePage('${request.contextPath}/baseRole/list',{},"系统管理","角色管理");
                }
            },"json");
        }
    }

    function delRole(roleId){
        $.post("${request.contextPath}/baseRole/delRole",{roleId:roleId},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            if(data.result){
                loadRemotePage('${request.contextPath}/baseRole/list',{},"系统管理","角色管理");
            }
        },"json");
    }

    function showRole(roleId){
        loadRemotePage('${request.contextPath}/baseRole/show',{roleId:roleId},"系统管理","角色管理","查看角色");
    }

    function showTreeModal(roleId){
        $.post("${request.contextPath}/baseRole/menuTree",{roleId:roleId},function(data){
            $("#treeModalBody").html(data);
            $("#treeModal").modal('show');
        },"html");
    }

    function backRoleManager(){
        loadRemotePage('${request.contextPath}/baseRole/list',{},"系统管理","角色管理");
    }

    function resetRoleForm(){
        $("#roleForm input.w360").val("");
        $("#roleForm .selectpicker").val("");
        $("#roleForm textarea.w70").val("");
        $("#roleForm").validate().resetForm();
    }
</script>