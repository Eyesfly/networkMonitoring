package com.eyesfly.dictionary

import com.eyesfly.annotation.Title

@Title(zh_CN = "菜单")
class Menu {

    @Title(zh_CN = "菜单名称")
    String name
    @Title(zh_CN = "菜单链接")
    String link
    @Title(zh_CN = "排序")
    Integer sortNum = 0
    @Title(zh_CN = "可见")
    Boolean visible
    @Title(zh_CN = "上级菜单")
    Menu menu
    @Title(zh_CN = "备注")
    String remark
    static hasMany = [children:Menu]
    static belongsTo =[menu:Menu]

    static constraints = {
        name(size:0..100,blank: false,nullable: false)
        link(blank: true,nullable: true)
        sortNum(blank: true,nullable: true)
        visible(blank: true,nullable: true)
        menu(blank: true,nullable: true)
        remark(blank: true,nullable: true)
    }

    static mapping = {
        children(sort: 'sortNum')
        version(false);
        comment "菜单"
        name comment:"菜单名称"
        link comment:"菜单链接"
        sortNum comment:"排序"
        visible comment:"可见"
        menu comment:"上级菜单"
        remark comment:"备注"
    }
}
