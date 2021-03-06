package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "通道峰值数据")
class ChannelData {
    @Title(zh_CN = "设备ID")
    String devid
    @Title(zh_CN = "通道号")
    String chanCode
    Date createDate
    Float value
    static constraints = {
    }
    static mapping = {
        table("analysis_peak_data")
    }
}
