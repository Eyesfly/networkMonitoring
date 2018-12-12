package com.eyesfly.web

import com.eyesfly.core.BaseUserBaseRole
import com.eyesfly.dictionary.News
import com.eyesfly.dictionary.NewsContent
import grails.converters.JSON
import grails.transaction.Transactional
import org.hibernate.criterion.CriteriaSpecification

import javax.servlet.http.HttpServletRequest

class NewsController {

    def springSecurityService;
    def moveList={
    }
    /**
     * 列表页
     * @return
     */
    def list() {

    }

    /**
     * 脚本
     */
    def js() {

    }

    /**
     * bootstrap json
     * @return
     */
    def json() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.offset) params.offset = '0'
        if (!params.sort) params.sort = 'id'
        if (!params.order) params.order = 'desc'

        def total = News.createCriteria().count {
            if(params?.status){
                eq('status',params?.status)
            }
            if(params?.keywords){
                ilike("title","%${params?.keywords?.trim()}%")
            }
        }
        def ecList = []
        News.createCriteria().list {
            if(params?.status){
                eq('status',params?.status)
            }
            if(params?.keywords){
                ilike("title","%${params?.keywords?.trim()}%")
            }
            order("isSticky","desc")
            order("stickyDate","desc")
            order(params.sort,params.order)
            maxResults(params.max.toInteger())
            firstResult(params.offset.toInteger())
        }.each {
            def ecMap = [:]
            ecMap.id = it?.id;
            ecMap.title = it?.name;
            ecMap.publishDate = it?.publishDate?.format('yyyy-MM-dd');
            ecMap.status = it?.status;
            ecMap.isSticky = it?.isSticky;
            ecList << ecMap
        }
        def map = [:]
        map.rows = ecList;
        map.total=total;
        render map as JSON;
    }

    /**
     * 新增页面
     * @return
     */
    def create() {

    }

    /**
     * 编辑页面
     * @return
     */
    def edit() {
        def news = News.get(params.id?.toLong()?:-1l);
        def newsContentList = [];
        if(news){
            newsContentList = NewsContent.findAllByNews(news);
        }

        return [news:news,newsContentList:newsContentList]
    }

    /**
     * 保存或编辑
     * @return
     */
    @Transactional
    def saveOrUpdate() {
        println params;
        def map = [:], news
        if(params?.id){
            news = News.read(params?.id)
            news.properties = params;
            news.updater = springSecurityService.currentUser;
        }else{
            news = new News(params);
            news.creater = springSecurityService.currentUser;
            news.updater = springSecurityService.currentUser;
        }

        news.publishDate = params?.publishDate?Date.parse("yyyy-MM-dd", params?.publishDate?.trim()):new Date();
        if(news.save(flush: true)){
            if(params.content&&params.content.class.name == 'java.lang.String'){
                def obj = null;
                if(params.projectId){
                    obj= NewsContent.get(params.projectId?.toLong()?:-1l);
                }
                def projectName = params.projectName;
                if(obj){
                    obj.content =params.content;
                    obj.name =projectName;
                }else{
                    obj = new NewsContent(news: news,content: params.content,sort:0,name: projectName);
                }
                if(obj){
                    obj.save(flush: true);
                }
            }else{
                params.content?.eachWithIndex{def content,def i->

                    def projectId =null
                    try{
                        projectId = params.projectId?.getAt(i);
                    }catch (ArrayIndexOutOfBoundsException e){

                    }
                    def obj = null;
                    if(projectId){
                        obj = NewsContent.get(projectId?.toLong()?:-1l);
                    }

                    def projectName = params.projectName[i];
                    if(obj){
                        obj.content =content;
                        obj.name =projectName;
                    }else{
                        obj = new NewsContent(news: news,content: content,sort:i,name: projectName);
                    }
                    if(obj){
                        obj.save(flush: true);
                    }
                }
            }


            map.result = true
            map.message = "保存成功"
        }else{
            println news.errors.allErrors
            map.result = false
            map.message = "保存失败"
        }
        render "${map as JSON}"
    }

    /**
     * 删除
     * @return
     */
    @Transactional
    def delNews() {
        def map = [:]
        def news = News.read(params?.newsId)
        try {
            news.delete(flush: true)
            map.result = true
            map.message = "删除成功"
        }catch (e){
            println e
            map.result = false
            map.message = "删除失败"
        }
        render map as JSON
    }

    /**
     * 批量删除
     */
    def ajaxDeletes={
        def map = [:];
        def ids = params.fileIds?.split(',').toList().collect { it.toLong() };
        News.withTransaction { status ->
            try{
                News.where{
                    id in ids
                }.deleteAll();
                map.result= true;
                map.message =  '删除成功';
            }catch(e){
                map.result = false;
                map.message = '删除失败';
                status.setRollbackOnly();
            }
        }
        render map as JSON;
    }

    /**
     * 预览页面
     * @return
     */
    def show() {
        def news = News.read(params?.newsId)
        return [news:news]
    }

    /**
     * 发布、撤回、置顶、取消置顶
     * @return
     */
    @Transactional
    def changeNews() {
        def map = [:]
        def news = News.read(params?.id)
        if(params?.status == '1'){
            news.status = '发布';
            news.publisher = springSecurityService?.currentUser;
        }
        if(params?.status == '2'){
            news.status = '撤回';
            news.revoker = springSecurityService?.currentUser;
        }
        if(params?.status == '3'){
            news.isSticky = true;
            news.stickyDate = new Date();
        }
        if(params?.status == '4'){
            news.isSticky = false;
            news.stickyDate = null;
        }
        if(news.save(flush: true)){
            map.result = true
            map.message = "操作成功"
        }else{
            println news.errors.allErrors
            map.result = false
            map.message = "操作失败"
        }
        render map as JSON;
    }

    public boolean isMSBrowser(HttpServletRequest request) {
        String[] IEBrowserSignals = ["MSIE", "Trident", "Edge"];
        String userAgent = request.getHeader("User-Agent");
        for (String signal : IEBrowserSignals) {
            if (userAgent.contains(signal)){
                return true;
            }
        }
        return false;
    }

    def ck(){

    }
}
