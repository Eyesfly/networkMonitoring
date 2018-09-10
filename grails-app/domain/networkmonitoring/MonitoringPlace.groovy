package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "采集点")
class MonitoringPlace {
    String name;
    String remark;
    @Title(zh_CN = "地理经度")
    float lng;
    @Title(zh_CN = "地理纬度")
    float lat;
    String path3D;
    @Title(zh_CN = "状态标识")
    int flag=1;
    @Title(zh_CN = "数据服务器")
    DataServers dataServers;
    static constraints = {
        remark(nullable: true)
        path3D(nullable: true)
        dataServers(nullable: true)
    }
}
