package com.eyesfly.core

import com.eyesfly.dictionary.Menu
import com.eyesfly.dictionary.Organization
import com.eyesfly.utils.PinyinUtils
import grails.converters.JSON
import grails.transaction.Transactional
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
class BaseRoleController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    /**
     * 角色管理列表页
     */
    def list() {

    }

    /**
     * 角色管理脚本
     */
    def js(){
    }

    /**
     * bootstrap table json
     */
    def json() {
        params.max = Math.min(params.limit ? params.int('limit') : 10, 100);
        params.limit = params.max;
        if (!params.offset) params.offset = '0'
        if (!params.sort) params.sort = 'id'
        if (!params.order) params.order = 'desc'

        def ecCount = BaseRole.createCriteria().count {
            if(params?.keywords){
                or{
                    ilike("name","%${params.keywords?.trim()}%")
                    ilike("description","%${params.keywords?.trim()}%")
                }
            }
        }
        def ecList = BaseRole.createCriteria().list {

            if(params?.keywords){
                or{
                    ilike("name","%${params.keywords?.trim()}%")
                    ilike("description","%${params.keywords?.trim()}%")

                }
            }
            order(params.sort, params.order)
            maxResults(params.max.toInteger())
            firstResult(params.offset.toInteger())
        }
        def map = [:];
        map.total = ecCount;
        map.rows = ecList;
        render map as JSON;
    }

    /**
     * 分配页面
     */
    def userList(){
        def currentUser = springSecurityService.currentUser;
        return [baseRole:BaseRole.read(params?.roleId)];
    }

    /**
     * 拥有当前角色的用户JSON
     * @return
     */
    def userJson() {
        params.max = Math.min(params.limit ? params.int('limit') : 10, 100);
        params.limit = params.max;
        if (!params.offset) params.offset = '0'
        if (!params.sort) params.sort = 'id'
        if (!params.order) params.order = 'desc'
        def list = []
        if(params?.keywords){
            list = BaseUserBaseRole.executeQuery("from BaseUserBaseRole ur, BaseRole r, BaseUser u where r = ur.baseRole and u = ur.baseUser and r.id = ? and (u.username like ? or u.realName like ?) order by ? desc", [params?.id?.toLong(), "%${params?.keywords?.trim()}%", "%${params?.keywords?.trim()}%", params.sort])
        }else{
            list = BaseUserBaseRole.executeQuery("from BaseUserBaseRole ur, BaseRole r where r = ur.baseRole and r.id = ?", [params?.id?.toLong()])
        }
        def ecList = [], rows = [];
        if(list.size()>=params.offset.toInteger()){
            if(list.size()>=params.offset.toInteger()+params.max.toInteger()){
                ecList = list.subList(params.offset.toInteger(), params.offset.toInteger()+params.max.toInteger());
            }else{
                ecList = list.subList(params.offset.toInteger(), list.size());
            }
        }
        ecList.each {
            def user = it.getAt(0).baseUser;
            def userMap = [:];
            userMap.id = user?.id;
            userMap.realName = user?.realName;
            userMap.username = user?.username;
            userMap.mobile = user?.mobile;
            userMap.organization = user?.organization?.name;
            rows << userMap;
        }
        def map = [:];
        map.total = list.size();
        map.rows = rows;
        render map as JSON;
    }

    /**
     * 把用户从角色下移除
     */
    @Transactional
    def removeUser(){
        def map = [:];
        def user = BaseUser.read(params?.userId);
        def role = BaseRole.read(params?.roleId);
        def userRole = BaseUserBaseRole.findByBaseUserAndBaseRole(user, role);
        params.traceLogNeedSave = true;
        params.operating ="角色移除用户";
        params.beforeJson = "${userRole as JSON}";
        BaseUserBaseRole.remove(user, role, true);
        map.result = true;
        map.message = "移除成功";
        render map as JSON;
    }

    def orgUserTree(){
        def role = BaseRole.read(params?.roleId);
        def users = BaseUserBaseRole.findAllByBaseRole(role)?.baseUser;
        def permission = users?.id;
        return [role: role, permission: permission.join(",")];
    }

    /**
     * orgUser tree json
     * 显示当前角色所属机构及其下属机构
     * @return
     */
    def orgUserJson(){
        def list = []
        if(params?.id?.startsWith("org_") || params?.id?.equals("#")){
            def role = BaseRole.read(params.roleId?:-1l);
            def orgs = Organization?.findAll();
            def userList = BaseUserBaseRole.findAllByBaseRole(role)?.baseUser;
            def permissions = userList?.id;
            if(params?.id?.contains("#")){
                orgs.each { org1 ->
                    def map = [:];
                    map.id = "org_${org1.id}";
                    map.text = org1.name;
                    map.state = [:];
                    map.state.disabled = true;
                    map.children = true;
                    map.type = "org";
                    list << map;
                }
            }
            if(params?.id?.startsWith("org_")){
                def orgId = params?.id?.substring(params?.id?.indexOf("_")+1);
                def org = Organization.get(orgId?.toLong());
                def users = BaseUser.findAllByOrganization(org);
                users.each{user ->
                    def map2 = [:]
                    map2.id = "${user.id}"
                    map2.text = user.realName
                    map2.children = false
                    map2.state = [:]
                    if(permissions && permissions?.contains(user.id)){
                        map2.state.selected = true
                    }
                    map2.type = "user"
                    list << map2
                }
            }
            render list as JSON;
        }
    }

    /**
     * 分配用户给角色
     * @return
     */
    @Transactional
    def saveUserRole() {
        def map = [:];
        def role = BaseRole.get(params.roleId);
        def list = params?.permission?.toString()?.split(",");
        params.traceLogNeedSave = true;
        params.operating ="角色分配用户";
        def users = [];
        list.each {
            if(it){
                def user = BaseUser.read(it);
                if(!BaseUserBaseRole.exists(user.id,role.id)){
                    BaseUserBaseRole.create(user, role, true);
                    users << user;
                }
            }
        }
        def jsonMap = [:];
        jsonMap.baseRole = role;
        jsonMap.userRole = users;
        params.afterJson = "${jsonMap as JSON}";
        map.result = true;
        map.message = "分配成功";
        render "${map as JSON}"
    }

    /**
     * 新增角色页面
     */
    def create() {
    }

    /**
     * 编辑角色页面
     */
    def edit(){
        return [baseRole:BaseRole.read(params?.roleId)];
    }

    /**
     * 保存或更新角色信息
     * @return
     */
    @Transactional
    def saveOrUpdate() {
        def map = [:], baseRole;
        params.traceLogNeedSave = true;
        if(!springSecurityService.currentUser?.getAuthorities()?.authority?.contains("ROLE_SUPERADMIN")){
            params.organization = springSecurityService?.currentUser?.organization
        }
        if(params?.id){
            baseRole = BaseRole.read(params?.id);
            params.operating ="更新角色信息";
            params.beforeJson = "${baseRole as JSON}";
            baseRole.properties = params;
        }else{
            baseRole = new BaseRole(params);
            params.operating ="新增角色信息";
        }
        if(!baseRole.authority){
            baseRole.authority = "ROLE_${baseRole?.organization?.code?:'000000'}_${baseRole?.serviceCategory?.id?:'0'}_${PinyinUtils.getFullSpell(baseRole.name)}";
            baseRole.id = baseRole.authority;
        }
        params.afterJson = "${baseRole as JSON}";
        if(baseRole.save(flush: true)){
            map.result = true
            map.message = "保存成功"
        }else{
            println baseRole.errors.allErrors
            map.result = false
            map.message = "保存失败"
        }
        render map as JSON
    }

    /**
     * 删除角色
     * @return
     */
    @Transactional
    def delRole() {
        def map = [:]
        def role = BaseRole.read(params?.roleId)
        if(BaseUserBaseRole.countByBaseRole(role) > 0){
            map.result = false;
            map.message = "该角色下有分配用户，无法删除";
        }else if(role?.name?.equals("ROLE_SUPERADMIN") || role?.name?.equals("ROLE_ADMIN") ||role?.name?.equals("ROLE_INQUISITOR")) {
            map.result = false;
            map.message = "该角色为基础角色，无法删除";
        }else{
            params.traceLogNeedSave = true;
            params.operating ="删除角色信息";
            params.beforeJson = "${role as JSON}";
            role.delete(flush: true);
            map.result = true;
            map.message = "删除成功";
        }
        render map as JSON
    }

    /**
     * 查看角色页面
     * @return
     */
    def show() {
        return [baseRole:BaseRole.read(params?.roleId)];
    }

    /**
     * 菜单树页面
     * @return
     */
    def menuTree() {
        def role = BaseRole.read(params?.roleId)
        return [role: role]
    }

    /**
     * 菜单树JSON
     * @return
     */
    def menuJson() {
        def menus = Menu.findAllByMenuIsNull();
        def list = [];
        def role = BaseRole.read(params?.id);
        def permissions = role?.menuItems?.split(",");
        render getSubMenus(menus, list, permissions) as JSON
    }

    /**
     * 拼装菜单树JSON
     * @param menus
     * @param list
     * @param permissions
     * @return
     */
    def getSubMenus(def menus,def list,def permissions){
        menus.each {menu->
            def map = [:];
            map.id = menu.id;
            map.text = menu.name;
            map.children = []
            map.state = [opened:true];
            if(permissions && permissions?.contains("${menu.id}") && menu.children.isEmpty()){
                map.state.selected = true
            }else{
                map.state.selected = false
            }
            if(!menu.children.isEmpty()){
                def temList = [];
                map.children = getSubMenus(menu.children,temList,permissions);
                map.type = "root";
            }else{
                map.type = "root";
            }
            list << map;
        }
        return list;
    }

    /**
     * 保存权限配置
     * @return
     */
    @Transactional
    def saveConfigure() {
        def map = [:]
        def role = BaseRole.get(params.roleId);
        params.traceLogNeedSave = true;
        params.operating ="角色关联菜单";
        params.beforeJson = "${role as JSON}";
        role.menuItems = params.permission;
        params.afterJson = "${role as JSON}";
        if(role.save(flush: true)){
            map.result = true;
            map.message = "配置成功";
        }else{
            map.result = false;
            map.message = "配置失败";
        }
        render "${map as JSON}"
    }

    @Transactional
    def generateRoles() {
        Organization.findAllByCodeLike("%0000").each { org ->
            def role1 = new BaseRole(name: '值班组', authority: "ROLE_${org.code}_0_${PinyinUtils.getFullSpell('值班组')}", description: '值班组', organization: org, type: 1)
            role1.id = role1.authority;
            role1.save(flush: true);
            ServiceCategory.findAll("from ServiceCategory where isDel = false order by sortNum asc").each { category ->
                def role2 = new BaseRole(name: '专家组', authority: "ROLE_${org.code}_${category.id}_${PinyinUtils.getFullSpell('专家组')}", description: '专家组', serviceCategory: category, organization: org, type: 2)
                role2.id = role2.authority;
                role2.save(flush: true);
                def role3 = new BaseRole(name: '审核组', authority: "ROLE_${org.code}_${category.id}_${PinyinUtils.getFullSpell('审核组')}", description: '审核组', serviceCategory: category, organization: org, type: 3)
                role3.id = role3.authority;
                role3.save(flush: true);
            }
        }
    }

    def roleUserTree() {

    }

    def roleUserTreeJson() {
        def orgType = params.orgType;
        def organization = null;
        if(orgType=='1'){
            organization =  springSecurityService.currentUser.organization
        }else if(orgType=='2'){
            organization =  springSecurityService.currentUser.organization
            if(organization?.parent){
                organization =organization.parent;
            }
        }

        def list = []
        if(params?.id?.equals("#")){
            Organization.findAll("from Organization where code like '%${organization?.code?:0000}' order by sort asc").each { org ->
                def map = [:];
                map.id = "o_${org.id}";
                map.text = org.name;
                map.state = [:];
                map.state.disabled = false;
                map.children = true;
                map.type = "org";
                list << map;
            }
        }
        if(params?.id?.startsWith("o_")){
            def org = Organization.read(params?.id?.substring(params?.id?.indexOf('_')+1));
            //值班组
            if(params?.roleType?.equals("1")){
                BaseRole.findAllByIsDelAndOrganizationAndType(false, org, params?.roleType).each { role ->
                    def map = [:];
                    map.id = role.id;
                    map.text = role.name;
                    map.state = [:];
                    map.state.disabled = false;
                    map.children = true;
                    map.type = "role";
                    list << map;
                }
            }
            //专家组、审核组
            if(params?.roleType?.equals("2") || params?.roleType?.equals("3")){
                BaseRole.findAll("from BaseRole where isDel = false and organization = ? and type = ? order by serviceCategory.sortNum asc",[org, params?.roleType]).each{ role ->
                    def category = role.serviceCategory;
                    if(!(("c_${role.organization.id}_${category.id}") in list?.id)){
                        def map = [:];
                        map.id = "c_${role.organization.id}_${category.id}";
                        map.text = category.name;
                        map.state = [:];
                        map.state.disabled = false;
                        map.children = true;
                        map.type = "category";
                        list << map;
                    }
                }
            }
        }
        if(params?.id?.startsWith("c_")){
            def org = Organization.read(params?.id?.substring(params?.id?.indexOf('_')+1,params?.id?.lastIndexOf("_")));
            def category = ServiceCategory.read(params?.id?.substring(params?.id?.lastIndexOf('_')+1));
            BaseRole.findAllByIsDelAndServiceCategoryAndOrganizationAndType(false, category, org, params?.roleType).each { role ->
                def map = [:];
                map.id = role.id;
                map.text = role.name;
                map.state = [:];
                map.state.disabled = false;
                map.children = true;
                map.type = "role";
                list << map;
            }
        }
        if(params?.id?.startsWith("ROLE_")){
            def role = BaseRole.read(params?.id?.substring(params?.id?.indexOf('_')+1));
            BaseUserBaseRole.findAllByBaseRole(role).baseUser.each{ user ->
                def map = [:];
                map.id = "u_${user.id}";
                map.text = user.realName;
                map.state = [:];
                map.state.disabled = false;
                map.children = false;
                map.type = "user";
                list << map;
            }
        }
        render list as JSON
    }
}
