
<script type="text/javascript">
    $(function () {
        $("#orgUserTreeDiv").on('select_node.jstree', function (e, data) {
            $("#areaTxt").val(data.node.text);
            $("#area").val(data.node.id);
        }).jstree({
            'core' : {
                'data': {
                    'url': "${request.contextPath}/monitoringPlace/orgJson?roleId=${role?.id}",
                    "dataType": "json",
                    'data' : function (node) {
                        return { 'id' : node.id,areaId:$("#area").val() };
                    }
                },
                "multiple": false//单选
            },
            "types" : {
                "user" : {
                    "icon" : "fa fa-user"
                },
                "org" : {
                    "icon" : "glyphicon glyphicon-folder-open"
                }
            },
            "checkbox": {
                "three_state": false
            },
            "plugins": ["types","wholerow","checkbox" ]
        });
    });

</script>
<div id="orgUserTreeDiv" style="margin-top: 10px;max-height: 400px;overflow-y: scroll;"></div>
