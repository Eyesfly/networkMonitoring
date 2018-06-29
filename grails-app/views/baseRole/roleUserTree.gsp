<script type="text/javascript">
    var tree=$("#roleUserTreeDiv");
    $(function () {
        %{--initTree(tree,"${request.contextPath}/baseRole/roleUserTreeJson?roleType=2");--}%
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
            "plugins": ["types","wholerow","checkbox"]
        });
    }
</script>
<input type="hidden" id="permission" />
<div id="roleUserTreeDiv" style="margin-top: 10px;"></div>
