package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "数据文件")
class SamplingDataFile {
    @Title(zh_CN = "设备标识")
    String devid;
    @Title(zh_CN = "通道号")
    String chanCode;
    long size;
    Date samplingTime;
    @Title(zh_CN = "文件存储路径")
    String path;
    static constraints = {
    }
}
