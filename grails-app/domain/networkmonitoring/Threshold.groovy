package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "阈值设置")
class Threshold {
    @Title(zh_CN = "采集点")
    MeasuringPoint measuringPoint;
    @Title(zh_CN = "加速度值")
    float value1;
    @Title(zh_CN = "位移值")
    float value2;
    @Title(zh_CN = "速度值")
    float value3;
    @Title(zh_CN = "备注")
    float remark
    static constraints = {
    }
}
