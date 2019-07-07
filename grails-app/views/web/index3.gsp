<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/js/echarts/echarts3.min.js"></script>

    <asset:javascript src="application" />
    <asset:javascript src="spring-websocket" />
    <style type="text/css">
    .checkbox-custom {
        position: relative;
        padding: 0 15px 0 25px;
        margin-bottom: 7px;
        margin-top: 0;
        display: inline-block;
    }
    /*
    将初始的checkbox的样式改变
    */
    .checkbox-custom input[type="checkbox"] {
        opacity: 0;/*将初始的checkbox隐藏起来*/
        position: absolute;
        cursor: pointer;
        z-index: 2;
        margin: -6px 0 0 0;
        top: 50%;
        left: 3px;
    }
    /*
    设计新的checkbox，位置
    */
    .checkbox-custom label:before {
        content: '';
        position: absolute;
        top: 50%;
        left: 0;
        margin-top: -9px;
        width: 19px;
        height: 18px;
        display: inline-block;
        border-radius: 2px;
        border: 1px solid #bbb;
        background: #fff;
    }
    /*
    点击初始的checkbox，将新的checkbox关联起来
    */
    .checkbox-custom input[type="checkbox"]:checked +label:after {
        position: absolute;
        display: inline-block;
        font-family: 'Glyphicons Halflings';
        content: "\e013";
        top: 42%;
        left: 3px;
        margin-top: -5px;
        font-size: 11px;
        line-height: 1;
        width: 16px;
        height: 16px;
        color: #333;
    }
    .checkbox-custom label {
        cursor: pointer;
        line-height: 1.2;
        font-weight: normal;/*改变了rememberme的字体*/
        margin-bottom: 0;
        text-align: left;
    }
    </style>
    <script type="text/javascript">
        var time1 = {};
        var time2 = {};
        var xx1 = {};
        var xx2 = {};
        var yy1 = {};
        var yy2 = {};
        var ydata_ = {};
        var leftChart={};
        var rightChart={};
        var leftOption={};
        var rightOption={};
        var data1Interval=0;
        var data2Interval=null;
        $(function() {


            var socket = new SockJS("${createLink(uri: '/stomp')}");
            var client = Stomp.over(socket);
            client.connect({}, function() {
                client.subscribe("/topic/data1", function(message) {
                    var data = JSON.parse(message.body);
                    if(typeof(data.data)!=='undefined'){
                        time1[data.key]= data.time;
                        setData1(data.key,data.data,data.beginTime);
                    }
                });
                client.subscribe("/topic/data2", function(message) {
                    var data = JSON.parse(message.body);
                    if(typeof(data.data)!=='undefined'){
                        time2[data.key]= data.time;
                        setData2(data.key,data.data);
                    }
                });
            });
            $("#start").click(function() {
                // client.send("/app/hello", {}, JSON.stringify("world1111"));
                startTask(client);
            });
        });
        function startTask(client) {
            var checks = $("input[name='chan']:checked");
            var data1Dom = $("#data1");
            var data2Dom = $("#data2");
            data1Dom.html("");
            data2Dom.html("");
            time1 = {};
            time2 = {};
            $.each(checks,function (k,v) {
                var devid = $(v).attr("data-dev");
                var chanCode = $(v).val();
                var obj = {};
                var key = devid+"_"+chanCode;
                obj.chanName = $(v).attr("data-chanName");
                obj.unit = $(v).attr("data-unit");
                obj.unitText = $(v).attr("data-unitText");
                data1Dom.append('<div id="leftChart'+key+'" style="height: 300px;width: 100%;"></div>');
                data2Dom.append('<div id="rightChart'+key+'" style="height: 300px;width: 100%;"></div>');
                xx1[key] = new Array();
                xx2[key] = new Array();
                yy1[key] = new Array();
                yy2[key] = new Array();
                ydata_[key] = new Array();
                leftChart[key] = echarts.init(document.getElementById('leftChart'+key));
                rightChart[key] = echarts.init(document.getElementById('rightChart'+key));
                initData1(key,obj);
                initData2(key,obj);
            });
            if(data1Interval) clearInterval(data1Interval);
            data1Interval = setInterval(function() {
                $.each(checks,function (k,v) {
                    var devid = $(v).attr("data-dev");
                    var chanCode = $(v).val();
                    var key = devid+"_"+chanCode;
                    client.send("/app/data1",{}, JSON.stringify({devid:devid,chanCode:chanCode,date:time1[key]}));
                });
            },'1000');
            //
            data2Interval =  setInterval(function() {
                $.each(checks,function (k,v) {
                    var devid = $(v).attr("data-dev");
                    var chanCode = $(v).val();
                    var key = devid+"_"+chanCode;
                    client.send("/app/data2",{}, JSON.stringify({devid:devid,chanCode:chanCode,date:time1[key]}));
                });
                // client.send("/app/data2",{}, JSON.stringify(obj));
            },'5000');
        }
        function initData1(key,obj) {
            leftOption[key] =
                {
                    "yAxis": [
                        {
                            "nameLocation": "middle",
                            "axisTick": {
                                "alignWithLabel": false
                            },
                            "scale": true,
                            "show": true,
                            "axisLabel": {
                                "textStyle": {
                                    "fontSize": 12
                                },
                                "interval": "auto",
                                "margin": 8,
                                "rotate": 0,
                                "formatter": "{value} "
                            },
                            "splitLine": {
                                "show": false
                            },
                            "boundaryGap": true,
                            "nameTextStyle": {
                                "fontSize": 14
                            },
                            name:obj.unitText+'('+obj.unit+')',
                            nameLocation:'middle',
                            nameGap:35,
                            nameTextStyle:{
                                fontSize:16,
                                fontWeight:'bolder'
                            },
                            "inverse": false,
                            "splitArea": {
                                "show": false
                            },
                            min:1,
                            max:-1,
                            "type": "value"
                        }
                    ],
                    "color": [
                        "#006400"
                        // "#c23531"
                    ],
                    "series": [
                        {
                            "seriesId": 4247545,
                            "markLine": {
                                "data": []
                            },
                            "name": "",
                            // "name": "\u7b14",
                            %{--"data": yy${obj.chanCode},--}%
                            "data": [],
                            "symbol": "none",
                            "smooth": false,
                            "label": {
                                "emphasis": {
                                    "textStyle": {
                                        "fontSize": 12
                                    },
                                    "show": true
                                },
                                "normal": {
                                    "position": "top",
                                    "textStyle": {
                                        "fontSize": 12
                                    },
                                    "show": false
                                }
                            },
                            "step": false,
                            "yAxisIndex": 0,
                            "symbolSize": 4,
                            "markPoint": {
                                "data": []
                            },
                            "areaStyle": {
                                "opacity": 0
                            },
                            "lineStyle": {
                                "normal": {
                                    "opacity": 1,
                                    "width": 1,
                                    "type": "solid",
                                    "curveness": 0
                                }
                            },
                            "xAxisIndex": 0,
                            "type": "line",
                            "showSymbol": true
                        }
                    ],
                    "title": [
                        {
                            subtext:obj.chanName+obj.unitText+'实时波形曲线',
                            subtextStyle:{
                                color:'#000000',
                                fontSize:16,
                                fontWeight:'bolder'
                            },
                            x: 'center'
                        }
                    ],
                    "tooltip": {
                        "borderColor": "#333",
                        "axisPointer": {
                            "type": "cross"
                        },
                        "textStyle": {
                            "fontSize": 14
                        },
                        "trigger": "axis",
                        "borderWidth": 0,
                        "backgroundColor": "rgba(50,50,50,0.7)",
                        "triggerOn": "mousemove|click"
                    },
                    "series_id": 4247545,
                    "xAxis": [
                        {
                            "nameLocation": "middle",
                            "axisTick": {
                                "alignWithLabel": false
                            },
                            "scale": true,
                            "show": true,
                            "type": "category",
                            "axisLabel": {
                                "textStyle": {
                                    "fontSize": 12
                                },
                                formatter: function (value, index) {
                                    return value.substring(11);
                                },
                                "interval": "auto",
                                "margin": 8,
                                "rotate": 0
                            },
                            "splitLine": {
                                "show": false
                            },
                            "boundaryGap": false,
                            "nameTextStyle": {
                                "fontSize": 14
                            },
                            "nameGap": 80,
                            "inverse": false,
                            "data":[]
                            %{--"data": xx${obj.chanCode}--}%
                        }
                    ],
                    "dataZoom": [
                        {
                            "start": 0,
                            "end": 3000,
                            "type": "slider",
                            "orient": "horizontal",
                            "show": false
                        },
                        {
                            "start": 0,
                            "show": false,
                            "end": 3000,
                            "orient": "horizontal",
                            "type": "inside"
                        }
                    ],
                    "legend": [
                        {
                            "textStyle": {
                                "fontSize": 12
                            },
                            "show": false,
                            "top": "top",
                            "selectedMode": "multiple",
                            "data": [
                                "\u7b14"
                            ],
                            "orient": "horizontal",
                            "left": "center"
                        }
                    ]
                };
            leftChart[key].setOption(leftOption[key]);
        }
        function initData2(key,obj) {
            rightOption[key]={
                backgroundColor: "#fff",
                color: ["#006400"],
                title:{
                    subtext:obj.chanName+obj.unitText+'频谱曲线',
                    subtextStyle:{
                        color:'#000000',
                        fontSize:16,
                        fontWeight:'bolder'
                    },
                    x: 'center'

                },
                tooltip: {
                    trigger: 'axis'
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: [],
                    axisLabel:{
                        formatter: function (value, index) {
                            return Math.ceil(Number(value));
                        }
                    }
                },
                yAxis: {
                    // x: 'center',
                    type: 'value',
                    name:obj.unitText+'('+obj.unit+')',
                    nameLocation:'middle',
                    nameGap:30,
                    splitLine: {show: false},
                    nameTextStyle:{
                        fontSize:16,
                        fontWeight:'bolder'
                    }
                },
                series: [{
                    name: '',
                    type: 'line',
                    symbol: "none",
                    data: []
                }]
            };
            rightChart[key].setOption(rightOption[key]);
        }
        Date.prototype.format = function(format) {
            var date = {
                "M+": this.getMonth() + 1,
                "d+": this.getDate(),
                "h+": this.getHours(),
                "m+": this.getMinutes(),
                "s+": this.getSeconds(),
                "q+": Math.floor((this.getMonth() + 3) / 3),
                "S+": this.getMilliseconds()
            };
            if (/(y+)/i.test(format)) {
                format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
            }
            for (var k in date) {
                if (new RegExp("(" + k + ")").test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1
                        ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
                }
            }
            return format;
        };
        function setData1(key,data_,beginTime){
            if(data_.length==0){
                return;
            }
            for (var i = 0; i <data_.length ; i++) {
                var v = data_[i];
                xx1[key].push(new Date(Date.parse(beginTime)+(i+1)*5).format('yyyy-MM-dd h:m:s.S'));
                ydata_[key].push(v);
                yy1[key].push(v);
            }

            var len = xx1[key].length - 2000;
            if(xx1[key].length>2000){
                xx1[key].splice(0,len)
            }
            if(yy1[key].length>2000){
                yy1[key].splice(0,len)
            }
            if(ydata_[key].length>2000){
                ydata_[key].splice(0,len)
            }
            var max = Math.max.apply(null,ydata_[key]);
            var min = Math.min.apply(null,ydata_[key]);
            if(Math.abs(max) < Math.abs(min)){
                max =   Math.abs(min);
            }
            max = Math.ceil(max);
            min = -max;
            leftChart[key].setOption({
                series: [{
                    name:'AQI',
                    data: yy1[key]
                }],
                yAxis:[{
                    min:min,
                    max:max
                }],
                xAxis:[{
                    data:xx1[key]
                }
                ]
            });
        }
        function setData2(key,data_){
            if(typeof(data_)=="undefined"){
                return;
            }
            var xx2 = new Array();
            var yy2 = new Array();
            $.each(data_,function(k,v){
                xx2.push(v.x);
                yy2.push(v.y);
            });
            rightChart[key].setOption({
                series: [{
                    data: yy2
                }],
                xAxis:[{
                    data:xx2
                }
                ]
            });
        }
        function stopTask(){
            if(data1Interval) clearInterval(data1Interval);
            if(data2Interval) clearInterval(data2Interval);
        }
    </script>
