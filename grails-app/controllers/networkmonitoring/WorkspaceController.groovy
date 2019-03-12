package networkmonitoring

import grails.plugin.springsecurity.SpringSecurityUtils

class WorkspaceController {

    def index() {
        if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")){
            render(view: '/index')
        }else if(SpringSecurityUtils.ifAnyGranted("ROLE_USER")){
            redirect(controller: 'web',action: 'index4')
        }
    }
}
