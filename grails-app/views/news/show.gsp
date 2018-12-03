<div class="mt10">
    <div class="info">
        <div class="padd100">
            <div class="row1">
                <div class="col-1"><b>项目名称：</b></div>
                <div class="col-9">${news?.name}</div>
            </div>
            <div class="row1">
                <div class="col-1"><b>发布时间：</b></div>
                <div class="col-9">${news?.publishDate?.format('yyyy年MM月dd日')}</div>
            </div>

            <ul class="nav nav-tabs  vertical-tab">
                <li class="active">
                    <a href="#projectOverview" data-toggle="tab">
                        项目概况
                    </a>
                </li>
                <li>
                    <a href="#result1" data-toggle="tab">第一次场地<br/>测试结果</a>
                </li>
                <li>
                    <a href="#result2" data-toggle="tab">第二次场地<br/>测试结果</a>
                </li>
                <li>
                    <a href="#result3" data-toggle="tab">第三次场地<br/>测试结果</a>
                </li>
                <li>
                    <a href="#result4" data-toggle="tab">第四次场地<br/>测试结果</a>
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
    </div>
</div>

<div class="text-center" style="margin-top: 50px;">
    <button type="button" class="butn butn-add" onclick="backManager();"><img src="${request.contextPath}/images/htgl/table_arrow.png" alt=""> 返回</button>　
</div>
