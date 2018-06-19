package com.eyesfly.dictionary

import com.eyesfly.annotation.Title


@Title(zh_CN = "行政区域")
class Area {
    String id;
    String name;
    String code;
    String sort;
    Area parent
    String parentIds;
    static hasMany = [children:Area]
    static belongsTo =[parent:Area]
    static constraints = {
    }
}
