package networkmonitoring

import com.eyesfly.core.BaseUser
import com.eyesfly.dictionary.News
import com.eyesfly.dictionary.NewsContent
import grails.converters.JSON
import groovy.sql.Sql
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo

import java.sql.Timestamp


class WebController{
    def springSecurityService;
    def chat(){}
    @MessageMapping("/hello")
    @SendTo("/topic/hello")
    protected String hello(String world) {
        println world;
        return "hello, ${world}!"
    }

    def index(){
        def list = MonitoringPlace.list();
        def rows = [];
        list.eachWithIndex{ MonitoringPlace entry, int i ->
            def map = [:];
            map.name = entry.name;
            map.value = [];
            map.value << entry.lng;
            map.value << entry.lat;
            map.value << i+1;
            map.value << entry.id;
            rows << map;
        }
        def dataSource = grailsAttributes.getApplicationContext().getBean('dataSource');
        def sql = new Sql(dataSource);
        def cityCount = sql.rows("select count(DISTINCT area_id) num from  monitoring_place")[0];
        return [list:(rows as JSON).toString(),cityCount:cityCount.num]
    }

    def index2(){
        def obj = MonitoringPlace.get(params.id?:-1l);
        def list = [];
        if(obj){
            list = MeasuringPoint.findAllByMonitoringPlace(obj);
        }
        return [obj:obj,list:list]
    }
    def dayData(){
        def obj = MonitoringPlace.get(params.id?:-1l);
        def point = MeasuringPoint.findByMonitoringPlace(obj);
        def list = Passageway.findAllByMeasuringPoint(point);
        def data = []
        def dateStr = new Date().format("yyyy-MM-dd");
        list.each {
            def v = ChannelData.findAllByDevidAndChanCodeAndCreateDateBetween(point.devid,it.chanCode,Date.parse('yyyy-MM-dd HH:mm:ss',"${dateStr} 00:00:00"),Date.parse('yyyy-MM-dd HH:mm:ss',"${dateStr} 23:59:59"),[order: 'createDate']);
            def map = [:];
            map.x = v.collect{it.createDate.format("HH:mm")}
            map.y = v.collect {it.value}
            data << map;
        }
        render data as JSON
    }
    def index3(){

    }
    def index5(){
        def list = [];
        def obj = MeasuringPoint.get(params.id?:-1l);
        if(obj){
            list = Passageway.findAllByMeasuringPoint(obj);
        }
        return [list:list]
    }
    def demo(){

    }
    def index4(){
        def list = News.findAllByStatus("发布",[sort:'publishDate',order:'desc']);
        return [list:list]
    }
    def showProject(){
        def news = News.get(params.id?.toLong()?:-1l);
        def newsContentList = [];
        if(news){
            newsContentList = NewsContent.findAllByNews(news);
        }

        return [news:news,newsContentList:newsContentList]
    }

    def passwordChange(){
        def map = [:]
        def currentUser = BaseUser.get(springSecurityService.currentUser?.id)
        if (springSecurityService.passwordEncoder.isPasswordValid(currentUser.password, params?.oldPass, null)) {
            if (params.newPass == params.confirmPass) {
                currentUser.password = params.newPass
                currentUser.save(flush: true)
                map.message = "修改成功"
                map.result = true
            } else {
                map.message = "确认密码与新密码不一致"
                map.result = false
            }
        } else {
            map.message = "旧密码不正确"
            map.result = false
        }
        render "${map as JSON}";
    }

    def realTimeDataJson(){
        def dateStr = params.date;
        def obj = null;
        def list=[];
        def map = [:];
        if(!dateStr){
//            dateStr = "2019-04-01 20:27:42.000183731"
//            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid);
            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid,[sort: 'id',order: 'desc']);
            map.time = obj?.samplingTime?.toString();
            map.data = JSON.parse(obj?.data)
        }else{
            list = SamplingData.findAllBySamplingTimeGreaterThanAndChanCodeAndDevid(Timestamp.valueOf(dateStr.replace(".000",".")),params.chanCode,params.devid,[sort: 'id',order: 'asc']);
            def tem=[];
            list.each {
                tem += JSON.parse(it?.data);
            }
            if(!list.isEmpty()){
                map.time = list?.last()?.samplingTime.toString();
                map.data =tem;
            }
        }
       render map as JSON;
    }

    def spectrumDataJson(){
        def dateStr = params.date;
        def obj = null;
/*        if(!dateStr){
//            obj = ChannelSpectrumData.findByChanCodeAndDevid(params.chanCode,params.devid);
            obj = ChannelSpectrumData.findByAnalysisTimeGreaterThanAndChanCodeAndDevid(new Date(),params.chanCode,params.devid);
        }else{
            obj = ChannelSpectrumData.findByAnalysisTimeGreaterThanAndChanCodeAndDevid(Date.parse("yyyy-MM-dd HH:mm:ss",dateStr),params.chanCode,params.devid);
        }*/
        obj = ChannelSpectrumData.findByChanCodeAndDevid(params.chanCode,params.devid);
        def map = [:];
        if(obj){
            map.time = obj?.analysisTime.format("yyyy-MM-dd HH:mm:ss");
            map.data = JSON.parse(obj?.data)
        }
        render map as JSON;
    }
}
