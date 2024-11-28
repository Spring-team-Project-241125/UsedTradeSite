package com.mbc.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.Criteria;
import com.mbc.domain.ReviewPageDTO;
import com.mbc.domain.ReviewVO;
import com.mbc.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/review/")
public class ReviewController {

	
		private final ReviewService service;
		
		//리뷰 리스트
		@GetMapping("/list")
		public void list(Model model, Criteria cri, Long uno) {
			log.info("list");
			
			model.addAttribute("list", service.getList(cri, uno));
			
		}
		

		@GetMapping("/register")
		@PreAuthorize("isAuthenticated()")
		public void register() {
			
		}
		
		// 리뷰 등록
		@PostMapping("/register")
		public String register(ReviewVO vo, RedirectAttributes rttr) {
			
			log.info("register:========== " + vo);
			service.register(vo);
			
			rttr.addFlashAttribute("result", vo.getRno());
			
			return "redirect:/review/list";
		}
		
		//리뷰 수정
		@PostMapping("/modify")
		public String modify(ReviewVO vo, Criteria cri ,RedirectAttributes rttr ) {
			log.info("modify : "  + vo);
			
			if(service.modify(vo)== 1) {
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/review/list";
		}

		
		//리뷰 삭제
		@PostMapping("/remove")
		public String remove(Long rno, Criteria cri, RedirectAttributes rttr) {
			log.info("remove : " + rno );
			
			if(service.remove(rno)==1) {
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/review/list";
		}
		
		
		@GetMapping("/get")
		public void get(Long rno, Criteria cri, Model model) {
			
			log.info("/get");
			model.addAttribute("rno", service.get(rno));
		}
}
