package networkmonitoring

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
            map.value << entry.east;
            map.value << entry.north;
            map.value << i+1;
            rows << map;
        }
        return [list:(rows as JSON).toString()]
    }

}
