package com.spring.controller;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URISyntaxException;
public class Directions15API {



	    public static void main(String[] args) {
	        String clientId = "{애플리케이션 등록 시 발급받은 client id 값}";
	        String clientSecret = "{애플리케이션 등록 시 발급받은 client secret 값}";
	        String apiUrl = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving";
	        String start = "127.1058342,37.359708";
	        String goal = "129.075986,35.179470";
	        String option = "trafast";

	        RestTemplate restTemplate = new RestTemplate();

	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);
	        headers.add("X-NCP-APIGW-API-KEY-ID", "eeovn23rmv");
	        headers.add("X-NCP-APIGW-API-KEY", "u1LzIow7CE8uktkBnVz6oPo4utFP9fYgNMeP64zZ");

	        URI uri;
	        try {
	            uri = new URI(apiUrl + "?start=" + start + "&goal=" + goal + "&option=" + option);
	        } catch (URISyntaxException e) {
	            e.printStackTrace();
	            return;
	        }

	        RequestEntity<?> requestEntity = new RequestEntity<>(headers, HttpMethod.GET, uri);

	        ResponseEntity<String> responseEntity = restTemplate.exchange(requestEntity, String.class);
	        String responseBody = responseEntity.getBody();

	        System.out.println(responseBody);
	    }

}
