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
    <script type="text/javascript">
        function getDate(stringTime,flag) {
            var timestamp2 = Date.parse(new Date(stringTime));
            // timestamp2 = timestamp2 / 1000;
            //2014-07-10 10:21:12的时间戳为：1404958872
            var res = timestamp2*1000+Number(stringTime.substr(stringTime.lastIndexOf(".")+1));
            // console.log(stringTime + "的时间戳为：" + res);
            return res;
        }
    </script>
</head>

<body >
<div class="child">
    <div class="col-xs-12 col-sm-6">
        <g:each in="${list}" var="obj">
            <div id="rightChart${obj.chanCode}" style="height: 300px;width: 100%;"></div>
            <script type="text/javascript">
                var rightChart${obj.chanCode} = echarts.init(document.getElementById('rightChart${obj.chanCode}'));
                var rOption${obj.chanCode}=null;
                var xx${obj.chanCode} = new Array();
                var yy${obj.chanCode} = new Array();
                var ydata_${obj.chanCode} = new Array();
                $.post("${request.contextPath}/web/realTimeDataJson",{chanCode:'${obj.chanCode}',devid:'${obj?.measuringPoint?.devid}'},function(data){
                    var data_ = data.data;
                    var xx${obj.chanCode} = new Array();
                    var yy${obj.chanCode} = new Array();
                    var ydata_${obj.chanCode} = new Array();
                    $.each(data_,function(k,v){
                        xx${obj.chanCode}.push(v.time);
                        ydata_${obj.chanCode}.push(v.data);
                        yy${obj.chanCode}.push([v.time,v.data]);
                    });
                    var max = Math.max.apply(null,ydata_${obj.chanCode});
                    var min = Math.min.apply(null,ydata_${obj.chanCode});

                    if(Math.abs(max) < Math.abs(min)){
                        max =   Math.abs(min);
                    }
                    max = Math.ceil(max);
                    min = -max;
                    rOption${obj.chanCode} =
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
                                    name:'${obj.unitText}(${obj.unit})',
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
                                    min:min,
                                    max:max,
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
                                    subtext:'${obj.chanName}${obj.unitText}实时波形曲线',
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
                    rightChart${obj.chanCode}.setOption(rOption${obj.chanCode});
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
                        if(data_.length==0){
                            return;
                        }
                        date${obj.chanCode} = data.time;
                        for (var i = 0; i <data_.length ; i++) {
                            var v = data_[i];
                            xx${obj.chanCode}.push(v.time);
                            ydata_${obj.chanCode}.push(v.data);
                            yy${obj.chanCode}.push([v.time,v.data]);
                        }
                        %{--$.each(data_,function(k,v){--}%
                            %{--//2019/05/20 22:58:25.982114--}%
                            %{--xx${obj.chanCode}.push(v.time);--}%
                            %{--ydata_${obj.chanCode}.push(v.data);--}%
                            %{--yy${obj.chanCode}.push([v.time,v.data]);--}%
                        %{--});--}%

                        xx${obj.chanCode}.sort(function(a,b){
                            return getDate(a)-getDate(b);
                        });
                        yy${obj.chanCode}.sort(function(a,b){
                            return getDate(a[0])-getDate(b[0]);
                        });
                        var len = xx${obj.chanCode}.length - 2000;
                        if(xx${obj.chanCode}.length>2000){
                            xx${obj.chanCode}.splice(0,len)
                        }
                        if(yy${obj.chanCode}.length>2000){
                            yy${obj.chanCode}.splice(0,len)
                        }
                        if(ydata_${obj.chanCode}.length>2000){
                            ydata_${obj.chanCode}.splice(0,len)
                        }

                        var max = Math.max.apply(null,ydata_${obj.chanCode});
                        var min = Math.min.apply(null,ydata_${obj.chanCode});

                        if(Math.abs(max) < Math.abs(min)){
                            max =   Math.abs(min);
                        }
                        max = Math.ceil(max);
                        min = -max;
                        %{--rightChart${obj.chanCode}.setOption(rOption${obj.chanCode});--}%
                        rightChart${obj.chanCode}.setOption({
                            series: [{
                                name:'AQI',
                                data: yy${obj.chanCode}
                            }],
                            yAxis:[{
                                min:min,
                                max:max
                            }],
                            xAxis:[{
                                data:xx${obj.chanCode}
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
            <div id="right${obj.chanCode}" style="height: 300px;width: 100%;"></div>
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
                        color: ["#006400"],
                        title:{
                            subtext:'${obj.chanName}${obj.unitText}频谱曲线',
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
                            data: xx,
                            axisLabel:{
                                formatter: function (value, index) {
                                    return Math.ceil(Number(value));
                                }
                            }
                        },
                        yAxis: {
                            // x: 'center',
                            type: 'value',
                            name:'${obj.unitText}(${obj.unit})',
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
                rinterval${obj.chanCode} = setInterval(rintFun${obj.chanCode}, 5000);
            </script>
        </g:each>
    </div>
</div>

</body>
</html>