package com.eyesfly.core

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import org.springframework.http.HttpMethod

@EqualsAndHashCode(includes=['configAttribute', 'httpMethod', 'url'])
@ToString(includes=['configAttribute', 'httpMethod', 'url'], cache=true, includeNames=true, includePackage=false)
class Requestmap implements Serializable {

	private static final long serialVersionUID = 1

	String configAttribute
	HttpMethod httpMethod
	String url

	Requestmap(String url, String configAttribute, HttpMethod httpMethod = null) {
		this()
		this.configAttribute = configAttribute
		this.httpMethod = httpMethod
		this.url = url
	}

	static constraints = {
		configAttribute blank: false
		httpMethod nullable: true
		url blank: false, unique: 'httpMethod'
	}

	static mapping = {
		cache true
		comment "访问请求"
		configAttribute comment:"配置属性"
		httpMethod comment:"访问方法"
		url comment:"链接"
	}
}
