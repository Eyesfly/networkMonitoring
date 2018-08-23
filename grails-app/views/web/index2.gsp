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
    <script src="${request.contextPath}/js/echarts/echarts.js"></script>
    <style type="text/css">
        .child{
            width: 100%;
            padding:0px;
        }
    </style>
</head>

<body style="background: rgb(21, 78, 144);">
<div class="child">
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12" style="height: 30%;">
            <div id="firstChart" style="height: 300px;">

            </div>
            <script type="text/javascript">
                var data = [
                    ["0",116],["1",129],["27",135],["3",86],["4",73],["5",85],["6",73],["7",68],["8",92],["9",130],["10",245],["11",139],["12",115],["13",111],["14",309],["15",206],["16",137],["17",128],["18",85],["19",94],["20",71],["21",106],["22",84],["23",93],["24",85],["25",73],["26",83],["27",125],["28",107],["29",82],["2000-07-05",44],["2000-07-06",72],["2000-07-07",106],["2000-07-08",107],["2000-07-09",66],["2000-07-10",91],["2000-07-11",92],["2000-07-12",113],["2000-07-13",107],["2000-07-14",131],["2000-07-15",111],["2000-07-16",64],["2000-07-17",69],["2000-07-18",88],["2000-07-19",77],["2000-07-20",83],["2000-07-21",111],["2000-07-22",57],["2000-07-23",55],["2000-07-24",60]];

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
                    }],
                    title: [{
                        left: 'center',
                        text: ''
                    }, {
                        top: '55%',
                        left: 'center',
                        text: ''
                    }],
                    tooltip: {
                        trigger: 'axis'
                    },
                    xAxis: [{
                        type: 'category',
                        boundaryGap: false,
                        data: dateList
                    }, {
                        type: 'category',
                        boundaryGap: false,
                        data: dateList,
                        gridIndex: 1
                    }],
                    yAxis: [{
                        type: 'value',
                        splitLine: {show: false}
                    }, {
                        type: 'value',
                        splitLine: {show: false},
                        gridIndex: 1
                    }],
                    grid: [{
                        top: '5%',
                        bottom: '65%'
                    }, {
                        top: '50%',
                        bottom: '20%'
                    }],
                    series: [{
                        type: 'line',
                        showSymbol: false,
                        areaStyle: {},
                        data: valueList
                    }, {
                        type: 'line',
                        showSymbol: false,
                        areaStyle: {},
                        data: valueList,
                        xAxisIndex: 1,
                        yAxisIndex: 1
                    }]
                });
            </script>
        </div>
        <div class="col-xs-6 col-sm-12" style="height: 30%;">1</div>
        <div class="col-xs-6 col-sm-12" style="height: 30%;">1</div>
        <div class="col-xs-6 col-sm-12" style="height: 10%;">1</div>
    </div>
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12" style="height: 50%;">1</div>
        <div class="col-xs-6 col-sm-12" style="height: 25%;">1</div>
        <div class="col-xs-6 col-sm-12" style="height: 25%;">1</div>
    </div>
    <div class="col-xs-6 col-sm-4">
        <div class="col-xs-6 col-sm-12" style="height: 40%;">
            <div id="rightChart1" style="height: 120px;"></div>
            <div id="rightChart2" style="height: 120px;"></div>
            <div id="rightChart3" style="height: 120px;"></div>
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
                        left: '5%',
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
                            data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
                        }
                    ],
                    yAxis: [
                        {
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
        <div class="col-xs-6 col-sm-12" style="height: 20%;">
            <div id="rightChart4" style="height: 140px;"></div>
        </div>
        <div class="col-xs-6 col-sm-12" style="height: 20%;">
            <div id="rightChart5" style="height: 140px;"></div>
        </div>
        <div class="col-xs-6 col-sm-12" style="height: 20%;">
            <div id="rightChart6" style="height: 140px;"></div>
        </div>

        <script type="text/javascript">
            var rightChart4 = echarts.init(document.getElementById('rightChart4'));
            var rightChart5 = echarts.init(document.getElementById('rightChart5'));
            var rightChart6 = echarts.init(document.getElementById('rightChart6'));
            var xData = ['1月','2月','3月','4月','5月'];
            var yData = [80,87,51,81,23,45,33];
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
                    bottom: '0%',
                    top: '8%',
                    height: '90%',
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
                            color: '#0c3b71'
                        }
                    },
                    axisLabel: {
                        show: true,
                        color: 'rgb(170,170,170)',
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
                            color: '#0c3b71'
                        }
                    },
                    axisLabel: {
                        color: 'rgb(170,170,170)',
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
</body>
</html>