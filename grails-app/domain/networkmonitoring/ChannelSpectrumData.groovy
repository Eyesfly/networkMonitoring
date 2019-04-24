package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "通道频谱数据")
class ChannelSpectrumData {
    @Title(zh_CN = "设备ID")
    String devid
    @Title(zh_CN = "通道号")
    String chanCode
    Date analysisTime
    String data
    static constraints = {
    }
    static mapping = {
        table("analysis_spectrum_data")
        data type: 'text'
    }

}
