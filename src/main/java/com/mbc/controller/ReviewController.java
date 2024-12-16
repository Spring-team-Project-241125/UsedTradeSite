package com.mbc.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.AttachVO;
import com.mbc.domain.Criteria;
import com.mbc.domain.PageDTO;
import com.mbc.domain.ReviewVO;
import com.mbc.service.ReviewService;
import com.mbc.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {

	
		private final ReviewService service;
		
		private final UserService userservice;
		
		//리뷰 리스트
		@GetMapping("/list")
		public void list(Criteria cri ,Model model) {
		 log.info("list: " + cri);

		// 서비스에서 전체 리뷰 목록을 가져옴
		List<ReviewVO> reviews = service.getReviewListWithProductAndbuyerIdAndsellerId(cri);
				   
		  // 전체 리뷰 수를 가져옴
        int totalCount = service.getTotalCount(cri);
        
        // PageDTO 객체를 사용하여 페이지 정보 계산
        PageDTO pageMaker = new PageDTO(cri, totalCount);
		
		// 모델에 데이터 추가
		model.addAttribute("list", reviews);
		
		model.addAttribute("pageMaker", pageMaker);
		
		}
		
		
		

		@GetMapping("/register")
		public void register() {
			
		}
		
		// 리뷰 등록
		@PostMapping("/register")
		public String register(@ModelAttribute ReviewVO vo, RedirectAttributes rttr, Principal principal) {
		    // 로그인한 사용자 이름을 가져옵니다
		    String username = principal.getName();

		    // 해당 사용자의 uno 값 조회
		    Long uno = userservice.getUnoByUsername(username);

		    // 사용자 uno 값을 ReviewVO에 설정
		    vo.setUno(uno);

		    // pno는 랜덤으로 설정 (기존 방식 유지)
		    long pno = (int) (Math.random() * 5) + 1;
		    vo.setPno(pno);

		    if (vo.getAttachList() != null) {
		        vo.getAttachList().forEach(attach -> log.info(attach));
		    }

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
			
			//로그인된 사용자 정보 가져오기
//			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//			String loggedInUserId = user.getUsername();
			
//			ReviewVO review = service.get(vo.getRno());
//			if (review != null && review.getBuyerId().equals(loggedInUserId)) {
				//수정 처리
				if(service.modify(vo)== 1) {
					rttr.addFlashAttribute("result", "success");
				}
//			}else {
//				rttr.addFlashAttribute("message", "수정 권한이 없습니다.");
//			}
			
			return "redirect:/review/list";
		}

		
		
		
		
		//리뷰 삭제
		@PostMapping("/remove")
		public String remove(Long rno, Criteria cri, RedirectAttributes rttr) {
			log.info("remove : " + rno );
			
			//로그인된 사용자 정보 가져오기
//			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//			String loggedInUserId = user.getUsername();
			
			
			// 리뷰 작성자 ID와 로그인된 사용자 ID 비교
//			ReviewVO review = service.get(rno);
//			if (review != null && review.getBuyerId().equals(loggedInUserId)) {
				List<AttachVO> attachList = service.getAttachList(rno);
					
				//삭제처리
				if(service.remove(rno) ==1) {
					deleteFiles(attachList);
					rttr.addFlashAttribute("removeresult", "success");
				}
//			} else {
//				rttr.addFlashAttribute("message", "삭제 권한이 없습니다.");
//			}
			return "redirect:/review/list";
		}
		
		
		@GetMapping({"/get", "/modify"})
		public void get(Long rno, Criteria cri, Model model, Principal principal) {
		    log.info("/get");

		    // 리뷰 정보 가져오기
		    ReviewVO review = service.get(rno);
		    model.addAttribute("review", review);

		    // 작성자 여부 확인
		    boolean isWriter = false;
		    if (principal != null) { // 로그인된 사용자라면
		        String username = principal.getName(); // 로그인된 사용자 ID
		        Long userId = userservice.getUnoByUsername(username); // 사용자 ID 가져오기
		        isWriter = review.getUno().equals(userId); // 작성자인지 확인
		    }

		    model.addAttribute("isWriter", isWriter); // 작성자 여부 전달
		}
		
		
		@GetMapping(value = "/getAttachList",
				produces = {MediaType.APPLICATION_JSON_VALUE})
		@ResponseBody
		public ResponseEntity<List<AttachVO>> getAttachList(Long rno){
			log.info("getAttachList" + rno);
			
			return new ResponseEntity<>(service.getAttachList(rno), HttpStatus.OK);
		}	
		
		private void deleteFiles(List<AttachVO> attachList) {
			
			if(attachList == null || attachList.size() == 0) {
				return;
			}
			
			log.info("delete attach files.....");
			log.info(attachList);
			
			attachList.forEach(attach -> {
				try {
					Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + 
										attach.getUuid() + "_" + attach.getFileName());
					
					Files.deleteIfExists(file);
					
					
					Path thumbnail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + 
									attach.getUuid() + "_" + attach.getFileName());
					
					Files.delete(thumbnail);
					
					
				}catch(Exception e) {
					log.error("delete file error" + e.getMessage());
				}
			});
		}
}
