package com.team.dog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.team.dog.model.service.DogService;

@Controller
public class DogController {
   @Autowired
   private DogService dogService; 
   
   @GetMapping("/mapmain")
   public String mapmain(Model model, String hospitalname) {
      model.addAttribute("list",dogService.selectList());
      
      model.addAttribute("searchlist", dogService.selectSearchList(hospitalname));
      System.out.println(dogService.selectSearchList(hospitalname));
      
      return "mapmain";
   }
   
    

}