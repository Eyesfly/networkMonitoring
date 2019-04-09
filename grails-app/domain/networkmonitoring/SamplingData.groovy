package networkmonitoring

import com.eyesfly.annotation.Title

import java.sql.Timestamp

@Title(zh_CN = "数据表")
class SamplingData {
    @Title(zh_CN = "设备标识")
    String devid;
    @Title(zh_CN = "通道号")
    String chanCode;
    String data;
    Timestamp samplingTime;
    static constraints = {
    }
}
