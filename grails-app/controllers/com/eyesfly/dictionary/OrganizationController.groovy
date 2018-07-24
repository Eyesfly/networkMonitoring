package com.eyesfly.dictionary

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrganizationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    /**
     * 机构管理列表页
     */
    def index() {
    }

    /**
     * 机构管理脚本
     */
    def js(){
    }

    /**
     * jstree json 归属机构
     * pid有值：显示pid对应机构下的机构树
     * pid无值：是超管：默认显示四级树
     *         非超管：type无值：默认四级树
     *                type有值：当前登录用户的管理机构以下的树
     */
    def orgJson() {
        def org2 = params?.pid?Organization.read(params.pid):(springSecurityService.currentUser.getAuthorities()?.authority?.contains("ROLE_SUPERADMIN")?Organization.findByCode("100000"):params?.type?springSecurityService.currentUser?.organization:Organization.findByCode("100000"));
        def org = params?.id?.equals("#")?org2:Organization.read(params?.id);
        def orgs = params?.id?.equals("#")?org2:Organization?.findAll("from Organization where parent = ? order by sort asc",[org]);
        def list = [];
        orgs.each { org1 ->
            def map = [:];
            map.id = org1.id;
            map.text = org1.name;
            map.state = [:];
            if(!org1.children.isEmpty()){
                map.children = true;
            }
            map.type = "root";
            list << map;
        }
        render list as JSON;
    }

    def orgJson1() {
        def userOrg = springSecurityService.currentUser?.organization;
        def org = [id:0,name:'单位'];
        def orgs = Organization.findAll();
        def list = [];
        orgs.each{org1->
            def map = [:];
            map.id = org1.id;
            map.text = org1.name;
            map.children = [];
            map.type = "root";
            list << map;
        }
        def map = [:]
        map.id = org?.id;
        map.text = org?.name;
        map.children = list;
        map.type = "root";
        def list2 = [];
        list2 << map;
        render list2 as JSON;
    }
}
