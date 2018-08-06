<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/24
  Time: 17:23
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
        z-index: 99;
        position: fixed;
        bottom: 0;
        width: 100%;
        height: 220px;
        padding:15px 0px;
        background: rgba(78, 136, 181, 0.66);
    }
    .left{
        z-index: 99;
        position: absolute;
        left: 50px;
        top:50px;
        width: 220px;
        height: 600px;
        padding:15px 0px;
        /*background: rgba(78, 136, 181, 0.66);*/
    }
    .right{
        z-index: 99;
        position: absolute;
        right: 20px;
        top:50px;
        width: 280px;
        height: 600px;
        padding:15px 0px;
        /*background: rgba(78, 136, 181, 0.66);*/
    }
    ul{list-style:none;padding: 0px;}
    #marquee4{overflow:hidden;}
    #marquee4 ul li{float:left;color: #91e9f8;line-height: 30px;font-size: 16px;}
    #marquee5{overflow:hidden;}
    #marquee5 ul li{float:left;color: #91e9f8;line-height: 25px;font-size: 14px;}
    #marquee6{overflow:hidden;}
    #marquee6 ul li{float:left;color: #91e9f8;line-height: 25px;font-size: 14px;}
    </style>
    <script type="text/javascript">
        $.get('${request.contextPath}/js/echarts/china.json', function (chinaJson) {
            echarts.registerMap('china', chinaJson); // 注册地图
            var levelColorMap = {
                '1': 'rgba(241, 109, 115, .8)',
                '2': 'rgba(255, 235, 59, .7)',
                '3': 'rgba(147, 235, 248, 1)'
            };
            /*var myData = [

                {name: '海门', value: [121.15, 31.89, 1]},
                {name: '北京', value: [116.3, 39.9, 1]},
                {name: '鄂尔多斯', value: [109.781327, 39.608266, 2]},
                {name: '招远', value: [120.38, 37.35, 3]},
                {name: '新乡', value: [113.54, 35.18, 3]},
                {name: '舟山', value: [122.207216, 29.985295, 2]}
            ];*/
            var myData = ${raw(list)};
            var mapChart = echarts.init(document.getElementById('map-wrap'));
            mapChart.on('click', function(params){
                if(params.componentType== "series"){
                    console.log(params.data);
                    console.log(params.data.value[0]);
                    console.log(params.data.value[1]);
                    console.log(params.data.value[2]);
                    $("#myModalLabel").html(params.data.name);
                    $("#content").html(params.data.name);
                    $("#myModal").modal("show");
                }

            });//点击事件，此事件还可以用到柱状图等其他地图
            var option = {
                title: {
                    text: '区域工业环境大数据在线监测系统',
                    x: 'center',
                    textStyle:{
                        fontSize:24,
                        color:'#eee'
                    },
                    padding:[15, 0],
                    borderWidth: [15, 0],
                    borderColor:'#fff',
                    top:50
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{b}"
                },
                geo: {
                    map: 'china',
                    zoom: 1,
                    label: {
                        normal: {
                            show: false,
                            textStyle: {
                                color: '#fff'
                            }
                        },
                        emphasis: {
                            textStyle: {
                                color: '#fff'
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            borderColor: 'rgba(147, 235, 248, 1)',
                            borderWidth: 1,
                            areaColor: {
                                type: 'radial',
                                x: 0.5,
                                y: 0.5,
                                r: 0.8,
                                colorStops: [{
                                    offset: 0,
                                    color: 'rgba(147, 235, 248, 0)' // 0% 处的颜色
                                }, {
                                    offset: 1,
                                    color: 'rgba(147, 235, 248, .2)' // 100% 处的颜色
                                }],
                                globalCoord: false // 缺省为 false
                            },
                            shadowColor: 'rgba(128, 217, 248, 1)',
                            // shadowColor: 'rgba(255, 255, 255, 1)',
                            shadowOffsetX: -2,
                            shadowOffsetY: 2,
                            shadowBlur: 10
                        },
                        emphasis: {
                            areaColor: '#389BB7',
                            borderWidth: 0
                        }
                    }
                },
//                backgroundColor: '404a59',//404a59
                series: [{
                    type: 'effectScatter',
                    coordinateSystem: 'geo',
                    // symbol: 'diamond',
                    showEffectOn: 'render',
                    rippleEffect: {
                        period: 15,
                        scale: 6,
                        brushType: 'fill'
                    },
                    label: {
                        normal: {
                            show: true,
                            color: '#fff',
                            position: 'right',
                            formatter: '{b}'
                        }
                    },
                    hoverAnimation: true,
                    itemStyle: {
                        normal: {
                            color: function(params) {
                                return levelColorMap[params.value[2]];
                            },
                            shadowBlur: 10,
                            shadowColor: '#333'
                        }
                    },
                    data: myData
                }]
            }
            mapChart.setOption(option);
        });

    </script>


</head>

<body style="background: rgb(21, 78, 144);">
<div>
    <div id="map-wrap" style="height: 800px;">
        <!-- 这里以后是地图 -->
    </div>
    <div class="left">
        <div style="line-height: 50px;">
            <span style="font-size: 28px;color:#fff749;font-weight: 800;padding:10px 0px;">4,534,221,544</span>
        </div>
        <div><span style="font-size: 16px;color:#91e9f8;font-weight: bold;padding:10px 0px;">监测通道数</span></div>
        <div style="line-height: 50px;">
            <span style="font-size: 28px;color:#fff749;font-weight: 800;padding:10px 0px;">1,343,455</span>
        </div>
        <div><span style="font-size: 16px;color:#91e9f8;font-weight: bold;padding:10px 0px;">监测点数</span></div>
        <div style="line-height: 50px;">
            <span style="font-size: 28px;color:#fff749;font-weight: 800;padding:10px 0px;">323</span>
        </div>
        <div><span  style="font-size: 16px;color:#91e9f8;font-weight: bold;padding:10px 0px;">涉及城市数</span></div>
        <div id="marquee4" style="margin-top: 100px;max-height: 200px;">
            <ul>
                <li>****1监测报告已发送</li>
                <li>****2监测报告已发送</li>
                <li>****3监测报告已发送</li>
                <li>****4监测报告已发送</li>
                <li>****5监测报告已发送</li>
                <li>****6监测报告已发送</li>
                <li>****7监测报告已发送</li>
                <li>****8监测报告已发送</li>
                <li>****9监测报告已发送</li>
                <li>****10监测报告已发送</li>
            </ul>
        </div>
    </div>
    <div class="right">
        <div id="firstChart" style="height: 300px;">

        </div>
        <div id="twoChart" style="height: 300px;">

        </div>
        <script type="text/javascript">
            var myChart1 = echarts.init(document.getElementById('firstChart'));
            var myChart2 = echarts.init(document.getElementById('twoChart'));
            myChart1.setOption( {
                title: {
                    text: '在线客户数',
                    textStyle:{
                        color:'#91e9f8'
                    },
                    top:20
                },
                xAxis: {
                    type: 'category',
                    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    axisLine:{
                        lineStyle:{
                            color:'#91e9f8'
                        }
                    },
                    axisLabel:{
                        color:'#fff'
                    }
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
                    splitLine: {
                        lineStyle: {
                            color:'#91e9f838'
                        }
                    }
                },
                series: [{
                    data: [120, 932, 901,56, 1290, 1330, 1320],
                    type: 'line',
                    smooth: true,
                    lineStyle:{
                        color:'#91e9f8'
                    }
                }]
            });
            myChart2.setOption( {
                title: {
                    text: '服务器内存使用情况',
                    textStyle:{
                        color:'#91e9f8'
                    },
                    top:20
                },
                xAxis: {
                    type: 'category',
                    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    axisLine:{
                        lineStyle:{
                            color:'#91e9f8'
                        }
                    },
                    axisLabel:{
                        color:'#fff'
                    }
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
                    splitLine: {
                        lineStyle: {
                            color:'#91e9f838'
                        }
                    }
                },
                series: [{
                    data: [120, 23, 901,456, 290, 1330, 320],
                    type: 'line',
                    smooth: true,
                    lineStyle:{
                        color:'#91e9f8'
                    }

                }]
            });
        </script>
    </div>
    <div class="child">
        <div class="col-xs-6 col-sm-3"
             style="border-right: 1px solid #93ebf84f;height:100%;">
                <div>
                    <img src="${request.contextPath}/images/logo.jpg" width="80px" height="80px">&nbsp;<span style="font-size: 24px;color: #fff;font-weight: 400;">IPPR&EVCC</span>
                </div>
                <div style="line-height: 80px;">
                    <span style="font-size: 24px;color:#fff749;font-weight: 400;padding:10px 0px;">区域工业环境大数据在线监测系统</span>
                </div>
        </div>
        <div class="col-xs-6 col-sm-3"
             style="border-right: 1px solid #93ebf896;height:100%;">
                <div style="color: #fff;font-weight: bolder;font-size: 16px;">各监控测点接入数据量</div>
            <div id="marquee5" style="margin-top: 20px;max-height: 130px;">
                <ul>
                    <li class="col-sm-12">
                        <div  class="col-xs-6 col-sm-8">监控测点1</div>
                        <div  class="col-xs-6 col-sm-4">1223</div>
                    </li>
                    <li class="col-sm-12">
                        <div  class="col-xs-6 col-sm-8">监控测点2</div>
                        <div  class="col-xs-6 col-sm-4">1223</div>
                    </li>
                    <li class="col-sm-12">
                        <div  class="col-xs-6 col-sm-8">监控测点3</div>
                        <div  class="col-xs-6 col-sm-4">1223</div>
                    </li>
                    <li class="col-sm-12">
                        <div  class="col-xs-6 col-sm-8">监控测点4</div>
                        <div  class="col-xs-6 col-sm-4">1223</div>
                    </li>
                    <li class="col-sm-12">
                        <div  class="col-xs-6 col-sm-8">监控测点5</div>
                        <div  class="col-xs-6 col-sm-4">1223</div>
                    </li>
                    <li class="col-sm-12">
                        <div  class="col-xs-6 col-sm-8">监控测点6</div>
                        <div  class="col-xs-6 col-sm-4">1223</div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-xs-6 col-sm-3"
             style="border-right: 1px solid #93ebf84f;height:100%;">
            <div style="color: #fff;font-weight: bolder;font-size: 16px;">各监控点报警情况</div>
            <div id="pieChart" style="height: 200px;">

            </div>
            <script type="text/javascript">
                var pieChart = echarts.init(document.getElementById('pieChart'));
                pieChart.setOption({
                    tooltip : {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    visualMap: {
                        show: false,
                        min: 80,
                        max: 600,
                        inRange: {
                            colorLightness: [0, 1]
                        }
                    },
                    series : [
                        {
                            name:'访问来源',
                            type:'pie',
                            radius : '70%',
                            center: ['50%', '50%'],
                            data:[
                                {value:335, name:'北京'},
                                {value:310, name:'海门'},
                                {value:274, name:'招远'},
                                {value:235, name:'舟山'},
                                {value:400, name:'新乡'}
                            ].sort(function (a, b) { return a.value - b.value; }),
                            roseType: 'radius',
                            label: {
                                normal: {
                                    textStyle: {
                                        color: 'rgba(255, 255, 255, 0.7)'
                                    }
                                }
                            },
                            labelLine: {
                                normal: {
                                    lineStyle: {
                                        color: 'rgba(255, 255, 255, 0.3)'
                                    },
                                    smooth: 0.2,
                                    length: 10,
                                    length2: 20
                                }
                            },
                            itemStyle: {
                                normal: {
                                    color: '#91e9f8'
                                }
                            },
                            animationType: 'scale',
                            animationEasing: 'elasticOut',
                            animationDelay: function (idx) {
                                return Math.random() * 200;
                            }
                        }
                    ]
                });
            </script>
        </div>
        <div class="col-xs-6 col-sm-3"
             style="">
            <div style="color: #fff;font-weight: bolder;font-size: 16px;">设备分布情况</div>
            <div id="marquee6" style="margin-top: 20px;max-height: 130px;">
                <ul>
                    <g:each in="${networkmonitoring.MonitoringPlace.list()}" var="obj">
                        <li class="col-sm-12">
                            <div  class="col-xs-6 col-sm-8">${obj.east}    ${obj.north}</div>
                            <div  class="col-xs-6 col-sm-4">${obj.name}</div>
                        </li>
                    </g:each>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">

                </h4>
            </div>
            <div class="modal-body" id="content">
                在这里添加一些文本
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script src="http://code.ciaoca.com/jquery/kxbdmarquee/demo/js/jquery.kxbdmarquee.min.js"></script>
<script type="text/javascript">
    $('#marquee4').kxbdMarquee({
        direction: 'up',
        isEqual: false
    });
    $('#marquee5').kxbdMarquee({
        direction: 'up',
        isEqual: false
    });
    $('#marquee6').kxbdMarquee({
        direction: 'up',
        isEqual: false
    });
</script>
</body>

</html>