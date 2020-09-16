package networkmonitoring

import com.eyesfly.core.BaseUser
import com.eyesfly.dictionary.News
import com.eyesfly.dictionary.NewsContent
import grails.converters.JSON
import grails.transaction.Transactional
import groovy.sql.Sql
import org.apache.log4j.Logger
import org.hibernate.Transaction
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo

import java.sql.Timestamp
import java.time.LocalDate
import java.time.Month


class WebController{
    Logger logger = Logger.getLogger(WebController.class)
    def springSecurityService;
    def index3(){
        def list = [];
        def obj = MonitoringPlace.get(params.id?:-1l);
        if(obj){
            list = MeasuringPoint.findAllByMonitoringPlace(obj);
        }
        return [list:list]
    }
    def index6(){
        def list = [];
        def obj = MonitoringPlace.get(params.id?:-1l);
        if(obj){
            list = MeasuringPoint.findAllByMonitoringPlace(obj);
        }
        return [list:list]
    }
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
    def monthData(){
        def obj = MonitoringPlace.get(params.id?:-1l);
        def point = MeasuringPoint.findByMonitoringPlace(obj);
        def list = Passageway.findAllByMeasuringPoint(point);
        def data = []
        def dataSource = grailsAttributes.getApplicationContext().getBean('dataSource');
        def sql = new Sql(dataSource);
        def rowData = sql.rows("select chan_code, date_format(create_date,'%e日') time ,count(1)  value from analysis_warning_data where devid='${point?.devid}' and  create_date >= '${new Date().format("yyyy-MM")}-01 00:00:00' group by date_format(create_date,'%e'), chan_code ORDER BY create_date , chan_code;".toString())

        Calendar cal = Calendar.getInstance();
        int m = cal.get(Calendar.MONTH )+1;
        def now =  LocalDate.now()
                .withMonth(m)
                .lengthOfMonth();
        list.each { o->
            def li = rowData.findAll{it.chan_code == o.chanCode};
            def month = []
            def value = []
            for (int i = 1; i <= now.toInteger(); i++) {
                month << i;
                value << (li.find {it.time=="${i}日"}?.value?:0);
            }
//            data << [month:li.collect {it.time},value:li.collect {it.value}];
            data << [month:month,value:value];
        }
        render data as JSON
    }

