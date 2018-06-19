package com.eyesfly.core

import com.eyesfly.annotation.Title
import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode(includes='authority')
//@ToString(includes='authority', includeNames=true, includePackage=false)
@Title(zh_CN = "角色信息")
class BaseRole implements Serializable {

	private static final long serialVersionUID = 1

	@Title(zh_CN = "角色名称")
	String name
	@Title(zh_CN = "角色权限")
	String authority
	@Title(zh_CN = "描述")
	String description
	@Title(zh_CN = '菜单权限')
	String menuItems
	@Title(zh_CN = "是否删除")
	boolean isDel = false

	BaseRole(String authority) {
		this()
		this.authority = authority
	}

	static constraints = {
		authority blank: false, unique: true
		name blank: false
		description blank: false
		menuItems size: 0..4000,nullable: true
		isDel nullable: true
	}

	static mapping = {
		cache true
		comment "角色"
		name comment:"角色名称"
		authority comment:"角色名称"
		description comment:"角色名称"
		menuItems comment:"角色名称"
		isDel comment:"角色名称"
	}
	String toString(){
		return name;
	}
}
