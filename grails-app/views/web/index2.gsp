<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/22
  Time: 15:53
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
        }
        .col-sm-12 {border-radius: 5px;}
        .boxBorder {border: 2px solid #93ebf84f;box-shadow: 0 0 10px #93ebf84f;background: rgba(78, 136, 181, 0.66)}
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
</head>

<body style="background: rgb(21, 78, 144);">
<div class="child">
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12  boxBorder" style="height: 35%;margin-top: 10px;">
            <div id="firstChart" style="height: 230px;">

            </div>
            <script type="text/javascript">
                var data = [
                    ["0",116],["1",129],["2",135],["3",86],["4",73],["5",85],["6",73],["7",68],["8",92],["9",130],["10",245],["11",139],["12",115],["13",111],["14",209],["15",206],["16",137],["17",128],["18",85],["19",94],["20",71],["21",106],["22",84],["23",93],["24",85],["25",73],["26",83],["27",125],["28",107],["29",82],["30",44],["31",72],["32",106],["33",107],["34",66],["35",91],["36",92],["37",113],["38",107],["39",131],["40",111],["41",64],["42",69],["43",88],["44",77],["45",83],["46",111],["47",57],["48",55],["49",60]];

                var dateList = data.map(function (item) {
                    return item[0];
                });
                var valueList = data.map(function (item) {
                    return item[1];
                });
                var myChart1 = echarts.init(document.getElementById('firstChart'));
                myChart1.setOption({
                    // Make gradient line here
                    visualMap: [{
                        show: false,
                        type: 'continuous',
                        seriesIndex: 0,
                        min: 0,
                        max: 400
                    }, {
                        show: false,
                        type: 'continuous',
                        seriesIndex: 1,
                        dimension: 0,
                        min: 0,
                        max: dateList.length - 1
                    }, {
                        show: false,
                        type: 'continuous',
                        seriesIndex: 2,
                        dimension: 0,
                        min: 0,
                        max: dateList.length - 1
                    }],
                    title: [{
                        left: 'center',
                        text: ''
                    }, {
                        top: '35%',
                        left: 'center',
                        text: ''
                    }, {
                        top: '70%',
                        left: 'center',
                        text: ''
                    }],
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
                        data: dateList
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
                        data: dateList,
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
                        data: dateList,
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
                        top: '5%',
                        left:'8%',
                        right:'0%',
                        bottom: '78%'
                    }, {
                        left:'8%',
                        right:'0%',
                        top: '32%',
                        bottom: '48%'
                    }, {
                        left:'8%',
                        right:'0%',
                        top: '62%',
                        bottom: '20%'
                    }],
                    series: [{
                        type: 'line',
                        showSymbol: false,
                        areaStyle: {normal: {}},
                        data: valueList
                    }, {
                        type: 'line',
                        showSymbol: false,
                        areaStyle: {normal: {}},
                        data: valueList,
                        xAxisIndex: 1,
                        yAxisIndex: 1
                    }, {
                        type: 'line',
                        showSymbol: false,
                        areaStyle: {normal: {}},
                        data: valueList,
                        xAxisIndex: 2,
                        yAxisIndex: 2
                    }]
                });
            </script>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 21%;margin-top: 15px;">
            <div class="col-xs-6 col-sm-6">
                <div id="leftChart" style="height: 150px;">

                </div>
                <script type="text/javascript">
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
                            data:['访问','邮件','联盟','视频','搜索']
                        },
                        series: [
                            {
                                name:'访问来源',
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
                                        formatter: "{b}{c}\n\n",
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
                                    {value:335, name:'访问'},
                                    {value:310, name:'邮件'},
                                    {value:234, name:'联盟'},
                                    {value:135, name:'视频'},
                                    {value:548, name:'搜索'}
                                ]
                            }
                        ]
                    };

                    leftChart.setOption(leftOption);
                </script>
            </div>
            <div class="col-xs-6 col-sm-6"></div>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder p0" style="height: 23%;margin-top: 15px;">
            <div class="col-sm-12 p0" style="line-height: 40px;">
                <div  class="col-xs-6 col-sm-3 p1 th">设备名称</div>
                <div  class="col-xs-6 col-sm-3 p0 th">IP地址</div>
                <div  class="col-xs-6 col-sm-3 p0 th">发生时间</div>
                %{--<div  class="col-xs-6 col-sm-3 p0 th ">单位名称</div>--}%
                <div  class="col-xs-6 col-sm-2 p0 th">责任人</div>
            </div>
            <div id="marquee1" style="max-height: 105px;margin-top: 40px;">
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
            <div style="float: left;">
                <img src="${request.contextPath}/images/logo.jpg" width="80px" height="80px">&nbsp;
            </div>
            <div style="line-height: 35px;float: left;">
                <div style="font-size: 20px;color: #fff;font-weight: 800;">IPPR&EVCC</div>
                <div style="font-size: 16px;color:#fff749;font-weight: 800;padding:0px 0px;">区域工业环境大数据在线监测系统</div>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12" style="height: 48%;margin-top: 10px;">
           <img src="${request.contextPath}/images/tl.jpg" style="width: 100%;height: 100%;">
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
                        offset: 0,
                        color: '#00a2ff'
                    }, {
                        offset: 1,
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
                    color: ["#c2f5e1", "transparent"],
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

            setPercent(40);
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
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 39%;margin-top: 15px;">
            <div id="rightChart1" style="height: 80px;"></div>
            <div id="rightChart2" style="height: 80px;"></div>
            <div id="rightChart3" style="height: 80px;"></div>
            <script type="text/javascript">
                var rightChart1 = echarts.init(document.getElementById('rightChart1'));
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
                        bottom:'20%'
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
                        data:['蒸发量','降水量','平均温度','平均温度2']
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
                            splitLine: {
                                lineStyle: {
                                    color:'#91e9f838'
                                }
                            },
                            type: 'value'
                        }
                    ],
                    series: [
                        {
                            name:'蒸发量',
                            type:'bar',
                            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
                        },
                        {
                            name:'降水量',
                            type:'bar',
                            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
                        },
                        {
                            name:'平均温度',
                            type:'line',
                            data:[2.0, 2.2, 3.3, 4.5, 6.3, 40.2, 90.3, 143.4, 23.0, 16.5, 12.0, 6.2]
                        }
                        ,
                        {
                            name:'平均温度2',
                            type:'line',
                            data:[1.0, 2.2, 4.3, 2.5, 4.3, 33.2, 110.3, 123.4, 13.0, 13.5, 2.0, 4.2]
                        }
                    ]
                };
                rightChart1.setOption(option);
                rightChart2.setOption(option);
                rightChart3.setOption(option);
            </script>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 18%;margin-top: 10px;">
            <div id="rightChart4" style="height: 110px;"></div>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 18%;margin-top: 15px;">
            <div id="rightChart5" style="height: 110px;"></div>
        </div>
        <div class="col-xs-6 col-sm-12 boxBorder" style="height: 18%;margin-top: 15px;margin-bottom: 10px;">
            <div id="rightChart6" style="height: 110px;"></div>
        </div>

        <script type="text/javascript">
            var rightChart4 = echarts.init(document.getElementById('rightChart4'));
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
                        return "办理数：" + prams[0].data
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
            rightChart6.setOption(option);
        </script>
    </div>
</div>

<script src="${request.contextPath}/js/jquery.kxbdmarquee.min.js"></script>
<script type="text/javascript">
    $('#marquee1').kxbdMarquee({
        direction: 'up',
        isEqual: false
    });
</script>
</body>
</html>