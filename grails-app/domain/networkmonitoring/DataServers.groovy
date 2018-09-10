package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "服务器数据表")
class DataServers {
    @Title(zh_CN = "服务器地址")
    String address;
    @Title(zh_CN = "备注")
    String remark;
    @Title(zh_CN = "服务器标识")
    int serverFlag;
    static constraints = {
    }
}
