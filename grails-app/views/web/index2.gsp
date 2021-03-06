<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/22
  Time: 15:53
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>区域工业环境大数据在线监测系统</title>
    <link rel="stylesheet" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${request.contextPath}/js/Font-Awesome-3.2.1/css/font-awesome.min.css">
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/js/echarts/echarts3.min.js"></script>
    <style type="text/css">
        .child{
            width: 100%;
            padding:0px;
        }
        .col-sm-12 {border-radius: 5px;}
        .boxBorder {
            border: 2px solid #93ebf84f;
            box-shadow: 0 0 10px #93ebf84f;
            /*background: rgba(78, 136, 181, 0.66)*/
        }
        ul{list-style:none;padding: 0px;}
        #marquee1{overflow:hidden;color: #91e9f8;}
        #marquee1 ul li{line-height: 30px;font-size: 14px;}
        .p0{
            padding:0px;
        }
        .p1{
            padding-left: 5px;
        }
        .odd{
            background: #08cff9a6;
            color: #FFF;
        }
        .th{
            color: #fff749;
            font-weight: 600;
            font-size: 16px;
        }
    </style>
    <script type="text/javascript">
      //  background: rgb(21, 78, 144);
        var height = $(window).height();
    </script>
</head>
<!--background: rgb(0, 10, 21)-->
<body style="background: url('${request.contextPath}/images/bg.jpg');overflow-y: hidden;">
<div class="child">
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12  boxBorder" style="height: 30%;margin-top: 10px;padding: 0px 10px;overflow: auto;">
            <div id="firstChart" style="height: 200px;"></div>
            <script type="text/javascript">
                var color=['#fec178','#72f1da','#3faefc','#8b76f9'];
               $.post('${request.contextPath}/web/dayData',{id:'${obj.id}'},function(data,status){
                    $("#firstChart").css("height",(0.30*height)+"px");
                    var width =$("#firstChart").width();
                    var firstChart={};
                    $.each(data,function(k,v){
                        $("#firstChart").append("<div id=\"firstChart"+k+"\" style='height: 90px;width:"+0.95*width+"px;'></div>");
                        firstChart[k] = echarts.init(document.getElementById('firstChart'+k));
                        firstChart[k].resize();
                        firstChart[k].setOption( {
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'cross'
                                }
                            },
                            grid: {
                                left: '15%',
                                right: '5%',
                                top: '8%',
                                bottom:'25%'
                            },
                            xAxis: {
                                type: 'category',
                                boundaryGap: false,
                                axisLine:{
                                    lineStyle:{
                                        color:'#91e9f8'
                                    }
                                },
                                axisLabel:{
                                    color:'#fff'
                                },
                                data: v.x
                            },
                            yAxis: {
                                type: 'value',
                                axisLine:{
                                    lineStyle:{
                                        color:'#91e9f8'
                                    }
                                },
                                axisLabel:{
                                    color:'#fff'
                                },
                                splitLine: {show: false}
                            },
                            series: [{
                                data: v.y,
                                type: 'line',
                                lineStyle: {normal: {color:color[k]}},
                                areaStyle: {normal: {color:color[k]}}
                            }]
                        })
                    });
                   /* var myChart1 = echarts.init(document.getElementById('firstChart'));
                    myChart1.resize();
                    myChart1.setOption({
                        // Make gradient line here
                        color:['#fec178','#72f1da','#4cd1fd','#3faefc','#8b76f9'],

                        tooltip: {
                            trigger: 'axis'
                        },
                        xAxis: [{
                            type: 'category',
                            boundaryGap: false,
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            data: data[0].x
                        }, {
                            type: 'category',
                            boundaryGap: false,
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            data: data[1].x,
                            gridIndex: 1
                        }, {
                            type: 'category',
                            boundaryGap: false,
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            data: data[2].x,
                            gridIndex: 2
                        }],
                        yAxis: [{
                            type: 'value',
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            splitLine: {show: false}
                        }, {
                            type: 'value',
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            splitLine: {show: false},
                            gridIndex: 1
                        }, {
                            type: 'value',
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            splitLine: {show: false},
                            gridIndex: 2
                        }],
                        grid: [{
                            top: '1%',
                            left:'8%',
                            right:'0%',
                            bottom: '78%'
                        }, {
                            left:'8%',
                            right:'0%',
                            top: '32%',
                            bottom: '45%'
                        }, {
                            left:'8%',
                            right:'0%',
                            top: '65%',
                            bottom: '8%'
                        }],
                        series: [{
                            type: 'line',
                            showSymbol: false,
                            areaStyle: {normal: {}},
                            data: data[0].y
                        }, {
                            type: 'line',
                            showSymbol: false,
                            areaStyle: {normal: {}},
                            data: data[1].y,
                            xAxisIndex: 1,
                            yAxisIndex: 1
                        }, {
                            type: 'line',
                            showSymbol: false,
                            areaStyle: {normal: {}},
                            data: data[2].y,
                            xAxisIndex: 2,
                            yAxisIndex: 2
                        }]
                    });*/
                },'json');
            </script>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 27%;margin-top: 15px;">
            <div class="col-xs-5 col-sm-5" style="padding: 0px;">
                <div id="leftChart">

                </div>
                <script type="text/javascript">
                    $("#leftChart").css("height",0.27*height+"px");
                    var leftChart = echarts.init(document.getElementById('leftChart'));
                    var leftOption = {
                        color:['#ACACAC','#fec178','#72f1da','#4cd1fd','#3faefc','#8b76f9'],
                        title:{
                            text:'',
                            textStyle:{
                                color:'red',
                                fontSize:20
                            }
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b}: {c} ({d}%)"
                        },
                        legend: {
                            show:false,
                            orient: 'horizontal',
                            x: 'center',
                            y:'bottom',
                            data:['','','','','']
                        },
                        series: [
                            {
                                name:'预警',
                                type:'pie',
                                radius: ['20%', '50%'],
                                avoidLabelOverlap: false,
                                labelLine:{
                                    normal:{
                                        length2:95
                                    }
                                },
                                label: {
                                    normal: {
                                        formatter: "{c}\n\n",
                                        padding:[0,-95],
                                        rich: {
                                            a: {
                                                color: 'red',
                                                fontSize: 14,
                                                height:30
                                            },
                                            b: {
                                                color:"blue",
                                                fontSize: 16,
                                            }
                                        }
                                    }
                                },
                                data:[
                                    {value:335, name:''},
                                    {value:310, name:''},
                                    {value:234, name:''},
                                    {value:135, name:''},
                                    {value:548, name:''}
                                ]
                            }
                        ]
                    };

                    leftChart.setOption(leftOption);
                </script>
            </div>
            <div class="col-xs-7 col-sm-7" style="padding: 0px;">
                <div id="rightChart" >

                </div>
            </div>
            <script type="text/javascript">
                $("#rightChart").css("height",0.27*height+"px");
                var yAxisMonth = [
                    "0-2时",
                    "3-5时",
                    "6-8时",
                    "9-11时",
                    "12-14时",
                    "15-17时",
                    "18-20时",
                    "21-23时"
                ];
                var barData = [
                    43,
                    94,
                    84,
                    84,
                    94,
                    84,
                    84,
                    64
                ];
                var barDataTwo = [];
                var coordData2 = [];
                var coordData = [];
                for (var i = 0; i < barData.length; i++) {
                    barDataTwo.push(Math.max.apply(Math, barData) + 5000);
                    coordData.push({
                        "coord": [Number(barData[i]) - 1, i]
                    });
                    coordData2.push({
                        "coord": [Math.max.apply(Math, barData) + 5000, i]
                    })
                }
                var rightChart = echarts.init(document.getElementById('rightChart'));
                var rightOption = {
                    title: {
                        text: ''
                    },
                    legend: null,
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'none'
                        },
                        formatter: function(params) {
                            return params[0].name + "<br/>" + '数据: ' + params[0].value;
                        }
                    },
                    grid: {
                        containLabel: true,
                        top:"-5%",
                        bottom:"-5%",
                        left:"8%",
                        right:"-25%"

                    },
                    yAxis: [{
                        data: yAxisMonth,
                        inverse: true,
                        axisLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            margin:5,
                            textStyle: {
                                fontSize: 10,
                                color: '#42a5c2',
                            },
                            formatter: function(value) {
                                return '{Sunny|' + value + '}';
                            },
                            rich: {
                                value: {
                                    lineHeight: 20,
                                },
                                Sunny: {
                                    width: 50,
                                    height: 16,
                                    padding: [0, 0, 0, 0],
                                    align: 'center',
                                    backgroundColor: {
                                        image: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFEAAAAjCAYAAADsZeb8AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTM4IDc5LjE1OTgyNCwgMjAxNi8wOS8xNC0wMTowOTowMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTcgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjIxNzQ2ODFCQkVFNjExRTc4OEU3QzFEMjE5RjExOEZBIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjIxNzQ2ODFDQkVFNjExRTc4OEU3QzFEMjE5RjExOEZBIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MjE3NDY4MTlCRUU2MTFFNzg4RTdDMUQyMTlGMTE4RkEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MjE3NDY4MUFCRUU2MTFFNzg4RTdDMUQyMTlGMTE4RkEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7fNMa8AAABg0lEQVR42uzaMUvDQBgG4O+7pJS0ghVBOkknK06dAh38E126uji4iogtzlFBcNTi4urin3CoOHWytpM41aJYxTa2Te4sWgpWA2lufV8I4ULuOB747m44VkrRdIydXoa8bpGZC8Qxm5Sk74fG76D2+Bv/+UdF6BNuDA47N1K/+wTMI7itiAPnPoVobL87JMwSfzxWRadeE+2bJn8+9wj5Pywq5gRv10uR7FdJDpJm/aws3hovEAqXCSLJYZV7rddYzTkBy2wRP2ug65DfT44AL0ASAdHYowwZ8ZLZOD8FR9Ry9twiu0+jTeQea2DkcmZREJ27Gih0EI24LVrXTVBobizstnEO1EVEgAhEICJABCIQgYgAEYhABCICRCACEYhIWERlLSVAoYPo929len0FFDqISl7J1FoOFDqIpnWp5pbzMrW6CI6IiP4hPYxK+sDLbm6BQ2Nj8Y+tMhnx7jBX3gCJzhFHxPIqkV4Y2Ef7cj6L0p4huJ+oLSgqjJuy+jdlvwQYAN1TdkgsoTftAAAAAElFTkSuQmCC'
                                    }


                                }
                            }
                        }
                    },
                        {
                            data: yAxisMonth,
                            inverse: true,
                            axisLine: {
                                show: false
                            },
                            axisTick: {
                                show: false
                            },
                            axisLabel: {
                                show: false
                            },
                        },
                    ],
                    xAxis: [{
                        type: "value",
                        splitLine: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLine: {
                            show: false
                        }
                    }, {
                        type: "value",
                        splitLine: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLine: {
                            show: false
                        }
                    }],
                    series: [{
                        z: 10,
                        xAxisIndex: 0,
                        yAxisIndex: 0,
                        name: 'XXX',
                        type: 'pictorialBar',
                        data: barData,
                        // barCategoryGap: '80%',
                        label: {
                            normal: {
                                show: true,
                                position: 'inside',
                                textStyle: {
                                    fontSize: 10,
                                    color: '#00ffff'
                                }
                            }
                        },
                        symbolRepeat: false,
                        symbolSize: ['100%', 15],
                        symbolOffset: [-8.5, 0],
                        itemStyle: {
                            normal: {
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: '#083e6d',
                                },
                                    {
                                        offset: 0.5,
                                        color: '#0272f2',
                                        opacity: 0.7
                                    }, {
                                        offset: 1,
                                        color: '#083e6d',
                                        opacity: 0.5
                                    }
                                ], false),
                            }
                        },
                        symbolClip: true,
                        symbolPosition: 'end',
                        symbol: 'rect',
                        // symbol: 'path://M0 0 L0 60 L225 60 L300 0 Z',
                        markPoint: {
                            data: coordData,
                            symbolSize: [15, 15],
                            symbolOffset: [-0.5, 0],
                            z: 3,
                            label: {
                                normal: {
                                    show: false
                                }
                            },
                            symbolClip: true,
                            symbol: 'path://M 300 100 L 100 100 L 100 300 z',

                        }
                    },
                        {
                            z: 6,
                            xAxisIndex: 1,
                            yAxisIndex: 1,
                            animation: false,
                            name: 'XX',
                            type: 'pictorialBar',
                            data: barDataTwo,
                            barCategoryGap: '80%',
                            label: {
                                normal: {
                                    show: false,
                                    position: 'inside',
                                    textStyle: {
                                        fontSize: 10,
                                        color: '#00ffff'
                                    }
                                }
                            },
                            symbolRepeat: false,
                            symbolSize: ['100%', 15],
                            symbolOffset: [-8.5, 0],
                            itemStyle: {
                                normal: {
                                    color: '#00abc5',
                                    opacity: 0.085
                                }
                            },
                            symbolClip: true,
                            symbol: 'rect',
                            markPoint: {
                                data: coordData2,
                                symbolSize: [15, 15],
                                symbolOffset: [-0.5, 0],
                                label: {
                                    normal: {
                                        show: false
                                    }
                                },
                                itemStyle: {
                                    normal: {
                                        color: '#00abc5',
                                        opacity: 0.085
                                    }
                                },
                                symbolClip: true,
                                symbol: 'path://M 300 100 L 100 100 L 100 300 z',

                            }
                        }
                    ]
                };
                rightChart.setOption(rightOption);
            </script>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder p0" style="height: 22%;margin-top: 15px;">
            <div class="col-sm-12 p0" style="line-height: 40px;">
                <div  class="col-xs-6 col-sm-3 p1 th">设备名称</div>
                <div  class="col-xs-6 col-sm-3 p0 th">IP地址</div>
                <div  class="col-xs-6 col-sm-3 p0 th">发生时间</div>
                %{--<div  class="col-xs-6 col-sm-3 p0 th ">单位名称</div>--}%
                <div  class="col-xs-6 col-sm-2 p0 th">责任人</div>
            </div>
            <div id="marquee1" style="max-height: 80px;margin-top: 40px;">
                <ul>
                    <li class="col-sm-12 p0">
                        <div  class="col-xs-6 col-sm-3 p1"> 设备名称</div>
                        <div  class="col-xs-6 col-sm-3 p0">192.168.1.120</div>
                        <div  class="col-xs-6 col-sm-3 p0">08-04 17:20</div>
                        %{--<div  class="col-xs-6 col-sm-3 p0 ">单位名称</div>--}%
                        <div  class="col-xs-6 col-sm-2 p0">张***</div>
                    </li>
                    <li class="col-sm-12 p0 odd">
                        <div  class="col-xs-6 col-sm-3 p1"> 设备名称</div>
                        <div  class="col-xs-6 col-sm-3 p0">192.168.1.120</div>
                        <div  class="col-xs-6 col-sm-3 p0">08-04</div>
                        %{--<div  class="col-xs-6 col-sm-3 p0 ">单位名称</div>--}%
                        <div  class="col-xs-6 col-sm-2 p0">张***</div>
                    </li>
                    <li class="col-sm-12 p0">
                        <div  class="col-xs-6 col-sm-3 p1">设备名称</div>
                        <div  class="col-xs-6 col-sm-3 p0">192.168.1.120</div>
                        <div  class="col-xs-6 col-sm-3 p0">08-04</div>
                        %{--<div  class="col-xs-6 col-sm-3 p0 ">单位名称</div>--}%
                        <div  class="col-xs-6 col-sm-2 p0">张***</div>
                    </li>
                    <li class="col-sm-12 p0 odd">
                        <div  class="col-xs-6 col-sm-3 p1"> 设备名称</div>
                        <div  class="col-xs-6 col-sm-3 p0">192.168.1.120</div>
                        <div  class="col-xs-6 col-sm-3 p0">08-04</div>
                        %{--<div  class="col-xs-6 col-sm-3 p0 ">单位名称</div>--}%
                        <div  class="col-xs-6 col-sm-2 p0">张***</div>
                    </li>
                    <li class="col-sm-12 p0">
                        <div  class="col-xs-6 col-sm-3 p1"> 设备名称</div>
                        <div  class="col-xs-6 col-sm-3 p0">192.168.1.120</div>
                        <div  class="col-xs-6 col-sm-3 p0">08-04</div>
                        %{--<div  class="col-xs-6 col-sm-3 p0 ">单位名称</div>--}%
                        <div  class="col-xs-6 col-sm-2 p0">张***</div>
                    </li>
                    <li class="col-sm-12 p0 odd">
                        <div  class="col-xs-6 col-sm-3 p1"> 设备名称</div>
                        <div  class="col-xs-6 col-sm-3 p0">192.168.1.120</div>
                        <div  class="col-xs-6 col-sm-3 p0">08-04</div>
                        %{--<div  class="col-xs-6 col-sm-3 p0 ">单位名称</div>--}%
                        <div  class="col-xs-6 col-sm-2 p0">张***</div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 14%;margin-top: 15px;padding: 5px 10px;">
            <img src="${request.contextPath}/images/logo1.png" style="width: 100%;height: 80%;">
            %{--<div style="float: left;">
                <img src="${request.contextPath}/images/logo.png" width="80px" height="80px">&nbsp;
            </div>
            <div style="line-height: 35px;float: left;">
                <div style="font-size: 20px;color: #fff;font-weight: 800;">IPPR&EVCC</div>
                <div style="font-size: 16px;color:#fff749;font-weight: 800;padding:0px 0px;">区域工业环境大数据在线监测系统</div>
            </div>
            <div style="clear: both;"></div>--}%
        </div>
    </div>
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12" style="height: 48%;margin-top: 10px;">
            <g:if test="${obj.picture}">
                <a href="${request.contextPath}/web/index3/${params.id}" target="_blank" title="点击查看实时波形数据">
                    <img src="${request.contextPath}/monitoringPlace/picture/${obj?.id}" style="width: 100%;height: 98%;" >
                </a>
            </g:if>
            <div style="line-height: 30px;">
                <g:each in="${list}" var="point">
                    <div class="col-xs-4 col-sm-4" style="color: #ffffff;overflow: hidden;
                    text-overflow:ellipsis;
                    white-space: nowrap;">
                       <i class="icon-circle"></i>&nbsp;${point.name}
                    </div>
                </g:each>
            </div>
        </div>
        <div class="col-xs-6 col-sm-12" style="height: 24%;margin-top: 15px;">
            <div class="col-xs-6 col-sm-12">
                <div style="width:80px;border-radius: 5px;color: #fff;border: 1px solid #93ebf84f;box-shadow: 0 0 10px #93ebf84f;margin: 5px 0px;padding: 5px;">预警信息</div>
            </div>
            <div class="col-xs-6 col-sm-4">
                <div id="centerChart1" style="height: 130px;"></div>
            </div>
            <div class="col-xs-6 col-sm-4">
                <div id="centerChart2" style="height: 130px;"></div>
            </div>
            <div class="col-xs-6 col-sm-4">
                <div id="centerChart3" style="height: 130px;"></div>
            </div>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 24%;margin-top: 10px;">
            <div class="col-xs-6 col-sm-12">
                <div style="width:80px;border-radius: 5px;color: #fff;border: 1px solid #93ebf84f;box-shadow: 0 0 10px #93ebf84f;margin: 5px 0px;padding: 5px;">预警信息</div>
            </div>
            <div class="col-xs-6 col-sm-4">
                <div id="centerChart4" style="height: 130px;"></div>
            </div>
            <div class="col-xs-6 col-sm-4">
                <div id="centerChart5" style="height: 130px;"></div>
            </div>
            <div class="col-xs-6 col-sm-4">
                <div id="centerChart6" style="height: 130px;"></div>
            </div>
        </div>
        <script type="text/javascript">
            var centerChart1 = echarts.init(document.getElementById('centerChart1'));
            var centerChart2 = echarts.init(document.getElementById('centerChart2'));
            var centerChart3 = echarts.init(document.getElementById('centerChart3'));
            var centerChart4 = echarts.init(document.getElementById('centerChart4'));
            var centerChart5 = echarts.init(document.getElementById('centerChart5'));
            var centerChart6 = echarts.init(document.getElementById('centerChart6'));
            var centerOption = {
                title: {
                    text: '',
                    x: '50%',
                    y: '45%',
                    textAlign: "center",
                    textStyle: {
                        fontWeight: 'normal',
                        fontSize: 14
                    },
                    subtextStyle: {
                        fontWeight: 'bold',
                        fontSize: 14,
                        color: '#3ea1ff'
                    }
                },
                series: [{
                    name: ' ',
                    type: 'pie',
                    radius: ['40%', '95%'],
                    startAngle: 225,
                    color: [new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,//#0a3fff   #00a2ff
                        color: '#0a3fff'
                    }, {
                        offset: 1,//#70ffac
                        color: '#70ffac'
                    }]), "transparent"],
                    hoverAnimation: false,
                    legendHoverLink: false,
                    itemStyle: {
                        normal: {
                            borderColor: "transparent",
                            borderWidth: "60"
                        },
                        emphasis: {
                            borderColor: "transparent",
                            borderWidth: "60"
                        }
                    },
                    z: 10,
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data: [{
                        value: 75
                    }, {
                        value: 25
                    }]
                }, {
                    name: '',
                    type: 'pie',
                    radius: ['40%', '95%'],
                    startAngle: 225,
                    color: ["#5df0f5", "transparent"],
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data: [{
                        value: 75
                    }, {
                        value: 25
                    }]
                }
                ]
            };

            setPercent(60);
            function setPercent(value) {
                var  value_ = 75 * value / 100;
                centerOption.title.subtext = value + "%";
                centerOption.series[0].data[0].value = value_;
                centerOption.series[0].data[1].value = 100 - value_;
                centerChart1.setOption(centerOption, true);
                centerChart2.setOption(centerOption, true);
                centerChart3.setOption(centerOption, true);
                centerChart4.setOption(centerOption, true);
                centerChart5.setOption(centerOption, true);
                centerChart6.setOption(centerOption, true);
            }
        </script>
    </div>
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12 boxBorder" id="rightChart1" style="height: 39%;margin-top: 15px;overflow-y: auto;overflow-x: hidden;">
            %{--<div id="rightChart1" style="height: 80px;"></div>
            <div id="rightChart2" style="height: 80px;"></div>
            <div id="rightChart3" style="height: 80px;"></div>--}%
            <script type="text/javascript">
                var colors = ['#5793f3', '#d14a61', '#675bba'];
                var option111 ={
                    color: colors,

                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross'
                        },
                        formatter: function(prams) {
                            return "预警数：" + prams[0].data
                        }
                    },
                    grid: {
                        left: '8%',
                        right: '0%',
                        top: '10%',
                        bottom:'25%'
                    },
                    toolbox: {
                        feature: {
                            dataView: {show: false, readOnly: false},
                            restore: {show: false},
                            saveAsImage: {show: false}
                        }
                    },
                    legend: {
                        show:false,
                        data:['']
                    },
                    xAxis: [
                        {
                            type: 'category',
                            axisTick: {
                                alignWithLabel: true
                            },
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            data: []
                        }
                    ],
                    yAxis: [
                        {
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            splitLine: {show: false},
                            type: 'value'
                        }
                    ],
                    series: [
                        {
                            name:'',
                            type:'bar',
                            data:[]
                        }
                    ]
                };
                $.post('${request.contextPath}/web/monthData',{id:'${obj.id}'},function(data,status){
                        var rightChart1 = {};
                        $.each(data,function(k,v){
                            $("#rightChart1").append('<div id="rightChart1-'+k+'" style="height: 90px;"></div>');
                            rightChart1[k] = echarts.init(document.getElementById('rightChart1-'+k));

                            rightChart1[k].setOption(option111);
                        });
                        $.each(data,function(k,v){
                            rightChart1[k].setOption({
                                xAxis: [{data:v.month}],
                                series: [
                                    {
                                        data:v.value
                                    }
                                ]
                            });
                        });

                    },'json');


             /*   var rightChart1 = echarts.init(document.getElementById('rightChart1'));
                var rightChart2 = echarts.init(document.getElementById('rightChart2'));
                var rightChart3 = echarts.init(document.getElementById('rightChart3'));
                var colors = ['#5793f3', '#d14a61', '#675bba'];
                var option ={
                    color: colors,

                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross'
                        }
                    },
                    grid: {
                        left: '8%',
                        right: '0%',
                        top: '10%',
                        bottom:'25%'
                    },
                    toolbox: {
                        feature: {
                            dataView: {show: false, readOnly: false},
                            restore: {show: false},
                            saveAsImage: {show: false}
                        }
                    },
                    legend: {
                        show:false,
                        data:['']
                    },
                    xAxis: [
                        {
                            type: 'category',
                            axisTick: {
                                alignWithLabel: true
                            },
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
                        }
                    ],
                    yAxis: [
                        {
                            axisLine:{
                                lineStyle:{
                                    color:'#91e9f8'
                                }
                            },
                            axisLabel:{
                                color:'#fff'
                            },
                            splitLine: {show: false},
                            type: 'value'
                        }
                    ],
                    series: [
                        {
                            name:'',
                            type:'bar',
                            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
                        }
                    ]
                };
                rightChart1.setOption(option);
                rightChart2.setOption(option);
                rightChart3.setOption(option);*/
            </script>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" id="rightChart2" style="height: 55%;margin-top: 20px;overflow-y: auto;overflow-x: hidden;">
            %{--<div id="rightChart4" style="height: 120px;margin-top: 20px;"></div>

            <div id="rightChart5" style="height: 120px;margin-top: 20px;"></div>
            <div id="rightChart6" style="height: 120px;margin-top: 20px;"></div>--}%
        </div>

        <script type="text/javascript">
            var option222 = {
//                backgroundColor: "#111c4e",
                color: ['#3398DB'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'line',
                        lineStyle: {
                            opacity: 0
                        }
                    },
                    formatter: function(prams) {
                        return "预警数：" + prams[0].data
                    }
                },
                grid: {
                    left: '5%',
                    right: '0%',
                    bottom: '10%',
                    top: '15%',
                    height: '85%',
                    containLabel: true,
                    z: 22
                },
                xAxis: [{
                    type: 'category',
                    gridIndex: 0,
                    data: [],
                    axisTick: {
                        alignWithLabel: true
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#91e9f8'
                        }
                    },
                    axisLabel: {
                        show: true,
                        color: '#fff',
                        fontSize: 16
                    }
                }],
                yAxis: [{
                    type: 'value',
                    gridIndex: 0,
                    splitLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#91e9f8'
                        }
                    },
                    axisLabel: {
                        color: '#fff',
                        formatter: '{value}'
                    }
                },
                    {
                        type: 'value',
                        gridIndex: 0,
                        splitNumber: 12,
                        splitLine: {
                            show: false
                        },
                        axisLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        splitArea: {
                            show: true,
                            areaStyle: {
                                color: ['rgba(250,250,250,0.0)', 'rgba(250,250,250,0.05)']
                            }
                        }
                    }
                ],
                series: [{
                    name: '预警数',
                    type: 'bar',
                    barWidth: '30%',
                    xAxisIndex: 0,
                    yAxisIndex: 0,
                    label: {
                        normal: {
                            // show: true,
                          //  position: "top",
                            textStyle: {
                                color: "#ffc72b",
                                fontSize: 20
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1, [{
                                    offset: 0,
                                    color: '#00feff'
                                },
                                    {
                                        offset: 0.5,
                                        color: '#027eff'
                                    },
                                    {
                                        offset: 1,
                                        color: '#0286ff'
                                    }
                                ]
                            )
                        }
                    },
                    data: [],
                    zlevel: 11

                },
                    {
                        name: '背景',
                        type: 'bar',
                        barWidth: '50%',
                        xAxisIndex: 0,
                        yAxisIndex: 1,
                        barGap: '-135%',
                        data: [],
                        itemStyle: {
                            normal: {
                                color: 'rgba(255,255,255,0.1)'
                            }
                        },
                        zlevel: 9
                    },

                ]
            };
            $.post('${request.contextPath}/web/monthWarningData',{id:'${obj.id}'},function(data,status){
                var rightChart2 = {};
                $.each(data,function(k,v){
                    $("#rightChart2").append('<div id="rightChart2-'+k+'" style="height: 120px;"></div>');
                    rightChart2[k] = echarts.init(document.getElementById('rightChart2-'+k));
                    rightChart2[k].setOption(option222);
                });
                $.each(data,function(k,v){
                    rightChart2[k].setOption({
                        xAxis: [{data:v.month}],
                        series: [
                            {
                                data:v.value
                            }
                        ]
                    });
                });

            },'json');
           /* var rightChart4 = echarts.init(document.getElementById('rightChart4'));
            var rightChart5 = echarts.init(document.getElementById('rightChart5'));
            var rightChart6 = echarts.init(document.getElementById('rightChart6'));
            var xData = ['1月','2月','3月','4月','5月'];
            var yData = [80,87,51,81,23];
            var option = {
//                backgroundColor: "#111c4e",
                color: ['#3398DB'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'line',
                        lineStyle: {
                            opacity: 0
                        }
                    },
                    formatter: function(prams) {
                        return "预警数：" + prams[0].data
                    }
                },
                grid: {
                    left: '5%',
                    right: '0%',
                    bottom: '10%',
                    top: '15%',
                    height: '85%',
                    containLabel: true,
                    z: 22
                },
                xAxis: [{
                    type: 'category',
                    gridIndex: 0,
                    data: xData,
                    axisTick: {
                        alignWithLabel: true
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#91e9f8'
                        }
                    },
                    axisLabel: {
                        show: true,
                        color: '#fff',
                        fontSize: 16
                    }
                }],
                yAxis: [{
                    type: 'value',
                    gridIndex: 0,
                    splitLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#91e9f8'
                        }
                    },
                    axisLabel: {
                        color: '#fff',
                        formatter: '{value}'
                    }
                },
                    {
                        type: 'value',
                        gridIndex: 0,
                        splitNumber: 12,
                        splitLine: {
                            show: false
                        },
                        axisLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            show: false
                        },
                        splitArea: {
                            show: true,
                            areaStyle: {
                                color: ['rgba(250,250,250,0.0)', 'rgba(250,250,250,0.05)']
                            }
                        }
                    }
                ],
                series: [{
                    name: '办理数',
                    type: 'bar',
                    barWidth: '30%',
                    xAxisIndex: 0,
                    yAxisIndex: 0,
                    label: {
                        normal: {
                            show: true,
                            position: "top",
                            textStyle: {
                                color: "#ffc72b",
                                fontSize: 20
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1, [{
                                        offset: 0,
                                        color: '#00feff'
                                    },
                                        {
                                            offset: 0.5,
                                            color: '#027eff'
                                        },
                                        {
                                            offset: 1,
                                            color: '#0286ff'
                                        }
                                    ]
                            )
                        }
                    },
                    data: yData,
                    zlevel: 11

                },
                    {
                        name: '背景',
                        type: 'bar',
                        barWidth: '50%',
                        xAxisIndex: 0,
                        yAxisIndex: 1,
                        barGap: '-135%',
                        data: [100, 100, 100, 100, 100, 100, 100],
                        itemStyle: {
                            normal: {
                                color: 'rgba(255,255,255,0.1)'
                            }
                        },
                        zlevel: 9
                    },

                ]
            };
            rightChart4.setOption(option);
            rightChart5.setOption(option);
            rightChart6.setOption(option);*/
        </script>
    </div>
</div>

<script src="${request.contextPath}/js/jquery.kxbdmarquee.min.js"></script>
<script type="text/javascript">

    $('#marquee1').kxbdMarquee({
        direction: 'up',
        isEqual: false,
        scrollDelay:120
    });
</script>
</body>
</html>