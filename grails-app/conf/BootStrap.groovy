import com.eyesfly.dictionary.Organization
import grails.converters.JSON
import com.eyesfly.core.*
import com.eyesfly.marshaller.BootStrapTableDomainClassMarshaller
import networkmonitoring.MonitoringPlace

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
        createOrganization();
        createMonitoringPlace();

    }
    private void createMonitoringPlace(){
        /*
        *
        * {name: '海门', value: [121.15, 31.89, 1]},
                {name: '北京', value: [116.3, 39.9, 1]},
                {name: '鄂尔多斯', value: [109.781327, 39.608266, 2]},
                {name: '招远', value: [120.38, 37.35, 3]},
                {name: '新乡', value: [113.54, 35.18, 3]},
                {name: '舟山', value: [122.207216, 29.985295, 2]}
        *
        * */
        new MonitoringPlace(name: "海门",east: '121.15',north: '31.89').save(flush: true);
        new MonitoringPlace(name: "北京",east: '116.3',north: '39.9').save(flush: true);
        new MonitoringPlace(name: "鄂尔多斯",east: '109.781327',north: '39.608266').save(flush: true);
        new MonitoringPlace(name: "招远",east: '120.38',north: '37.35').save(flush: true);
        new MonitoringPlace(name: "新乡",east: '113.54',north: '35.18').save(flush: true);
        new MonitoringPlace(name: "舟山",east: '122.207216',north: '29.985295').save(flush: true);
    }
    private void createOrganization(){
        def org1 =new Organization(name: "测试单位1").save(flush: true);
        println org1.errors;
        def org2 =new Organization(name: "测试单位2").save(flush: true);
        println org2.errors;
        def org3 =new Organization(name: "测试单位3").save(flush: true);
        println org3.errors;
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
            new Requestmap(url: '/web/**', configAttribute: 'permitAll()').save(flush: true)

            new Requestmap(url: '/**', configAttribute: 'isFullyAuthenticated()').save(flush: true)
        }
    }
    def destroy = {
    }
}
