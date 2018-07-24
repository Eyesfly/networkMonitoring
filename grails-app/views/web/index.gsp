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
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/echarts/echarts.js"></script>
    <script type="text/javascript">
        $.get('https://raw.githubusercontent.com/Luna829/incubator-echarts/master/map/json/china.json', function (chinaJson) {

            echarts.registerMap('china', chinaJson); // 注册地图
            var levelColorMap = {
                '1': 'rgba(241, 109, 115, .8)',
                '2': 'rgba(255, 235, 59, .7)',
                '3': 'rgba(147, 235, 248, 1)'
            };
            var myData = [

                {name: '海门', value: [121.15, 31.89, 1]},
                {name: '鄂尔多斯', value: [109.781327, 39.608266, 2]},
                {name: '招远', value: [120.38, 37.35, 3]},
                {name: '舟山', value: [122.207216, 29.985295, 2]}
            ]
            var mapChart = echarts.init(document.getElementById('map-wrap'));

            var option = {
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
                backgroundColor: 'rgb(21, 78, 144)',//404a59
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

<body>
<div id="map-wrap" style="height: 800px;">
    <!-- 这里以后是地图 -->
</div>
</body>
</html>