CKEDITOR.editorConfig = function( config )
{
//config.pasteFromWordIgnoreFontFace = true; //默认为忽略格式
    config.pasteFromWordRemoveFontStyles = true;
    config.pasteFromWordRemoveStyles = true;
    config.image_previewTex='';
    config.font_names='宋体/SimSun;新宋体/NSimSun;仿宋_GB2312/FangSong_GB2312;楷体/KaiTi;楷体_GB2312/KaiTi_GB2312;黑体/SimHei;微软雅黑/Microsoft YaHei;'+ config.font_names;
    config.extraPlugins += (config.extraPlugins ? ',lineheight' : 'lineheight');
    config.extraPlugins += (config.extraPlugins ? ',multiimg' : 'multiimg');
    config.disallowedContent = 'img{width,height};img[width,height]';
};
CKEDITOR.config.image_previewTex=' ';
