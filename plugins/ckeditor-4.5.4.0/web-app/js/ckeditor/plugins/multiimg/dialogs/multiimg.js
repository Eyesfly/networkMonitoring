(function() {
    CKEDITOR.dialog.add("multiimg",
        function(a) {
        var num = Math.floor(Math.random()*1000+1);
        var url = a.config.filebrowserImageBrowseUrl+"&CKEditor="+a.name+"&CKEditorFuncNum="+num+"&multiimg=1&langCode=zh-cn";
           // window.open("ck/ofm?fileConnector=/networkMonitoring/ck/ofm/filemanager&type=Image&space=1&viewMode=grid&CKEditor="+a.name+"&CKEditorFuncNum=1&langCode=zh-cn");
            return {
                title: "批量上传图片",
                minWidth: "820px",
                minHeight:"400px",
                contents: [{
                    id: "tab1",
                    label: "",
                    title: "",
                    expand: true,
                    width: "820px",
                    height: "400px",
                    padding: 0,
                    elements: [{
                        type: "html",
                        style: "width:820px;height:400px",
                        html: '<iframe id="uploadFrame" name="uploadFrame" src="'+url+'" frameborder="0"></iframe>'
                    }]
                }],
                // when the dialog ended width ensure,"onOK" will be executed.
                onOk: function() {
                    // window.open("ck/ofm?fileConnector=/networkMonitoring/ck/ofm/filemanager&type=Image&space=1&viewMode=grid&CKEditor="+a.name+"&CKEditorFuncNum=1&langCode=zh-cn");
                    var ins = a;
                    var imges = window.parent.document.getElementById('uploadFrame').contentWindow.imgs;
                    var imgUrl = window.parent.document.getElementById('uploadFrame').contentWindow.imgUrl;
                    var imgHtml = "";
                    $.each(imges,function(k,v){
                        imgHtml+= "<p><img src='"+imgUrl+v+"'/></p>";
                    });
                    ins.insertHtml(imgHtml);
                    $(".cke_editor_"+a.name+"_dialog").remove();
                    $(".cke_dialog_background_cover").remove();
                },
                onShow: function () {
                    document.getElementById("uploadFrame").setAttribute("src",url);
                }
            }
        })
})();