package networkmonitoring

import com.eyesfly.core.BaseUser
import com.eyesfly.dictionary.News
import com.eyesfly.dictionary.NewsContent
import grails.converters.JSON
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
        return [list:(rows as JSON).toString()]
    }

    def index2(){

    }
    def index3(){

    }
    def index5(){

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
        println params;
        if(!dateStr){
            dateStr = "2019-04-01 20:27:42.000183731"
        }
        println Timestamp.valueOf(dateStr.replace(".000","."))
        def obj = SamplingData.findBySamplingTimeGreaterThan(Timestamp.valueOf(dateStr.replace(".000",".")));
        def map = [:];
        map.time = obj.samplingTime.toString();
        map.data = JSON.parse(obj.data)
        println map as JSON;
       render map as JSON;
    }
}
