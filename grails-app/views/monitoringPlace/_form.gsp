
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
            <input id="picture" name="picture" type="file" class="form-control" />
            <g:if test="${obj.picture}">
                <img src="${request.contextPath}/monitoringPlace/picture/${obj?.id}">
            </g:if>
        </div>
    </div>
    %{--<div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 所在地区：</div>
        <div class="col-8">
            <input id="area" name="area.id" class="form-control"  value="${obj?.area?.id}"/>
        </div>
    </div>--}%
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 详细地址：</div>
        <div class="col-8">
            <input id="address" name="address" class="form-control"  value="${obj?.address}"/>
        </div>
    </div>
</form>
