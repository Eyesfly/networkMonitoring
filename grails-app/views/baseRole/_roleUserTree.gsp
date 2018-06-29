<style type="text/css">
.jstree-children{
    padding:0px !important;
}
.jstree-default .jstree-icon:empty{
        width:15px;
    }
</style>
<script type="text/javascript">
    var tree=$("#roleUserTreeDiv");
    function initTree(tree,url){
        $("#permissionText").val("");
        $("#permission").val("");
        tree.on('changed.jstree', function (e, data) {

            var permission = [];
            if(data.instance.get_node(data.selected[0]).type=="role"){
                $.each(data.selected,function(k,v) {
                    permission.push(data.instance.get_node(v).id);
                    $("#permissionText").val(data.instance.get_node(v).text);
                });
                $("#permission").val(permission.join(","));
            }
        }).jstree({
            'core' : {
                'data': {
                    'url': url,
                    "dataType": "json",
                    'data' : function (node) {
                        return { 'id' : node.id };
                    }
                },
                "multiple": false//单选
            },
            "types" : {
                "org" : {
                    "icon" : "glyphicon glyphicon-folder-open"
                },
                "category" : {
                    "icon" : "fa fa-ticket"
                },
                "role" : {
                    "icon" : "fa fa-users"
                },
                "user" : {
                    "icon" : "fa fa-user"
                }
            },
            "checkbox": {
                "three_state": false
            },
            "plugins": ["types","wholerow"]
        });
    }
</script>
<span class="text gjc">
    <input type="text" id="permissionText" readonly style=" width: 70%;height: 32px; line-height: 32px;padding-left: 10px; border: 1px solid #e5e5e5; font-size: 16px;font-family: '微软雅黑','宋体';"/>
    <input type="button" value="选择" onclick='$("#treeModal").modal("show");' style="width: 50px;height: 30px;"/>
    <input type="hidden" id="permission" />

</span>
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="notAuthModalLabel" id="treeModal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" style="width: 350px;margin:20px auto;">
            <div class="tck orgTree" style="width: 350px;">
                <div class="">
                    <span class="title" style="font-size: 24px;text-align: center;color: #034766;margin:10px 5px;display: block;">请选择任务组</span>
                    <div id="treeContent" style="height: 350px;overflow: auto;">
                        <div id="roleUserTreeDiv" style="margin-top: 10px;margin-left:40px;"></div>
                    </div>
                    <div  style="margin:10px auto;width: 100px; height:34px;background-color: #e7e9eb;line-height: 34px;text-align: center;cursor: pointer;" data-dismiss="modal">
                        <a style="margin-top:10px;" href="javascript:void(0);">确定</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>