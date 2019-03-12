package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "数据表")
class SamplingData {
    @Title(zh_CN = "设备标识")
    String devid;
    @Title(zh_CN = "通道号")
    String chanCode;
    String data;
    Date samplingTime;
    static constraints = {
    }
}
