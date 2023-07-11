package com.spring.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.dto.Direction;
import com.spring.dto.DirectionPoint;
import com.spring.service.DirectionService;

@Controller
public class DirectionController {
	@Autowired
	private DirectionService directionService;
	@Autowired
	private MongoTemplate mongoTemplate;
    @GetMapping("/direction")
    public void getDrivingDirection(Model model)  {
    	
        String apiUrl = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving";
        String clientId = "{애플리케이션 등록 시 발급받은 client id 값}";
        String clientSecret = "{애플리케이션 등록 시 발급받은 client secret 값}";
        String start = "126.9210951,37.5519427";
         String goal = "126.9167811,37.5489469";
         String option = "126.9207811,37.5489469";
	      
     

        HttpHeaders headers = new HttpHeaders();
        headers.set("X-NCP-APIGW-API-KEY-ID",  "eeovn23rmv");
        headers.set("X-NCP-APIGW-API-KEY", "u1LzIow7CE8uktkBnVz6oPo4utFP9fYgNMeP64zZ");
        
        MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<>();
        requestBody.add("start", start);
        requestBody.add("goal", goal);
        requestBody.add("option", option);
        RestTemplate restTemplate = new RestTemplate();
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
//        directionService.insertDirections(responseBody);
//        System.out.println(responseBody);
     
//        try {
//            ObjectMapper objectMapper1 = new ObjectMapper();
//            JsonNode rootNode = objectMapper1.readTree(responseBody);
//
//            JsonNode pathNode = rootNode.path("route").path("traoptimal").get(0).path("path");
//            List<DirectionPoint> directionPointList = new ArrayList<>();	
//            Direction direction = new Direction();
//            if (pathNode.isArray()) {
//                for (JsonNode coordinateNode : pathNode) {
//                    double longitude = coordinateNode.get(0).asDouble();
//                    double latitude = coordinateNode.get(1).asDouble();
//                    
//                    System.out.println("Longitude: " + longitude + ", Latitude: " + latitude);
//                    directionPointList.add(new DirectionPoint( latitude,longitude));
//                }
//                direction.setDirectionPointList(directionPointList);
//                direction.setCourseId(2);
////                model.addAttribute("DirectionList", direction.subList(0,100));
//                mongoTemplate.insert(direction, "directions");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
		return;
    }
    
	@GetMapping("/mongo")
	public String mongoTest(Model model) {
		System.out.println("---");
		System.out.println(mongoTemplate.getDb().getName());
		
		// boot <-> spring-data-mongodb
		Query query = new Query();
		Criteria criteria = Criteria.where("_id").is(1339);
		query.addCriteria(criteria);
		
		List<Document>  ratingList = mongoTemplate.find(new Query(), Document.class, "directions");
		System.out.println(ratingList);
		List<DirectionPoint> DirectionList = new ArrayList<>();
				//이후에 document list가 아니라 directionPointlist로 받아 처리 변경 수행하겠음
		System.out.println(ratingList.size());
		
		for (Document document : ratingList) {
		    ArrayList<Document> directionPointList = (ArrayList<Document>) document.get("directionPointList");
		    
		    for (Document location : directionPointList) {
		        Double latitude = location.getDouble("mapYCoordinate");
		        Double longitude = location.getDouble("mapXCoordinate");
		        DirectionList.add(new DirectionPoint(latitude, longitude));
		        System.out.println("Latitude: " + latitude + ", Longitude: " + longitude);
		    }
		}
		model.addAttribute("DirectionList", DirectionList);
		return "map";
	}
}
