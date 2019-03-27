package networkmonitoring

import grails.converters.JSON

class MeasuringPointController {

    def index() {

    }

    def json(){
        def list = MeasuringPoint.findAllByMonitoringPlace(MonitoringPlace.get(params.id?.toLong()?:-1l));
        render list as JSON;
    }
    def create(){
        def place =  MonitoringPlace.get(params.id?.toLong()?:-1l);
        println place;
        return [place:place]
    }
    def edit(){
        def obj = MeasuringPoint.get(params.id?.toLong()?:-1l)
        return [obj:obj]
    }

    def saveOrUpdate(){
        def obj = null;
        if(params.id){
            obj =  MeasuringPoint.get(params.id?:-1);
        }else{
            obj = new MeasuringPoint();;
        }
        obj.properties = params;
        obj.save(flush: true);
        def map = [:]
        map.res = true;
        map.message = '保存成功';
        render map as JSON;
    }
}
