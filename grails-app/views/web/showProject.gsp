
<div style="margin-top:10px;">
    <ul class="nav nav-tabs  vertical-tab">
        <li class="active">
            <a href="#projectOverview" data-toggle="tab">
                项目概况
            </a>
        </li>
        <li>
            <a href="#result1" data-toggle="tab">第一次场地测试结果</a>
        </li>
        <li>
            <a href="#result2" data-toggle="tab">第二次场地测试结果</a>
        </li>
        <li>
            <a href="#result3" data-toggle="tab">第三次场地测试结果</a>
        </li>
        <li>
            <a href="#result4" data-toggle="tab">第四次场地测试结果</a>
        </li>
        <li>
            <a href="#result5" data-toggle="tab">施工后测试</a>
        </li>
    </ul>
    <div class="tab-content vertical-tab-content">
        <div class="tab-pane fade in active" id="projectOverview">
            ${raw(news?.projectOverview)}
        </div>
        <div class="tab-pane fade" id="result1">
            ${raw(news?.result1)}
        </div>
        <div class="tab-pane fade" id="result2">
            ${raw(news?.result2)}
        </div>
        <div class="tab-pane fade" id="result3">
            ${raw(news?.result3)}
        </div>
        <div class="tab-pane fade" id="result4">
            ${raw(news?.result4)}
        </div>
        <div class="tab-pane fade" id="result5">
            ${raw(news?.result5)}
        </div>
    </div>
</div>