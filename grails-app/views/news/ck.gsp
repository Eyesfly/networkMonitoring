<ckeditor:config var="toolbar_Mytoolbar">
    [
        [ 'RemoveFormat', 'Styles','Format','Font','FontSize','lineheight', '-', 'TextColor', 'BGColor', 'Bold', 'Italic', '-', 'Paste', 'PasteText', '-', 'Link', 'Unlink', '-','Image','Flash','-'],
        [ 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']
    ]
</ckeditor:config>
<div class="tab-pane fade in" id="div${params.id}" data-id="${params.id}">
    <div style="margin:20px 0px;">
        <input type="hidden" name="projectId" value="${params.projectId}">
        <input type="hidden" name="projectName" value="${params.name}">
        <ckeditor:editor userSpace="${com.eyesfly.core.BaseUser.findByUsername(sec.username())?.id}" name="content" id="content${params.id}" toolbar="Mytoolbar" height="300px" width="95%" fileBrowser="default"></ckeditor:editor>
    </div>
</div>