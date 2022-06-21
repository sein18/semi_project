package com.team.dog.controller;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team.dog.model.dto.LoginDto;
import com.team.dog.model.service.LoginService;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;

@Controller
public class LoginController {
	@Autowired
	public LoginService loginService;

	@GetMapping("/loginok")
	public String Login() {

		return "login";
	}

	@GetMapping("/register")
	public String Register(LoginDto dto, Model model) {

		model.addAttribute("dto", dto);
		model.addAttribute("error", "null");
		return "register";

	}

	@PostMapping("/registerres")
	public String RegisterRes(LoginDto dto, Model model, HttpServletRequest request, HttpServletResponse response) {
		int res = 0;
		if ((dto.getId() == "" || dto.getId() == null) || (dto.getPw() == "" || dto.getPw() == null)) {
			model.addAttribute("error", "fail");
		} else {

			try {

				res = loginService.register(dto);
				if (res > 0) {

					System.out.println(dto.getName());
					System.out.println(dto.getId());
					System.out.println(dto.getEmail());
					System.out.println(dto.getPhone());
					return "login";
				}
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error", "fail");
				return "register";
			}

		}
		if (res > 0) {

			System.out.println(dto.getName());
			System.out.println(dto.getId());
			System.out.println(dto.getEmail());
			System.out.println(dto.getPhone());
			return "login";
		} else {
			model.addAttribute("error", "fail");
			return "register";
		}
	}

	@PostMapping("/loginchk")
	public String LoginChk(LoginDto dto, Model model, HttpServletRequest request, HttpServletResponse response) {
		LoginDto dtoser = loginService.loginchk(dto);
		System.out.println("dto:" + dto.getId());
		
		
		if (dto.getId() == "" || dto.getPw() == "") {
			model.addAttribute("error", "empty");
			return "login";
		}
		if (dtoser != null) { 
			HttpSession session = request.getSession(true);
			session.setAttribute("loginres", dtoser);
			return "redirect:/mapmain";
		}else {
			model.addAttribute("error", "fail");
			return "login";
			
		}
		
	}

}
