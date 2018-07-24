package com.eyesfly.core


import com.eyesfly.dictionary.Organization

import grails.converters.JSON
import grails.transaction.Transactional


import java.util.regex.Pattern

@Transactional(readOnly = true)
class BaseUserController{

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService;
    def hdImageService;

    /**
     * 用户管理列表页
     */
    def list() {

    }

    /**
     * 用户管理脚本
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

        def ecCount = BaseUser.createCriteria().count {

            if(params?.keywords){
                or{
                    ilike("username","%${params.keywords?.trim()}%")
                    ilike("realName","%${params.keywords?.trim()}%")
                }
            }
        }
        def ecList = [];
        BaseUser.createCriteria().list {

            if(params?.keywords){
                or{
                    ilike("username","%${params.keywords?.trim()}%")
                    ilike("realName","%${params.keywords?.trim()}%")
                }
            }
            order(params.sort, params.order)
            maxResults(params.max.toInteger())
            firstResult(params.offset.toInteger())
        }.each {
            def user = [:];
            user.id = it?.id;
            user.username = it?.username;
            user.realName = it?.realName;
            user.mobile = it?.mobile;
            user.organization = it?.organization?.name;
            user.dateCreated = it?.dateCreated?.format("yyyy-MM-dd");
            user.enabled = it?.enabled;
            ecList << user;
        }
        def map = [:];
        map.total = ecCount;
        map.rows = ecList;
        render map as JSON;
    }

    /**
     * 启用/停用用户
     */
    @Transactional
    def enabledUser() {
        def map = [:];
        def user = BaseUser.read(params?.userId);
        user.enabled = params?.enabled?.equals("1")?true:false;
        if(user.save(flush: true)){
            map.result = true;
            map.message = "操作成功";
        }else{
            map.result = false;
            map.message = "操作失败";
        }
        render map as JSON;
    }

    /**
     * 新增用户页面
     */
    def create() {
    }

    /**
     * 编辑用户页面
     */
    def edit(){
        return [baseUser:BaseUser.read(params?.userId)];
    }

    /**
     * 校验用户名是否重复
     */
    def checkUnique(){
        def baseUser = BaseUser.findByIdCard(params?.idCard)
        render baseUser?(baseUser.id.toString().equals(params?.id)?true:false):true
    }

    /**
     * 保存或更新用户信息
     * @return
     */
    @Transactional
    def saveOrUpdate() {
        params.traceLogNeedSave = true;
        def map = [:], baseUser;
       /* params.username = params?.idCard;*/
        params.password = "123456";
        if(params?.id){
            params.operating ="更新用户信息";
            baseUser = BaseUser.read(params?.id);
            params.beforeJson = "${baseUser as JSON}";
            params.password = springSecurityService.encodePassword(params?.password)
            baseUser.properties = params;
        }else{
            params.operating ="新增用户信息";
            baseUser = new BaseUser(params);
        }
        params.afterJson = "${baseUser as JSON}";
        if(baseUser.save(flush: true)){
            map.result = true
            map.message = "保存成功"
        }else{
            println baseUser.errors.allErrors
            map.result = false
            map.message = "保存失败"
        }
        render map as JSON
    }

    /**
     * 删除用户
     * @return
     */
    @Transactional
    def delUser() {
        def map = [:]
        def user = BaseUser.read(params?.userId)
        if(Question.countByBaseUser(user) > 0 || Answer.countByBaseUser(user) > 0){
            map.result = false
            map.message = "用户${user.realName}下有咨询或解答问题，不能删除"
        }else{
            params.traceLogNeedSave = true;
            params.operating ="删除用户信息";
            params.beforeJson = "${user as JSON}";
            BaseUserBaseRole.removeAll(user,true)
            user.delete(flush: true)
            map.result = true
            map.message = "删除成功"
        }
        render map as JSON
    }

