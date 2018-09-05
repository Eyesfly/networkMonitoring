<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/26
  Time: 18:48
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/jquery.min.js"></script>
    <script src="${request.contextPath}/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/js/echarts/echarts3.min.js"></script>
</head>

<body>
<div id="centerChart1" style="height: 540px;"></div>
<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('centerChart1'));
    var option = {
        title: {
            text: '内',
            x: '50%',
            y: '45%',
            textAlign: "center",
            textStyle: {
                fontWeight: 'normal',
                fontSize: 24
            },
            subtextStyle: {
                fontWeight: 'bold',
                fontSize: 32,
                color: '#3ea1ff'
            }
        },
        series: [{
            name: ' ',
            type: 'pie',
            radius: ['50%', '70%'],
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
                    borderWidth: "80"
                },
                emphasis: {
                    borderColor: "transparent",
                    borderWidth: "80"
                }
            },
            z: 10,
            labelLine: {
                normal: {
                    show: false
                }
            },
            data: [{
                value: 7.5
            }, {
                value: 92.5
            }]
        }, {
            name: '',
            type: 'pie',
            radius: ['50%', '70%'],
            startAngle: 225,
            color: ["#fff", "transparent"],
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
    myChart.setOption(option, true);
</script>
</body>
</html>