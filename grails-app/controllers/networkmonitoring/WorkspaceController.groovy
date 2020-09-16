package networkmonitoring

import grails.plugin.springsecurity.SpringSecurityUtils

class WorkspaceController {
def mailService;
    def index() {
//        println grailsApplication.config.grails.mail.username;
       /* mailService.sendMail({
            to '286967506@qq.com';
            from grailsApplication.config.grails.mail.username//,grailsApplication.config.grails.mail.nickName
            subject "区域工业环境大数据在线监测系统"
            html "邮件测试"
        });*/
        if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")){
            render(view: '/index')
        }else if(SpringSecurityUtils.ifAnyGranted("ROLE_USER")){
            redirect(controller: 'web',action: 'index4')
        }
    }

}
