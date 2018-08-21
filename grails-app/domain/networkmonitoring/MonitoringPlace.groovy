package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "采集点")
class MonitoringPlace {
    String name;
    String remark;
    String east;
    String north;
    byte[] img;
    static constraints = {
        remark(nullable: true)
        img(nullable: true)
    }
}
