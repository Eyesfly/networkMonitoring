package com.eyesfly.dictionary

import com.eyesfly.annotation.Title


@Title(zh_CN = "单位机构")
class Organization {
    @Title(zh_CN = "机构id")
    String id
    @Title(zh_CN = "单位代码")
    String code
    @Title(zh_CN = "单位名称")
    String name
    @Title(zh_CN = "上级单位")
    Organization parent
    @Title(zh_CN = "上级机构路径")
    String parent_ids
    @Title(zh_CN = "机构简称")
    String short_name
    @Title(zh_CN = "上级部门名称路径")
    String parent_names
    //删除标记 1：是；0：否
    @Title(zh_CN = "删除标记")
    String del_flag
    @Title(zh_CN = "所在市")
    Area city
    //是否主机构：0：否；1：是
    @Title(zh_CN = "是否主机构")
    String is_primary
    @Title(zh_CN = "排序值")
    Integer sort=0
    static organizationTree = null;
    static hasMany = [children:Organization]
    static belongsTo =[parent:Organization]

    static constraints = {
        id(nullable: true)
        code(nullable: true)
        name(nullable: false)
        parent(nullable: true)
        parent_ids(nullable: true)
        short_name(nullable: true)
        parent_names(nullable: true)
        del_flag(nullable: true)
        city(nullable: true)
        is_primary(nullable: true)
        sort(nullable: true)
    }

    static mapping = {
        children(sort: 'sort')
        table("sys_office")
        version(false);
    }

    String toString() {
        return name;
    }

    static List getOrgs(def orgs,def list,def permissions){
        if(!organizationTree){
            organizationTree = getSubOrgs(orgs, list, permissions);
        }
        return organizationTree;
    }

    static List getSubOrgs(def orgs,def list,def permissions){
        orgs.each {org->
            def map = [:];
            map.id = org.id;
            map.text = org.name;
            map.children = []
            if(permissions && permissions?.contains("${org.id}") && org.children.isEmpty()){
                map.state.selected = true
            }
            if(!org.children.isEmpty()){
                def temList = [];
                map.children = getSubOrgs(org.children,temList,permissions);
                map.type = "root";
            }else{
                map.type = "root";
            }
            list << map;
        }
        return list;
    }
}
