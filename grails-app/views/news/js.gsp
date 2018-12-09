<script>
    var backParams;
    function queryParams(params){
        params.keywords=$('#keywords').val();
        params.status=$('#status option:selected') .val();
        params.subCategory=$('#subCategory option:selected') .val();
        params.max=params.limit;
        backParams=params;
        return params;
    }

    function indexFormatter(value, row, index) {
        return index+1;
    }

    function titleFormatter(value, row, index) {
        return '<a href="javascript:showNews('+row.id+')">'+value+'</a>';
    }

    function operateFormatter(value, row, index) {
        var str = [];
        if(row.isSticky) {
            str.push('<a class="btn btn-primary" href="javascript:confirm(\'确认要执行此操作吗\', function() {changeNews('+row.id+',4)})">取消置顶</a>&nbsp;&nbsp;');
        } else {
            str.push('<a class="btn btn-primary" href="javascript:confirm(\'确认要执行此操作吗\', function() {changeNews('+row.id+',3)})">置顶</a>&nbsp;&nbsp;');
        }
        if(row.status == "发布"){
            str.push('<a class="btn btn-primary" href="javascript:confirm(\'确认要执行此操作吗\', function() {changeNews('+row.id+',2)})">撤回</a>&nbsp;&nbsp;');
        }else if(row.status == "草稿" || row.status == "撤回"){
            str.push('<a class="btn btn-primary" href="javascript:confirm(\'确认要执行此操作吗\', function() {changeNews('+row.id+',1)})">发布</a>&nbsp;&nbsp;');
        }
        str.push('<a class="btn btn-primary" href="javascript:editNews('+row.id+')">修改</a>&nbsp;&nbsp;');
        str.push('<a class="btn btn-primary" href="javascript:confirm(\'确认要删除吗？\', function(){delNews('+row.id+');})">删除</a>&nbsp;&nbsp;');
        return str.join('');
    }

    function doSearch() {
        $("#newsTable").bootstrapTable('refresh',[]);
    }

    function newNews() {
        loadRemotePage('${request.contextPath}/news/create',{categoryId:$('#categoryId').val()},'项目管理','',"新增");
    }

    function editNews(id) {
        loadRemotePage('${request.contextPath}/news/edit',{id:id,categoryId:$('#categoryId').val()},'项目管理','',"编辑");
    }

    function delNews(id) {
        $.post("${request.contextPath}/news/delNews",{newsId:id},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            if(data.result){
                $("#newsTable").bootstrapTable('refresh',[]);
            }
        },"json");
    }
    function ajaxDeletes(){
        var deleteRows = $('#newsTable').bootstrapTable('getSelections');
        if (deleteRows.length <= 0) {
            alert("请勾选要删除的${category?.name}");
        }else {
            confirm('确定删除选中的${category?.name}吗？', function() {
                var obj=new Object();
                var ids='';
                for (var i = 0; i < deleteRows.length; i++) {
                    if (ids != '') ids += ',';
                    ids += deleteRows[i].id;
                }
                obj.fileIds=ids;
                $.post("${request.contextPath}/news/ajaxDeletes",obj,function (data) {
                    $("#messageModalBody").html(data.message);
                    $("#messageModal").modal('show');
                    if(data.result){
                        $("#newsTable").bootstrapTable('refresh',[]);
                    }
                }, "json");
            });
        }
    }

    function saveOrUpdate(categoryId) {
        if($("#newsForm").valid()){
            var length = $(".nav-tabs").find("li").size();
            for(var i=0;i<length;i++){
                var projectOverview = CKEDITOR.instances['content'+i].getData();
                if(!projectOverview){
                    alert("【"+$(".nav-tabs").find("li").eq(i).text()+"】的值不能为空！");
                    $('.nav-tabs li:eq("'+i+'") a').tab('show');
                    return;
                }
            }

            $("#newsForm").form('submit', {
                url: "${request.contextPath}/news/saveOrUpdate",
                success: function (data) {
                    var data = eval('(' + data + ')');
                    $("#messageModalBody").html(data.message);
                    $("#messageModal").modal('show');
                    if (data.result) {
                        loadRemotePage('${request.contextPath}/news/list',{},'项目管理',"");
                    }
                }
            },"json");
        }
    }

    function showNews(id) {
        loadRemotePage('${request.contextPath}/news/show',{newsId:id},'项目管理','${category?.name}',"查看${category?.name}");
    }

    function changeNews(id,status) {
        $.post("${request.contextPath}/news/changeNews", {id: id, status: status}, function (data) {
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            if (data.result) {
                loadRemotePage('${request.contextPath}/news/list?categoryId=${category?.id}',{},'项目管理','${category?.name}');
            }
        }, "json");
    }

    $(function(){
        // 日期前后验证
        jQuery.validator.addMethod("dateCompare", function(value, element) {
            var date = $('input[name=publishDate]').val();
            if(date.length > 0 && value.length > 0){
                if(compareDate(date,value)){
                    return false;
                }else {
                    return true;
                }
            }else {
                return true;
            }
        }, "截止日期应大于开始日期");
        // 日期前后比较
        function compareDate(DateOne, DateTwo) {
            var OneMonth = DateOne.substring(5, DateOne.lastIndexOf("-"));
            var OneDay = DateOne.substring(DateOne.length, DateOne.lastIndexOf("-") + 1);
            var OneYear = DateOne.substring(0, DateOne.indexOf("-"));
            var TwoMonth = DateTwo.substring(5, DateTwo.lastIndexOf("-"));
            var TwoDay = DateTwo.substring(DateTwo.length, DateTwo.lastIndexOf("-") + 1);
            var TwoYear = DateTwo.substring(0, DateTwo.indexOf("-"));
            if (Date.parse(OneMonth + "/" + OneDay + "/" + OneYear) > Date.parse(TwoMonth + "/" + TwoDay + "/" + TwoYear)) {
                return true;
            } else {
                return false;
            }
        }
    });

    function resetnewsForm(){
        $("#newsForm input.w95").val("");
        $("#newsForm input.w200").val("");
        $("#newsForm .form-control.w200").val("true");
        CKEDITOR.instances['content'].setData("")
        $("#newsForm").validate().resetForm();
    }

    function deleteFile(fileId){
        $.post('${request.contextPath}/news/deleteAttachment',{id:fileId},function(data){
            if(data.result){
                $("#messageModalBody").html(data.message);
                $("#messageModal").modal('show');
                $('.attachment'+fileId).remove();
            }
        },'json');
    }
    function backManager(){                          //返回
        loadRemotePage('${request.contextPath}/news/list',backParams,'项目管理','');
    }
</script>