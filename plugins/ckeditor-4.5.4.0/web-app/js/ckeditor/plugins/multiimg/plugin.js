(function() {
    CKEDITOR.plugins.add("multiimg", {
        requires: ["dialog"],
        init: function(a) {
            a.addCommand("multiimg", new CKEDITOR.dialogCommand("multiimg"));
            a.ui.addButton("multiimg", {
                label: "批量上传图片",//调用dialog时显示的名称
                command: "multiimg",
                icon: this.path + "images/upload.png" //the icon in toolbar
            });
            CKEDITOR.dialog.add("multiimg", this.path + "dialogs/multiimg.js");
        }

    })

})();
