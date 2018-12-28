package networkmonitoring

import grails.converters.JSON

class MonitoringPlaceController {

    def index() {}
    def json(){
        def list = MonitoringPlace.list();
        render list as JSON;
    }
    def saveOrUpdate(){
        def obj = new MonitoringPlace(params);
        obj.save(flush: true);
        def map = [:]
        map.res = true;
        map.message = '请填写敏感词';
        render map as JSON;
    }
    def create(){}
    def edit(){
        def obj = MonitoringPlace.get(params.id?.toLong()?:-1l)
        return [obj:obj]
    }
}
