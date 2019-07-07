<style type="text/css">
 .col-6{width: 60%;float: left;}
</style>
<script type="text/javascript">
    var obj = {"1":["m/s²", "cm/s²", "mm/s²"],"2":["m", "cm", "mm"],"3":["m/s", "cm/s", "mm/s"]};
    $(function () {
        selectType($("#type"));
        $("#unit").find("option[value='${obj?.unit}']").attr("selected", "selected");
        selectUnit($("#unit"));
    });
    function selectType(dom) {
        switch ($(dom).val()) {
            case '1':optionHtml("1"); break;
            case '2':optionHtml("2"); break;
            case '3':optionHtml("3"); break;
        }
    }
    function optionHtml(key){
        var option = "";
        $.each(obj[key],function (k,v) {
            option += "<option value='"+v+"'>"+v+"</option>";
        });
        $("#unit").html(option);
        selectUnit($("#unit"));
    }

    function selectUnit(dom) {
        var val =  $(dom).val();
        $("#thresholdText").html(val);
        $("#sensitivityText").html("mv/"+val);
    }
</script>
<form id="infoForm" method="post" enctype="multipart/form-data">
    <input id="id" type="hidden" name="id" class="form-control" value="${obj?.id}"/>
    <input id="measuringPoint" type="hidden" name="measuringPoint.id" class="form-control" value="${obj?.measuringPoint?.id?:point?.id}"/>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道名称：</div>
        <div class="col-6">
            <input id="chanName" required name="chanName" class="form-control"  value="${obj?.chanName}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道代码：</div>
        <div class="col-6">
            <input id="chanCode" required name="chanCode" class="form-control"  value="${obj?.chanCode}"/>
        </div>
    </div>
     <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道类型：</div>
        <div class="col-6">
            <g:select name="type" from="[[id:1,name:'加速度'],[id:2,name:'位移'],[id:3,name:'速度']]" optionValue="name" optionKey="id" onchange="selectType(this);" value="${obj?.type}" ></g:select>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道单位：</div>
        <div class="col-6">
            <select name="unit" id="unit" onchange="selectUnit(this);"></select>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 阈值：</div>
        <div class="col-6">
            <input id="threshold" name="threshold" required class="form-control" style="display: inline;"  value="${obj?.threshold}"/>
        </div>
        <div class="col-1 text-left" style="padding-left: 20px;" id="thresholdText">cm/s²</div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 灵敏度：</div>
        <div class="col-6">
            <input id="sensitivity" name="sensitivity" required class="form-control"  value="${obj?.sensitivity}"/>
        </div>
        <div class="col-2 text-left" style="padding-left: 20px;" id="sensitivityText">mv/cm/s²</div>
    </div>
</form>


