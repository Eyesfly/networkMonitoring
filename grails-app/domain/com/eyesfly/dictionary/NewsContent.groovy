package com.eyesfly.dictionary

class NewsContent {
    News news;
    String name;
    String content;
    int sort =0;
    static constraints = {
        content(nullable: true,size: 0..2000)
    }
    static mapping = {
        content type: 'text';
    }
}
