package com.mbc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.UserVO;
import com.mbc.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
	
	private final UserService service;
	
	@GetMapping({"/detail", "/modify"})
	public void detail(@RequestParam("uno") Long uno, Model model) {
		log.info("get or modify...");
		
		model.addAttribute("vo", service.get(uno));
	}
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	 public String register(UserVO vo, RedirectAttributes rttr) {
		log.info("register : " + vo);
		
		service.register(vo);
		rttr.addFlashAttribute("result", vo.getUno());
		
		return "redirect:/user/detail";
	}
	
	@PostMapping("/modify")
	public String modify(UserVO vo, RedirectAttributes rttr) {
		
		log.info("modify : " + vo);
		
		if(service.modify(vo) == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/user/detail";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("uno") Long uno, RedirectAttributes rttr) {
		
		log.info("remove..." + uno);
		
		if(service.remove(uno) == 1) {
			rttr.addAttribute("result", "success");
		}

		return "redirect:/user/detail";
	}
	
}
