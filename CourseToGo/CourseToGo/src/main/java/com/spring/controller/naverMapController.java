package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class naverMapController {
	
	@RequestMapping(value = "/courseMake")
	public String naverMap() {
		
		return "naverMap";
	}
	
}
