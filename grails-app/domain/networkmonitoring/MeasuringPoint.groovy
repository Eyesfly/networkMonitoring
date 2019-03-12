package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "采集点")
class MeasuringPoint {
    @Title(zh_CN = "监测点")
    MonitoringPlace monitoringPlace;
    @Title(zh_CN = "设备标识")
    String devid
    @Title(zh_CN = "设备IP")
    String ip;
    @Title(zh_CN = "设备名称")
    String name
    @Title(zh_CN = "状态标识")
    int flag;
    Date dateCreated
    Date lastUpdated
    static constraints = {
    }
}