</head>
<body>
<div class="panel panel-info">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion"
               href="#collapseThree">
                选择通道信息，实时展示波形或频谱信息
            </a>
        </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse in" aria-expanded="true">
        <div class="panel-body">
            <g:each in="${list}" var="point">
                <g:set var="pointList" value="${networkmonitoring.Passageway.findAllByMeasuringPoint(point)}"></g:set>
                <span style="font-weight: bolder;">${point.name}</span>&nbsp;&nbsp;
                <g:each in="${pointList}" var="obj">
                    <g:checkBox data-dev="${obj.measuringPoint?.devid}" data-unit="${obj.unit}" checked="false" data-chanName="${obj.chanName}" data-unitText="${obj.unitText}" name="chan" value="${obj.chanCode}"></g:checkBox>&nbsp;${obj.chanName}&nbsp;&nbsp;
                </g:each>
            </g:each>
        </div>
        <div class="panel-footer">
            <button id="start"  class="btn btn-success">开始</button>
            <button id="stop" onclick="stopTask();" class="btn btn-danger">停止</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <div class="checkbox-custom checkbox-default" >
                <input type="checkbox" id="showType1" disabled checked>
                <label for="showType1">双显</label>
            </div>
            <div class="checkbox-custom checkbox-default" onclick="location.href='${request.contextPath}/web/index6/${params.id}'">
                <input type="checkbox" id="showType2">
                <label for="showType2">重叠</label>
            </div>
        </div>
    </div>
</div>

<div class="child">
    <div class="col-xs-12 col-sm-6" id="data1"></div>
    <div class="col-xs-12 col-sm-6" id="data2"></div>
</div>
</body>
</html>