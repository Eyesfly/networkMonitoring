package networkmonitoring

import com.eyesfly.annotation.Title

@Title(zh_CN = "通道")
class Passageway {
    @Title(zh_CN = "采集点")
    MeasuringPoint measuringPoint;
    @Title(zh_CN = "通道代码")
    String chanCode;
    @Title(zh_CN = "通道名称")
    String chanName;
    /**
     * 1: 加速度
     * 2: 位移
     * 3: 速度
     */
    @Title(zh_CN = "类型")
    String type;
    @Title(zh_CN = "单位")
    String unit;
    @Title(zh_CN = "启用标识")
    boolean flag = true;
    Date dateCreated
    Date lastUpdated
    static constraints = {
    }
    String getUnitText(){
       def map =  ["1":'加速度',"2":'位移',"3":'速度'];
        return map[type]
    }

}
