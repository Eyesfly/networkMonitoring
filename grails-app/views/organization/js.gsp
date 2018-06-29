<script>
    var tree=$("#orgTreeDiv");
    $(function () {
        initTree(tree,"${request.contextPath}/organization/orgJson?type=1");
    });
    function initTree(tree,url){
        tree.jstree({
            'core' : {
                'data': {
                    'url': url,
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
            "plugins": ["types","wholerow","contextmenu"]
        });
    }
</script>