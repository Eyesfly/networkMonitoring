
<div style="margin-top:10px;">
    <ul class="nav nav-tabs  vertical-tab">
        <g:each in="${newsContentList}" var="obj">
            <li>
                <a href="#div${obj.sort}" data-toggle="tab">
                    ${obj.name}
                </a>
            </li>
        </g:each>
    </ul>
    <div class="tab-content vertical-tab-content">
        <g:each in="${newsContentList}" var="obj">
            <div class="tab-pane fade in active" id="div${obj.sort}">
                ${raw(obj?.content)}
            </div>
        </g:each>
    </div>
</div>