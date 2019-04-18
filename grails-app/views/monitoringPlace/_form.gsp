
<form id="infoForm" method="post" enctype="multipart/form-data">
    <input id="id" type="hidden" name="id" class="form-control" value="${obj?.id}"/>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 名称：</div>
        <div class="col-8">
            <input id="name" name="name" class="form-control"  value="${obj?.name}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 地理经度：</div>
        <div class="col-8">
            <input id="lng" name="lng" class="form-control"  value="${obj?.lng}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 地理纬度：</div>
        <div class="col-8">
            <input id="lat" name="lat" class="form-control"  value="${obj?.lat}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 联系人：</div>
        <div class="col-8">
            <input id="contact" name="contact" class="form-control" value="${obj?.contact}" />
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 电话：</div>
        <div class="col-8">
            <input id="phone" name="phone" class="form-control"  value="${obj?.phone}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 邮箱：</div>
        <div class="col-8">
            <input id="email" name="email" class="form-control"  value="${obj?.email}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 图片：</div>
        <div class="col-8">
            <input id="picture" name="picture" type="file" class="form-control" style="display: inline;width: 90%;" />
            <g:if test="${obj.picture}">
                 <a href="${request.contextPath}/monitoringPlace/picture/${obj?.id}" target="_blank">预览</a>
            </g:if>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 所在地区：</div>
        <div class="col-8">
            <input id="area" type="hidden" name="area.id" value="${obj?.area?.id}">
            <input id="areaTxt" readonly onclick="showOrgModal();"  class="form-control"  value="${obj?.area?.name}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 详细地址：</div>
        <div class="col-8">
            <input id="address" name="address" class="form-control"  value="${obj?.address}"/>
        </div>
    </div>
</form>

<div class="modal" id="orgUserModal" tabindex="-1" role="dialog" aria-labelledby="orgUserModalHead" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" onclick="$('#orgUserModal').modal('hide')"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">选择地区</h4>
            </div>
            <div class="modal-body" id="orgUserModalBody">

            </div>
            <div class="modal-footer">
                <button class="btn btn-blue margin" type="button" onclick="$('#orgUserModal').modal('hide')" >确定</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function showOrgModal(){
        $.post("${request.contextPath}/monitoringPlace/orgTree",{},function(data){
            $("#orgUserModalBody").html(data);
            $("#orgUserModal").modal('show');
        },"html");
    }
</script>