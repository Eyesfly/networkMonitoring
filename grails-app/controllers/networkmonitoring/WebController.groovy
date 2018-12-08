package networkmonitoring

import com.eyesfly.dictionary.News
import grails.converters.JSON
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo


class WebController{
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
            rows << map;
        }
        return [list:(rows as JSON).toString()]
    }

    def index2(){

    }
    def index3(){

    }
    def demo(){

    }
    def index4(){
        def list = News.list();
        return [list:list]
    }
    def showProject(){
        def news = News.get(params.id?.toLong()?:-1l);
        return [news:news]
    }
}
