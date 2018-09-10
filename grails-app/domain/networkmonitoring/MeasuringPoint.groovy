package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "测点")
class MeasuringPoint {
    @Title(zh_CN = "监测点")
    MonitoringPlace monitoringPlace;
    @Title(zh_CN = "通道号")
    int chanCode;
    @Title(zh_CN = "通道名称")
    String chanName
    @Title(zh_CN = "状态标识")
    int flag;
    static constraints = {
    }
}
