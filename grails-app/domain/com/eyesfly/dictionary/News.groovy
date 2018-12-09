package com.eyesfly.dictionary

import com.eyesfly.annotation.Title
import com.eyesfly.core.BaseUser
import org.grails.databinding.BindingFormat

@Title(zh_CN='发布内容')
class News {

    @Title(zh_CN='标题')
    String name
    @Title(zh_CN='创建人')
    BaseUser creater
    @Title(zh_CN='修改人')
    BaseUser updater
    @Title(zh_CN='发布人')
    BaseUser publisher
    @Title(zh_CN='撤销人')
    BaseUser revoker
    @Title(zh_CN='状态')
    String status = "草稿"
    @Title(zh_CN='发布日期')
    @BindingFormat("yyyy-MM-dd")
    Date publishDate = new Date()
    @Title(zh_CN='排序数值')
    int sq=0
    @Title(zh_CN='点击量')
    int clicks
    @Title(zh_CN='是否置顶')
    boolean isSticky = false
    @BindingFormat("yyyy-MM-dd HH24:mm:ss")
    @Title(zh_CN='置顶时间')
    Date stickyDate
    Date dateCreated
    Date lastUpdated
    static constraints = {
        name(nullable: false)
        creater(nullable:false)
        updater(nullable:false)
        publisher(nullable:true)
        revoker(nullable:true)
        status(nullable: false,inList: ['草稿','发布','撤回'])
        publishDate(nullable:true)
        sq(nullable:true)
        isSticky(nullable:true)
        stickyDate(nullable:true)
    }
}