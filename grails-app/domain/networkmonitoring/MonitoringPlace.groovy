package networkmonitoring

import com.eyesfly.annotation.Title
import com.eyesfly.dictionary.Area

@Title(zh_CN = "监测站")
class MonitoringPlace {
    @Title(zh_CN = "站点名称")
    String name;
    String remark;
    String guid
    @Title(zh_CN = "地理经度")
    float lng;
    @Title(zh_CN = "地理纬度")
    float lat;
    @Title(zh_CN = "状态标识")
    int flag=1;
    @Title(zh_CN = "详细地址")
    String address;
    @Title(zh_CN = "联系人")
    String contact;
    @Title(zh_CN = "联系人电话")
    String phone;
    @Title(zh_CN = "联系人邮箱")
    String email;
    @Title(zh_CN = "所在地区")
    Area area
    byte[] picture;
    @Title(zh_CN = "数据服务器")
    DataServers dataServers;
    static constraints = {
        remark(nullable: true)
        address(nullable: true)
        contact(nullable: true)
        phone(nullable: true)
        email(nullable: true)
        picture nullable:true,size: 0..1024*1024*10
        guid(nullable: true)
        area(nullable: true)
        dataServers(nullable: true)
    }
}
