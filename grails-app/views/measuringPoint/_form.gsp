
<form id="infoForm" method="post" enctype="multipart/form-data">
    <input id="id" type="hidden" name="id" class="form-control" value="${obj?.id}"/>
    <input id="monitoringPlace" type="hidden" name="monitoringPlace.id" class="form-control" value="${obj?.monitoringPlace?.id?:place?.id}"/>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 设备名称：</div>
        <div class="col-8">
            <input id="name" name="name" class="form-control"  value="${obj?.name}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 设备标识：</div>
        <div class="col-8">
            <input id="devid" name="devid" class="form-control"  value="${obj?.devid}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 设备IP：</div>
        <div class="col-8">
            <input id="ip" name="ip" class="form-control"  value="${obj?.ip}"/>
        </div>
    </div>

</form>
