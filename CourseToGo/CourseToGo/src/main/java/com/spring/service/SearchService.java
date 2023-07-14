package com.spring.service;

import java.util.ArrayList;
import java.util.List;


import com.spring.dto.SearchDataDTO;
import com.spring.mapper.AreaMapper;
import com.spring.mapper.SearchMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

@Service
public class SearchService {

    private final MongoTemplate mongoTemplate;

    @Autowired
    public SearchService(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }

    public void saveSearchKeyword(int i, String keyword) {
        SearchDataDTO searchData = new SearchDataDTO(i, keyword);
        mongoTemplate.save(searchData, "searchData");
    }
}
