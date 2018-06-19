package com.eyesfly.core

import com.eyesfly.annotation.Title
import com.eyesfly.dictionary.Organization
import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode(includes='username')
//@ToString(includes='username', includeNames=true, includePackage=false)
@Title(zh_CN = "用户信息")
class BaseUser implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	@Title(zh_CN = "姓名")
	String realName
	@Title(zh_CN = "手机")
	String mobile
	@Title(zh_CN = "邮箱")
	String email
	@Title(zh_CN = "单位")
	Organization organization
	@Title(zh_CN = "是否删除")
	boolean isDel = false
	@Title(zh_CN = '创建日期')
	Date dateCreated
	@Title(zh_CN = '修改日期')
	Date lastUpdated

	BaseUser(String username, String password) {
		this()
		this.username = username
		this.password = password
	}

	Set<BaseRole> getAuthorities() {
		BaseUserBaseRole.findAllByBaseUser(this)*.baseRole
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		realName nullable: true
		mobile nullable: true
		organization nullable: true
		isDel nullable: true
	}

	static mapping = {
		password column: '`password`'
		comment "用户"
		username comment:"用户名"
		password comment:"密码"
		enabled comment:"是否启用"
		accountExpired comment:"帐户过期"
		accountLocked comment:"帐户锁定"
		passwordExpired comment:"密码过期"
		realName comment:"用户姓名"
		mobile comment:"手机号码"
		organization comment:"管理机构"
		isDel comment:"是否删除"
		dateCreated comment:"创建时间"
		lastUpdated comment:"修改时间"
	}
	String toString(){
		return realName?:username;
	}

}
