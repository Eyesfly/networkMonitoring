package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "测点")
class MeasuringPoint {
    @Title(zh_CN = "采集点")
    MonitoringPlace monitoringPlace;
    @Title(zh_CN = "编号")
    String code;
    static constraints = {
    }
}
