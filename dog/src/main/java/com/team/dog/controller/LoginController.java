package com.team.dog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
	@GetMapping("/mapmain")
	public String mapmain() {
		return "mapmain";
	}
}