    @Transactional
    def delAll() {
        def map = [:];
        def idList = params.ids?.tokenize(",")?.collect{it.toLong()}
        def userList = BaseUser.findAllByIdInList(idList);
        def msgList = [];
        userList.each { user ->
            if(Question.countByBaseUser(user) > 0 || Answer.countByBaseUser(user) > 0){
                msgList << user.realName;
            }
        }
        if(msgList.size() > 0){
            map.result = false;
            map.message = "您勾选的用户${msgList.join(',')}下有咨询或解答问题，不能删除"
        }else{
            BaseUser.where{
                id in idList
            }.deleteAll();
            map.result = true;
            map.message = "删除成功"
        }
        render map as JSON
    }

    /**
     * 查看用户页面
     * @return
     */
    def show() {
        return [baseUser:BaseUser.read(params?.userId)];
    }

    /**
     * 下载导入模板
     * @return
     */
    def downTemplate(){
        String filename = "";
        if(params?.id?.equals("1")){
            filename=request.servletContext.getRealPath("/WEB-INF/templates/inquisitorTemplate.xlsx");
        }
        if(params?.id?.equals("2")){
            filename=request.servletContext.getRealPath("/WEB-INF/templates/expertTemplate.xlsx");
        }
        File file = new File(filename);
        response.addHeader("Content-Disposition","attachment; filename=" + new String("用户数据模板.xlsx".getBytes("GBK"),"ISO8859-1"));
        FileInputStream fileInputStream = new FileInputStream(file);
        OutputStream outputStream = response.getOutputStream();
        try{
            byte[] by  = new byte[fileInputStream.available()];
            fileInputStream.read(by);
            outputStream.write(by);
        } finally{
            fileInputStream.close();
            outputStream.close();
            return null;
        }
    }

    /**
     * 获取用户头像
     * @return
     */
    def userAviator() {
        def currentUser = springSecurityService.currentUser;
        if (params.username) {
            currentUser = BaseUser.findByUsername(params.username)
        }
        def bytes = [];
        if (currentUser?.aviator && currentUser?.aviator?.size() > 0) {
            bytes = currentUser.aviator;
        } else {
            def file = new File(request.servletContext.getRealPath("/images/grzx/nouser.jpg"));
            bytes = file.bytes;
        }
        try {
            response.setContentType("image/jpeg");
            response.setContentLength(bytes.size())
            response.setHeader('filename', "aviator.jpg")
            OutputStream out = response.outputStream
            out.write(bytes)
            out.close()
            return;
        } catch (Exception e) {
            return
        }
    }

    /**
     * 修改头像
     * @return
     */
    @Transactional
    def changeAviator() {
        def map = [:];
        def avaitor = request.getFile('avaitor')
        if(!avaitor.getOriginalFilename()){
            map.result=false;
            map.message = "请选择图片文件";
            render map as JSON;
        } else if(!avaitor.getOriginalFilename().endsWith(".jpg") && !avaitor.getOriginalFilename().endsWith(".jpeg") && !avaitor.getOriginalFilename().endsWith(".png")){
            map.result=false;
            map.message = "图片只支持JPG、JPEG、PNG文件";
            render  map as JSON;
        } else {
            def baseUser = BaseUser.get(springSecurityService.currentUser?.id);
            baseUser.aviator = hdImageService.scale(avaitor.getInputStream(), 100, 100);
            baseUser.aviatorName = avaitor.getOriginalFilename();
            baseUser.save(flush: true);
            map.result = true;
            map.message = "修改成功";
        }
        render map as JSON
    }

    /**
     * 用户信息页面
     */
    def info() {
        return [user: springSecurityService.currentUser]
    }

    /**
     * 用户信息修改页面
     * @return
     */
    def infoEdit() {
        return [user: springSecurityService.currentUser]
    }

    /**
     * 修改用户信息
     * @return
     */
    @Transactional
    def updateInfo() {
        params.traceLogNeedSave = true;
        def map = [:];
        params.operating ="更新用户信息";
        def baseUser = BaseUser.read(params?.id);
        params.beforeJson = "${baseUser as JSON}";
        baseUser.properties = params;
        params.afterJson = "${baseUser as JSON}";
        if(baseUser.save(flush: true)){
            map.result = true
            map.message = "修改成功"
        }else{
            println baseUser.errors.allErrors
            map.result = false
            map.message = "修改失败"
        }
        render map as JSON
    }

}
