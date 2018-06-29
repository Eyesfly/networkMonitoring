<script type="text/javascript">
    var tree=$("#menuTreeDiv");
    $(function () {
        initTree(tree,"${request.contextPath}/baseRole/menuJson/${role?.id}");
    });
    function initTree(tree,url){
        tree.on('changed.jstree', function (e, data) {
            var permission = [];
            $.each(data.selected,function(k,v) {
                permission.push(data.instance.get_node(v).id);
            });
            $("#permission").val(permission.join(","));
        }).jstree({
            'core' : {
                'data': {
                    'url': url,
                    "dataType": "json"
                }
            },
            "types" : {
                "root" : {
                    "icon" : "glyphicon glyphicon-folder-open"
                }
            },
            "plugins": ["types","wholerow","checkbox"]
        });
    }
    function saveConfigure(){
        $.post("${request.contextPath}/baseRole/saveConfigure",{roleId:$('#roleId').val(),permission:$("#permission").val()},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            $("#treeModal").modal('hide');
        },"json");
    }
</script>
<input type="hidden" id="roleId" value="${role?.id}"/>
<input type="hidden" id="permission" />
<div id="menuTreeDiv" style="margin-top: 10px;"></div>
