import grails.converters.JSON
import com.eyesfly.core.*
import com.eyesfly.marshaller.BootStrapTableDomainClassMarshaller

class BootStrap {

    def grailsApplication;
    def init = { servletContext ->
        JSON.registerObjectMarshaller(Date) {
            return it?.format("yyyy-MM-dd HH:mm:ss");
        }
        //解决
        JSON.registerObjectMarshaller(new BootStrapTableDomainClassMarshaller(true,grailsApplication));

        createDefaultRoles();
        createDefaultUsers();
        createRequestMap();

    }
    private void createDefaultRoles() {
        if (!BaseRole.findByAuthority('ROLE_ADMIN')){
            def role=new BaseRole(name:'管理员',authority:'ROLE_ADMIN',description:"管理员")
            role.save(flush: true)
            println role.errors;
        }
        if (!BaseRole.findByAuthority('ROLE_USER')){
            def role=new BaseRole(name:'用户',authority:'ROLE_USER',description:"用户")
            role.save(flush: true)
            println role.errors;
        }
    }
    private void createDefaultUsers() {
        def admin = BaseUser.findByUsername('admin')
        if (!admin) {
            admin = new BaseUser(username:'admin',password : '123456',email: 'spf@rxhtcn.com', enabled:true)
            admin.save(flush: true)
            println admin.errors;
            BaseUserBaseRole.create(admin,BaseRole.findByAuthority('ROLE_ADMIN'),true);
        }
        def user = BaseUser.findByUsername('user')
        if (!user) {
            user = new BaseUser(username:'user',password : '123456',email: 'spf@rxhtcn.com',enabled:true)
            user.save(flush: true)
            println user.errors;
            BaseUserBaseRole.create(user,BaseRole.findByAuthority('ROLE_USER'),true);
        }
    }
    private void createRequestMap() {
        if (Requestmap.count() == 0) {
            new Requestmap(url: '/static/**', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/js/**', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/images/**', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/plugins/**', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/css/**', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/login/**', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/logout/**', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/favicon.ico', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/images/favicon.ico', configAttribute: 'permitAll').save(flush: true)
            new Requestmap(url: '/j_spring_security_check', configAttribute: 'permitAll').save(flush: true)

            //spring security plugin
            new Requestmap(url: '/abstractS2Ui/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)
            new Requestmap(url: '/aclClass/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)
            new Requestmap(url: '/aclEntry/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)
            new Requestmap(url: '/aclObjectIdentity/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)
            new Requestmap(url: '/aclSid/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)
            new Requestmap(url: '/persistentLogin/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)


            //controller
            new Requestmap(url: '/baseUser/**', configAttribute: "ROLE_ADMIN").save(flush: true)
            new Requestmap(url: '/baseRole/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
            new Requestmap(url: '/requestmap/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
            new Requestmap(url: '/workspace/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)

            new Requestmap(url: '/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)
        }
    }
    def destroy = {
    }
}
