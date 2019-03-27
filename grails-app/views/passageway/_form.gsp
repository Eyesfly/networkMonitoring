
<form id="infoForm" method="post" enctype="multipart/form-data">
    <input id="id" type="hidden" name="id" class="form-control" value="${obj?.id}"/>
    <input id="measuringPoint" type="hidden" name="measuringPoint.id" class="form-control" value="${obj?.measuringPoint?.id?:point?.id}"/>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道名称：</div>
        <div class="col-8">
            <input id="chanName" name="chanName" class="form-control"  value="${obj?.chanName}"/>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道代码：</div>
        <div class="col-8">
            <input id="chanCode" name="chanCode" class="form-control"  value="${obj?.chanCode}"/>
        </div>
    </div>
     <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道类型：</div>
        <div class="col-8">
            <g:select name="type" from="[[id:1,name:'加速度'],[id:2,name:'位移'],[id:3,name:'速度']]" optionValue="name" optionKey="id" onchange="selectUnit(this);" value="${obj?.type}" ></g:select>
        </div>
    </div>
    <div class="row1">
        <div class="col-2 text-right"><span class="text-red">*</span> 通道单位：</div>
        <div class="col-8">
            <select name="unit" id="unit"></select>
        </div>
    </div>
</form>

<script type="text/javascript">
    var obj = {"1":["m/s²", "cm/s²", "mm/s²"],"2":["m", "cm", "mm"],"3":["m/s", "cm/s", "mm/s"]};
    $(function () {
        selectUnit($("#type"));
        $("#unit").find("option[text='cm']").attr("selected", "selected");
    });
    function selectUnit(dom) {
        switch ($(dom).val()) {
            case '1':optionHtml("1"); break;
            case '2':optionHtml("2"); break;
            case '3':optionHtml("3"); break;
        }
    }
    function optionHtml(key){
        var option = "";
        $.each(obj[key],function (k,v) {
            option += "<option>"+v+"</option>";
        });
        $("#unit").html(option);
    }
</script>
