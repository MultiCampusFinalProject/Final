package com.spring.config;





import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.spring.interceptor.ChooseInterceptor;
import com.spring.interceptor.SearchInterceptor;
//import com.spring.service.ChooseService;
import com.spring.service.SearchService;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	@Autowired
    private final SearchInterceptor searchInterceptor;
	
	@Autowired
    private final ChooseInterceptor chooseInterceptor;

    @Autowired
    public WebConfig(SearchInterceptor searchInterceptor,ChooseInterceptor chooseInterceptor) {
        this.searchInterceptor = searchInterceptor;
        this.chooseInterceptor = chooseInterceptor;
    }

  

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(searchInterceptor)
                .addPathPatterns("/courseList")
                .addPathPatterns("/courseListWithPagination");
        registry.addInterceptor(chooseInterceptor)
        .addPathPatterns("/courseList/Map");
    }
}