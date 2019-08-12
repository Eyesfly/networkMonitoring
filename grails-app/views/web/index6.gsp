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
        var time = {};
        var xx1 = new Array();
        var yy1 = new Array();
        var yy2 = new Array();
        var leftChart;
        var leftOption;
        var data1Interval=0;
        var showText = '波形对比';
        $(function() {
            var socket = new SockJS("${createLink(uri: '/stomp')}");
            var client = Stomp.over(socket);
            client.connect({}, function() {
                client.subscribe("/topic/data11", function(message) {
                    var data = JSON.parse(message.body);
                    if(typeof(data.data)!=='undefined'){
                        time= data.time;
                        setData1(data.data,data.beginTime);
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
            data1Dom.html("");
            time1 = {};
            time2 = {};
            data1Dom.append('<div id="leftChart" style="height: 300px;width: 100%;"></div>');
            leftChart= echarts.init(document.getElementById('leftChart'));
            var obj = new Object();
            var devidArr = new Array();
            var chanCodeArr = new Array();
            var chanNames =  new Array();
            $.each(checks,function (k,v) {
                var devid = $(v).attr("data-dev");
                var chanCode = $(v).val();
                devidArr.push(devid);
                chanCodeArr.push(chanCode);
                chanNames.push($(v).attr("data-chanName"));
            });
            obj.devid = devidArr.join(",");
            obj.chanCode = chanCodeArr.join(",");
            showText=chanNames.join(",")+"波形对边";
            initData1();
            if(data1Interval) clearInterval(data1Interval);
            data1Interval = setInterval(function() {
                obj.date = time;
                client.send("/app/data11",{}, JSON.stringify(obj));
            },'2000');
        }
        function initData1() {
            leftOption=
                {
                    "yAxis":
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
                            name:showText,
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
                    ,
                    "color": [
                        "#006400",
                        "#c23531"
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
                            animation:false,
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
                        },{
                            "seriesId": 4247546,
                            "markLine": {
                                "data": []
                            },
                            "name": "",
                            // "name": "\u7b14",
                            %{--"data": yy${obj.chanCode},--}%
                            "data": [],
                            animation:false,
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
                            subtext:'实时波形曲线',
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
                            name:'时间(时/分/秒/毫秒)',
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
                            "nameTextStyle": {
                                "fontSize": 14,
                                fontWeight:'bolder'
                            },
                            "nameGap": 10,
                            "inverse": false
                            //"data":["2019/04/01 20:31:39.783731","2019/04/01 20:31:39.788731","2019/04/01 20:31:39.793731","2019/04/01 20:31:39.798731","2019/04/01 20:31:39.803731","2019/04/01 20:31:39.808731","2019/04/01 20:31:39.813731","2019/04/01 20:31:39.818731","2019/04/01 20:31:39.823731","2019/04/01 20:31:39.828731","2019/04/01 20:31:39.833731","2019/04/01 20:31:39.838731","2019/04/01 20:31:39.843731","2019/04/01 20:31:39.848731","2019/04/01 20:31:39.853731","2019/04/01 20:31:39.858731","2019/04/01 20:31:39.863731","2019/04/01 20:31:39.868731","2019/04/01 20:31:39.873731","2019/04/01 20:31:39.878731","2019/04/01 20:31:39.883731","2019/04/01 20:31:39.887731","2019/04/01 20:31:39.892731","2019/04/01 20:31:39.897731","2019/04/01 20:31:39.902731","2019/04/01 20:31:39.907731","2019/04/01 20:31:39.912731","2019/04/01 20:31:39.917731","2019/04/01 20:31:39.922731","2019/04/01 20:31:39.927731","2019/04/01 20:31:39.932731","2019/04/01 20:31:39.937731","2019/04/01 20:31:39.942731","2019/04/01 20:31:39.947731","2019/04/01 20:31:39.952731","2019/04/01 20:31:39.957731","2019/04/01 20:31:39.962731","2019/04/01 20:31:39.967731","2019/04/01 20:31:39.972731","2019/04/01 20:31:39.977731","2019/04/01 20:31:39.982731","2019/04/01 20:31:39.987731","2019/04/01 20:31:39.992731","2019/04/01 20:31:39.997731","2019/04/01 20:31:40.002731","2019/04/01 20:31:40.007731","2019/04/01 20:31:40.012731","2019/04/01 20:31:40.017731","2019/04/01 20:31:40.022731","2019/04/01 20:31:40.027731","2019/04/01 20:31:40.032731","2019/04/01 20:31:40.037731","2019/04/01 20:31:40.042731","2019/04/01 20:31:40.047731","2019/04/01 20:31:40.052731","2019/04/01 20:31:40.057731","2019/04/01 20:31:40.062731","2019/04/01 20:31:40.067731","2019/04/01 20:31:40.072731","2019/04/01 20:31:40.077731","2019/04/01 20:31:40.082731","2019/04/01 20:31:40.086731","2019/04/01 20:31:40.091731","2019/04/01 20:31:40.096731","2019/04/01 20:31:40.101731","2019/04/01 20:31:40.106731","2019/04/01 20:31:40.111731","2019/04/01 20:31:40.116731","2019/04/01 20:31:40.121731","2019/04/01 20:31:40.126731","2019/04/01 20:31:40.131731","2019/04/01 20:31:40.136731","2019/04/01 20:31:40.141731","2019/04/01 20:31:40.146731","2019/04/01 20:31:40.151731","2019/04/01 20:31:40.156731","2019/04/01 20:31:40.161731","2019/04/01 20:31:40.166731","2019/04/01 20:31:40.171731","2019/04/01 20:31:40.176731"]
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
                            // "data": [
                            //     "\u7b14"
                            // ],
                            data:['AQ1','AQ2'],
                            "orient": "horizontal",
                            "left": "center"
                        }
                    ]
                };
            leftChart.setOption(leftOption);
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
        function setData1(data_,beginTime){
            if(data_.length==0){
                return;
            }
            var data = data_;
            for (var i = 0; i <data[0].length ; i++) {
                xx1.push(new Date(Date.parse(beginTime)+(i+1)*5).format('yyyy-MM-dd h:m:s.S'));
            }
            var len = xx1.length - 2000;
            if(xx1.length>2000){
                xx1.splice(0,len)
            }
            yy1 = yy1.concat(data[0]);
            yy2 = yy2.concat(data[1]);
            if(yy1.length>2000){
                yy1.splice(0,len)
            }
            if(yy2.length>2000){
                yy2.splice(0,len)
            }
            var max = Math.max.apply(null,yy1.concat(yy2));
            var min = Math.min.apply(null,yy1.concat(yy2));
            if(Math.abs(max) < Math.abs(min)){
                max =   Math.abs(min);
            }
            max = Math.ceil(max);
            min = -max;
            leftChart.setOption({
                series: [{
                    name: 'AQ1',
                    data: yy1
                },{
                    name: 'AQ2',
                    data: yy2
                }],
                yAxis:[{
                    min:min,
                    max:max
                }],
                xAxis:[{
                    data:xx1
                }
                ]
            });
        }
        function stopTask(){
            if(data1Interval) clearInterval(data1Interval);
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
            <div class="checkbox-custom checkbox-default"  onclick="location.href='${request.contextPath}/web/index3/${params.id}'">
                <input type="checkbox" id="showType1">
                <label for="showType1">双显</label>
            </div>
            <div class="checkbox-custom checkbox-default">
                <input type="checkbox" id="showType2" disabled checked>
                <label for="showType2">重叠</label>
            </div>
        </div>
    </div>
</div>

<div class="child">
    <div class="col-xs-12 col-sm-12" id="data1"></div>
</div>
</body>
</html>