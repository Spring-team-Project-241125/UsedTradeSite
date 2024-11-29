package com.mbc.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.Criteria;
import com.mbc.domain.UserVO;
import com.mbc.service.ProductService;
import com.mbc.service.ReviewService;
import com.mbc.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
	
	private final UserService userService;
	private final ProductService productService;
	private final ReviewService reviewService;
	
	@GetMapping("/store")
	public void myStroe(@RequestParam("uno") Long uno, Model model) {
		log.info("my store...");
		
		model.addAttribute("vo", userService.get(uno));
		model.addAttribute("productList", productService.getProductsByUno(uno));
		model.addAttribute("reviewList", reviewService.getReviewListByUno(uno));		
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(@RequestParam("uno") Long uno, Model model) {
		log.info("get or modify...");
		
		model.addAttribute("vo", userService.get(uno));
	}
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	 public String register(UserVO vo) {
		log.info("register : " + vo);
		
		userService.register(vo);
		log.info("register after : " + vo);		
	
		return "redirect:/login";
	}
	
	@GetMapping(value = "/check-id", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Map<String, Object>> checkId(@RequestParam("id") String id) {
		boolean isAvailable = userService.isIdAvailable(id);
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("available", isAvailable);
		response.put("msg", isAvailable ? "이미 사용중인 아이디입니다." : "사용 가능한 아이디입니다.");
		
		return ResponseEntity.ok(response);
	}
	
	@PostMapping("/modify")
	public String modify(UserVO vo) {
		
		log.info("modify : " + vo);
		
		userService.modify(vo);
		
		return "redirect:/user/detail?uno=" + vo.getUno();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("uno") Long uno) {
		
		log.info("remove..." + uno);
		
		userService.remove(uno);

		return "redirect:/login";
	}
	
}
