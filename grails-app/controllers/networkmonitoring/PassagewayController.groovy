package networkmonitoring

import grails.converters.JSON

class PassagewayController {

    def index() { }
    def json(){
        def list = Passageway.findAllByMeasuringPoint(MeasuringPoint.get(params.id?.toLong()?:-1l));
        render list as JSON;
    }
    def create(){
        def point = MeasuringPoint.get(params.id?.toLong()?:-1l);
        return [point:point]
    }
    def edit(){
        def obj = Passageway.get(params.id?.toLong()?:-1l)
        return [obj:obj]
    }
    def saveOrUpdate(){
        def obj = null;
        if(params.id){
            obj =  Passageway.get(params.id?:-1);
        }else{
            obj = new Passageway();
        }
        obj.properties = params;
        obj.save(flush: true);
        def map = [:]
        map.res = true;
        map.message = '保存成功';
        render map as JSON;
    }
}
