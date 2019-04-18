<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/31
  Time: 19:08
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/js/echarts/echarts3.min.js"></script>
    <style type="text/css">
    .child{
        width: 100%;
        padding:0px;
        margin:0px;
    }
    </style>
</head>

<body >
<div class="child">
    <div class="col-xs-12 col-sm-6">
    <g:each in="${list}" var="obj">
            <div id="rightChart${obj.chanCode}" style="height: 500px;width: 100%;"></div>
            <script type="text/javascript">
                var rightChart${obj.chanCode} = echarts.init(document.getElementById('rightChart${obj.chanCode}'));
                $.post("${request.contextPath}/web/realTimeDataJson",{chanCode:'${obj.chanCode}',devid:'${obj?.measuringPoint?.devid}'},function(data){
                    var data_ = data.data;
                    var xx = new Array();
                    var yy = new Array();
                    $.each(data_,function(k,v){
                        xx.push(v.time);
                        yy.push([v.time,v.data]);
                    });
                    var option =
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
                                        "show": true
                                    },
                                    "boundaryGap": true,
                                    "nameTextStyle": {
                                        "fontSize": 14
                                    },
                                    name:'${obj.unitText}(${obj.unit})',
                                    nameLocation:'middle',
                                    nameGap:35,
                                    nameTextStyle:{
                                        fontSize:16,
                                        fontWeight:'bolder'
                                    },
                                    "inverse": false,
                                    "splitArea": {
                                        "show": true
                                    },
                                    "type": "value"
                                }
                            ],
                            "color": [
                                "#c23531"
                            ],
                            "series": [
                                {
                                    "seriesId": 4247545,
                                    "markLine": {
                                        "data": []
                                    },
                                    "name": "\u7b14",
                                    "data": yy,
                                    "symbol": "emptyCircle",
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
                                    subtext:'${obj.chanName}${obj.unitText}频域曲线',
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
                                        "interval": "auto",
                                        "margin": 8,
                                        "rotate": 0
                                    },
                                    "splitLine": {
                                        "show": false
                                    },
                                    "boundaryGap": true,
                                    "nameTextStyle": {
                                        "fontSize": 14
                                    },
                                    "nameGap": 80,
                                    "inverse": false,
                                    "data": xx
                                }
                            ],
                            "dataZoom": [
                                {
                                    "start": 0,
                                    "end": 100,
                                    "type": "slider",
                                    "orient": "horizontal",
                                    "show": true
                                },
                                {
                                    "start": 0,
                                    "show": true,
                                    "end": 100,
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
                    rightChart${obj.chanCode}.setOption(option);
                },"json");
                var interval${obj.chanCode};
                if(interval${obj.chanCode}) clearInterval(interval${obj.chanCode});
                var date${obj.chanCode} = null;
                interval${obj.chanCode} = setInterval(function() {
                    $.post("${request.contextPath}/web/realTimeDataJson",{date:date${obj.chanCode},chanCode:'${obj.chanCode}',devid:'${obj?.measuringPoint?.devid}'},function(data){
                        var data_ = data.data;
                        if(typeof(data_)=="undefined"){
                            return;
                        }
                        var xx = new Array();
                        var yy = new Array();
                        date${obj.chanCode} = data.time;
                        $.each(data_,function(k,v){
                            xx.push(v.time);
                            yy.push([v.time,v.data]);
                        });
                        rightChart${obj.chanCode}.setOption({
                            series: [{
                                data: yy
                            }],
                            xAxis:[{
                                data:xx
                            }
                            ]
                        });
                    },"json");
                }, 2000);
            </script>
    </g:each>
    </div>

    <div class="col-xs-12 col-sm-6">
        <g:each in="${list}" var="obj">
            <div id="right${obj.chanCode}" style="height: 500px;width: 100%;"></div>
            <script type="text/javascript">
                var rinterval${obj.chanCode};
                if(rinterval${obj.chanCode}) clearInterval(rinterval${obj.chanCode});
                var rdate${obj.chanCode} = null;
                var right${obj.chanCode} = echarts.init(document.getElementById('right${obj.chanCode}'));
                $.post("${request.contextPath}/web/spectrumDataJson",{chanCode:'${obj.chanCode}',devid:'${obj?.measuringPoint?.devid}'},function(data){
                    var data_ = data.data;
                    var xx = new Array();
                    var yy = new Array();
                    $.each(data_,function(k,v){
                        xx.push(v.x);
                        yy.push(v.y);
                    });
                    var option${obj.chanCode} = {
                        backgroundColor: "#fff",
                        color: ["#c23531"],
                        title:{
                            subtext:'${obj.chanName}${obj.unitText}频域曲线',
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
                            data: xx
                        },
                        yAxis: {
                            // x: 'center',
                            type: 'value',
                            name:'${obj.unitText}(${obj.unit})',
                            nameLocation:'middle',
                            nameGap:30,
                            nameTextStyle:{
                                fontSize:16,
                                fontWeight:'bolder'
                            }
                        },
                        series: [{
                            name: '销量',
                            type: 'line',
                            data: yy
                        }]
                    };
                    right${obj.chanCode}.setOption( option${obj.chanCode});
                },"json");
                function rintFun${obj.chanCode}() {
                    $.post("${request.contextPath}/web/spectrumDataJson",{date:rdate${obj.chanCode},chanCode:'${obj.chanCode}',devid:'${obj?.measuringPoint?.devid}'},function(data){
                        var data_ = data.data;
                        if(typeof(data_)=="undefined"){
                            return;
                        }
                        var xx = new Array();
                        var yy = new Array();
                        rdate${obj.chanCode} = data.time;
                        $.each(data_,function(k,v){
                            xx.push(v.x);
                            yy.push(v.y);
                        });
                        right${obj.chanCode}.setOption({
                            series: [{
                                data: yy
                            }],
                            xAxis:[{
                                data:xx
                            }
                            ]
                        });
                    },"json");
                }
                rinterval${obj.chanCode} = setInterval(rintFun${obj.chanCode}, 1000);
            </script>
        </g:each>
    </div>
</div>

</body>
</html>