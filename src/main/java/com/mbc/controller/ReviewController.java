package com.mbc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.Criteria;
import com.mbc.domain.PageDTO;
import com.mbc.domain.ReviewVO;
import com.mbc.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {

	
		private final ReviewService service;
		
		//리뷰 리스트
		@GetMapping("/list")
		public void list(Criteria cri ,Model model) {
		 log.info("list: " + cri);

		// 서비스에서 전체 리뷰 목록을 가져옴
		List<ReviewVO> reviews = service.getReviewListWithProductAndbuyerIdAndsellerId(cri);
				        
		
		// 모델에 데이터 추가
		model.addAttribute("list", reviews);
		
		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		}
		
		
		

		@GetMapping("/register")
		public void register() {
			
		}
		
		// 리뷰 등록
		@PostMapping("/register")
		public String register(@ModelAttribute ReviewVO vo, RedirectAttributes rttr) {
			
			
			// 1~5 사이의 랜덤 정수 생성
		       long uno = (int) (Math.random() * 5) + 1;
		       vo.setUno(uno); // 하드코딩된 uno 설정
		       
		    // 1~5 사이의 랜덤 정수 생성
		       long pno = (int) (Math.random() * 5) + 1;
		       vo.setPno(pno); // 하드코딩된 uno 설정

		       log.info("register:========== " + vo);
		       
		       service.register(vo);
		       
		       rttr.addFlashAttribute("message", "등록되었습니다.");
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
		
		
		@GetMapping({"/get", "/modify"})
		public void get(Long rno, Criteria cri, Model model) {
			
			
			log.info("/get");
			model.addAttribute("review", service.get(rno));
		}
}
