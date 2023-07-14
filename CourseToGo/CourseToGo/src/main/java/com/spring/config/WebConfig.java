package com.spring.config;





import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.spring.interceptor.SearchInterceptor;
import com.spring.service.SearchService;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final SearchService searchService;

    @Autowired
    public WebConfig(SearchService searchService) {
        this.searchService = searchService;
    }

    @Bean
    public SearchInterceptor searchInterceptor() {
        return new SearchInterceptor(searchService);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(searchInterceptor())
                .addPathPatterns("/courseList")
                .addPathPatterns("/courseListWithPagination");
    }
}