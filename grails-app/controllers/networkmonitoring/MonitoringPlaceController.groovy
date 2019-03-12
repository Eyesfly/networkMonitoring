package networkmonitoring

import grails.converters.JSON

class MonitoringPlaceController {

    def index() {}
    def json(){
        def list = MonitoringPlace.list();
        render list as JSON;
    }
    def saveOrUpdate(){

        def obj = null;
        if(params.id){
            obj =  MonitoringPlace.get(params.id?:-1);
        }else{
            obj = new MonitoringPlace();;
        }
        obj.properties = params;
        obj.save(flush: true);
        println obj.errors;
        def map = [:]
        map.res = true;
        map.message = '保存成功';
        render map as JSON;
    }
    def create(){}
    def edit(){
        def obj = MonitoringPlace.get(params.id?.toLong()?:-1l)
        return [obj:obj]
    }
    def delete(){
        def obj = MonitoringPlace.get(params.id?.toLong()?:-1l);
        if(obj){
            obj.delete(flush: true);
        }
        def map = [:]
        map.res = true;
        map.message = '删除成功';
        render map as JSON;
    }
    def picture() {
        def obj = MonitoringPlace.get(params.id?.toLong()?:-1l)
        def bytes = [];
        if (obj?.picture && obj?.picture?.size() > 0) {
            bytes = obj.picture;
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
}
