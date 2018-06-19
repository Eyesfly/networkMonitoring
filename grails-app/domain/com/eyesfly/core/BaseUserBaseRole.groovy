package com.eyesfly.core

import com.eyesfly.annotation.Title
import grails.gorm.DetachedCriteria
import groovy.transform.ToString
import org.apache.commons.lang.builder.HashCodeBuilder

@ToString(cache=true, includeNames=true, includePackage=false)
@Title(zh_CN = "用户角色信息")
class BaseUserBaseRole implements Serializable {

	private static final long serialVersionUID = 1
	@Title(zh_CN = "用户信息")
	BaseUser baseUser
	@Title(zh_CN = "角色信息")
	BaseRole baseRole

	BaseUserBaseRole(BaseUser u, BaseRole r) {
		this()
		baseUser = u
		baseRole = r
	}

	@Override
	boolean equals(other) {
		if (!(other instanceof BaseUserBaseRole)) {
			return false
		}

		other.baseUser?.id == baseUser?.id && other.baseRole?.id == baseRole?.id
	}

	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (baseUser) builder.append(baseUser.id)
		if (baseRole) builder.append(baseRole.id)
		builder.toHashCode()
	}

	static BaseUserBaseRole get(long baseUserId, long baseRoleId) {
		criteriaFor(baseUserId, baseRoleId).get()
	}

	static boolean exists(long baseUserId, long baseRoleId) {
		criteriaFor(baseUserId, baseRoleId).count()
	}

	private static DetachedCriteria criteriaFor(long baseUserId, long baseRoleId) {
		BaseUserBaseRole.where {
			baseUser == BaseUser.load(baseUserId) &&
			baseRole == BaseRole.load(baseRoleId)
		}
	}

	static BaseUserBaseRole create(BaseUser baseUser, BaseRole baseRole, boolean flush = false) {
		def instance = new BaseUserBaseRole(baseUser: baseUser, baseRole: baseRole)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(BaseUser u, BaseRole r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = BaseUserBaseRole.where { baseUser == u && baseRole == r }.deleteAll()

		if (flush) { BaseUserBaseRole.withSession { it.flush() } }

		rowCount
	}

	static void removeAll(BaseUser u, boolean flush = false) {
		if (u == null) return

		BaseUserBaseRole.where { baseUser == u }.deleteAll()

		if (flush) { BaseUserBaseRole.withSession { it.flush() } }
	}

	static void removeAll(BaseRole r, boolean flush = false) {
		if (r == null) return

		BaseUserBaseRole.where { baseRole == r }.deleteAll()

		if (flush) { BaseUserBaseRole.withSession { it.flush() } }
	}

	static constraints = {
		baseRole validator: { BaseRole r, BaseUserBaseRole ur ->
			if (ur.baseUser == null || ur.baseUser.id == null) return
			boolean existing = false
			BaseUserBaseRole.withNewSession {
				existing = BaseUserBaseRole.exists(ur.baseUser.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['baseUser', 'baseRole']
		version false
		comment "用户角色映射"
		baseRole comment:"角色"
		baseUser comment:"用户"
	}
}
