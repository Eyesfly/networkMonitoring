package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "监测地点")
class MonitoringPlace {
    String name;
    String remark;
    String east;
    String north;
    static constraints = {
        remark(nullable: true)
    }
}
