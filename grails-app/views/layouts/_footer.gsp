<div class="footer">
    <div class="w1200">
        <div class="footer_sj">
            <span>版权所有： 最高人民检察院</span>
            <span>　备案序号：京ICP备10217144号</span>
        </div>
    </div>
</div>



<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="notAuthModalLabel" id="alertModal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" style="width: 300px;margin:200px auto;">
            <div class="tck message" style="width: 300px;height: 200px;">
                <div class="tsxx">
                    <span class="title">提示信息</span>
                    <div id="alertContent"></div>
                    <div style="width:210px; margin: 0 30px;position: absolute;">
                        <div  id="yesButton" style="margin:30px auto 10px;width: 100px; height:34px;background-color: #e7e9eb;line-height: 34px;text-align: center;cursor: pointer;float: left;" data-dismiss="modal">
                            <a style="margin-top:10px;" href="javascript:void(0);">确定</a>
                        </div>
                        <div  id="noButton" style="margin:30px auto 10px;width: 100px; height:34px;background-color: #e7e9eb;line-height: 34px;text-align: center;cursor: pointer;float: right;display: none;" data-dismiss="modal">
                            <a style="margin-top:10px;" href="javascript:void(0);">关闭</a>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
   /* function alert(content,callback){
        $("#alertContent").html(content);
        $("#alertModal").modal("show");
        $("#yesButton").css('float','');
        $("#noButton").hide();
        $("#yesButton").unbind("click");
        if (typeof callback === "function") {
            // Execute the callback function and pass the parameters to it
            $("#yesButton").click(function(){
                callback();
            });
        }

    }*/
   /* function confirm(content,callback){
        $("#alertContent").html(content);
        $("#alertModal").modal("show");
        $("#yesButton").css('float','left');
        $("#yesButton").unbind("click");
        if (typeof callback === "function") {
            // Execute the callback function and pass the parameters to it
            $("#yesButton").click(function(){
                callback();
            });
        }
        $("#noButton").show();
    }*/
</script>