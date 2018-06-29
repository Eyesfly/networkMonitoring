<div class="mt10">
    <div class="info">
        <div class="padd100">
            <div class="row1">
                <div class="col-1"><b>用户名：</b></div>
                <div class="col-9">${baseUser?.username}</div>
            </div>
            <div class="row1">
                <div class="col-1"><b>单位名称：</b></div>
                <div class="col-9">${baseUser?.organization?.name}</div>
            </div>
            <div class="row1">
                <div class="col-1"><b>用户姓名：</b></div>
                <div class="col-9">${baseUser?.realName}</div>
            </div>

            <div class="row1">
                <div class="col-1"><b>手机号码：</b></div>
                <div class="col-9">${baseUser?.mobile}</div>
            </div>
            <div class="row1">
                <div class="col-1"><b>允许登录：</b></div>
                <div class="col-9">${baseUser?.enabled?"是":"否"}</div>
            </div>
        </div>
    </div>
</div>
<div class="text-center" style="margin-top: 10px;">
    <button type="button" class="butn butn-add" onclick="backUserManager();"><img src="${request.contextPath}/images/htgl/table_arrow.png" alt=""> 返回</button>　
</div>