    def monthWarningData(){
        def obj = MonitoringPlace.get(params.id?:-1l);
        def point = MeasuringPoint.findByMonitoringPlace(obj);
        def list = Passageway.findAllByMeasuringPoint(point);
        def data = []
        def dataSource = grailsAttributes.getApplicationContext().getBean('dataSource');
        def sql = new Sql(dataSource);
//        def rowData = sql.rows("select chan_code, date_format(create_date,'%c月') time ,CAST(AVG(`value`) AS DECIMAL(10,4)) value from analysis_warning_data where devid='${point.devid}' and  create_date >= '${new Date().format("yyyy")}-01-01 00:00:00' group by date_format(create_date,'%Y-%m') , chan_code;".toString())
        def rowData = sql.rows("select chan_code, date_format(create_date,'%c月') time ,count(1) value from analysis_warning_data where devid='${point?.devid}' and  create_date >= '${new Date().format("yyyy")}-01-01 00:00:00' group by date_format(create_date,'%Y-%m') , chan_code;".toString())

        list.each { o->
            def li = rowData.findAll{it.chan_code == o.chanCode};
//            data << [month:li.collect {it.time},value:li.collect {it.value}];
            def month = []
            def value = []
            for (int i = 1; i <= 12; i++) {
                month << i;
                value << (li.find {it.time=="${i}月"}?.value?:0);
            }
//            data << [month:li.collect {it.time},value:li.collect {it.value}];
            data << [month:month,value:value];
        }
        render data as JSON
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
        long time = System.currentTimeMillis();

        if(!dateStr){
//            dateStr = "2019-04-01 20:27:42.000183731"
//            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid);
            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid,[sort: 'id',order: 'desc']);
            map.time = obj?.samplingTime?.toString();
            map.data = JSON.parse(obj?.data?:"{}")
        }else{
            list = SamplingData.findAllBySamplingTimeGreaterThanAndChanCodeAndDevid(Timestamp.valueOf(dateStr.replace(".000",".")),params.chanCode,params.devid,[sort: 'id',order: 'asc']);
            def tem=[];
            for (int i = 0; i < list.size(); i++) {
                def it = list[i];
                tem += JSON.parse(it?.data);
            }
            /*list.each {
                tem += JSON.parse(it?.data);
            }*/
            if(!list.isEmpty()){
                map.time = list?.last()?.samplingTime.toString();
                map.data =tem;
            }
        }
        logger.error("查询消耗：${System.currentTimeMillis()-time}");
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
    @MessageMapping("/data1")
    @SendTo("/topic/data1")
    @Transactional(readOnly = true)
    protected String  data1(String content){
        def params =  JSON.parse(content)
        def dateStr = params.date;
        def obj = null;
        def list=[];
        def map = [:];
        map.key = "${params.devid}_${params.chanCode}"
        long time = System.currentTimeMillis();
        if(!dateStr){
//            dateStr = "2019-04-01 20:27:42.000183731"
//            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid);
//            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid,[sort: 'id',order: 'desc']);
            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid,[sort: 'id',order: 'desc']);
            map.time = obj?.samplingTime?.toString();
            map.beginTime = obj?.samplingTime?.toString()?.replace(".000",".");
            map.data = JSON.parse(obj?.data?:"{}")
        }else{
            list = SamplingData.findAllBySamplingTimeGreaterThanAndChanCodeAndDevid(Timestamp.valueOf(dateStr.replace(".000",".")),params.chanCode,params.devid,[sort: 'id',order: 'asc']);
            def tem=[];
            for (int i = 0; i < list.size(); i++) {
                def it = list[i];
                tem += JSON.parse(it?.data);
            }
            if(!list.isEmpty()){
                map.time = list?.last()?.samplingTime.toString();
                map.beginTime = list?.first()?.samplingTime.toString()?.replace(".000",".");
                map.data =tem;
            }
        }
//        render map as JSON;
        return "${map as JSON}"
    }
    @MessageMapping("/data2")
    @SendTo("/topic/data2")
    @Transactional(readOnly = true)
    protected String  data2(String content){
        def params = JSON.parse(content)
        def dateStr = params.date;
        def obj = null;

        obj = ChannelSpectrumData.findByChanCodeAndDevid(params.chanCode,params.devid);
        def map = [:];
        map.key = "${params.devid}_${params.chanCode}"
        if(obj){
            map.time = obj?.analysisTime.format("yyyy-MM-dd HH:mm:ss");
            map.data = JSON.parse(obj?.data)
        }
//        render map as JSON;
        return  "${map as JSON}"
    }

    @MessageMapping("/data11")
    @SendTo("/topic/data11")
    @Transactional(readOnly = true)
    protected String  data11(String content){
        def params =  JSON.parse(content)
        def  devid = params.devid.split(",");
        def  chanCode = params.chanCode.split(",");
        def dateStr = params.date;
        def obj = null;
        def list=[];
        def list2=[];
        def map = [:];
//        map.key = "${params.devid}_${params.chanCode}"
        long time = System.currentTimeMillis();
        if(!dateStr){
//            dateStr = "2019-04-01 20:27:42.000183731"
//            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid);
//            obj = SamplingData.findByChanCodeAndDevid(params.chanCode,params.devid,[sort: 'id',order: 'desc']);
            def firstList = SamplingData.executeQuery("from SamplingData where (chanCode = :chanCode1 and devid = :devid1) or (chanCode = :chanCode2 and devid = :devid2) order by id desc ",[chanCode1:chanCode[0],chanCode2:chanCode[1],devid1:devid[0],devid2:devid[1],max:2])
//            obj = SamplingData.findByChanCodeAndDevid('0',params.devid,[sort: 'id',order: 'desc']);
//            def obj2 = SamplingData.findByChanCodeAndDevid('1',params.devid,[sort: 'id',order: 'asc']);
            map.time = firstList?.last()?.samplingTime.toString();;
            map.beginTime = firstList?.first()?.samplingTime.toString()?.replace(".000",".");
            firstList = firstList.groupBy {it.devid+"_"+it.chanCode};
            def temList = [:];
            firstList.each { o->
               def tem = []
                for (int i = 0; i < o.value.size(); i++) {
                    def it = o.value[i];
                    tem += JSON.parse(it?.data);
                }
                temList[o.key]=tem;
//                temList<<tem;
            }
            map.data = temList
        }else{
            list = SamplingData.executeQuery("from SamplingData where samplingTime >= :samplingTime and ((chanCode = :chanCode1 and devid = :devid1) or (chanCode = :chanCode2 and devid = :devid2))  order by id asc",[samplingTime:Timestamp.valueOf(dateStr.replace(".000",".")),chanCode1:chanCode[0],chanCode2:chanCode[1],devid1:devid[0],devid2:devid[1]]);
/*            list = SamplingData.findAllBySamplingTimeGreaterThanAndChanCodeAndDevid(Timestamp.valueOf(dateStr.replace(".000",".")),0,params.devid,[sort: 'id',order: 'asc']);
            list2 = SamplingData.findAllBySamplingTimeGreaterThanAndChanCodeAndDevid(Timestamp.valueOf(dateStr.replace(".000",".")),1,params.devid,[sort: 'id',order: 'asc']);*/
            if(!list.isEmpty()){
                map.time = list?.last()?.samplingTime.toString();;
                map.beginTime = list?.first()?.samplingTime.toString()?.replace(".000",".");
            }
            list = list.groupBy {it.devid+"_"+it.chanCode};
            def temList = [:];
            list.each { o->
                def tem = []
                for (int i = 0; i < o.value.size(); i++) {
                    def it = o.value[i];
                    tem += JSON.parse(it?.data);
                }
//                temList<<tem;
                temList[o.key] = temList;
            }
            map.data = temList
        }
        return "${map as JSON}"
    }
}
