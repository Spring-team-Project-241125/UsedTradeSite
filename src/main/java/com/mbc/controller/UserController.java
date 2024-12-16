package com.mbc.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.UserVO;
import com.mbc.domain.AttachVO;
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
	
	@Autowired
	private PasswordEncoder pwencoder;
	
	private final UserService service;
	private final ProductService productService;
	private final ReviewService reviewService;
	
	@GetMapping("/store")
	public void myStore(Model model, Principal principal) {
	    log.info("my store...");

	    String username = principal.getName();
	    Long uno = service.getUnoByUsername(username);

	    model.addAttribute("vo", service.get(uno));
	    model.addAttribute("productList", productService.getProductsByUno(uno));
	    model.addAttribute("reviewList", reviewService.getReviewListByUno(uno));
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(@RequestParam("uno") Long uno, Model model) {
		log.info("get or modify...");
		
		model.addAttribute("vo", service.get(uno));
	}
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(UserVO vo) {
	    log.info("register : " + vo);

	    // 비밀번호 암호화
	    String rawPassword = vo.getPwd();  // 원래 비밀번호
	    String encodedPassword = pwencoder.encode(rawPassword);  // 비밀번호 암호화
	    vo.setPwd(encodedPassword);  // 암호화된 비밀번호를 VO에 설정

	    // 첨부 파일이 있을 경우 처리
	    if (vo.getAttachList() != null) {
	        vo.getAttachList().forEach(attach -> log.info(attach));
	    }

	    // 서비스에서 사용자 등록 처리
	    service.register(vo);

	    log.info("register after : " + vo);

	    return "redirect:/customLogin";
	}
	
	@GetMapping(value = "/check-id", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Map<String, Object>> checkId(@RequestParam("id") String id) {
		boolean isAvailable = service.isIdAvailable(id);
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("available", isAvailable);
		response.put("msg", isAvailable ? "이미 사용중인 아이디입니다." : "사용 가능한 아이디입니다.");
		
		return ResponseEntity.ok(response);
	}
	
	@PostMapping("/modify")
	public String modify(UserVO vo, RedirectAttributes rttr) {
		
		log.info("modify : " + vo);
		
		if(service.modify(vo) == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/user/detail?uno=" + vo.getUno();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("uno") Long uno, RedirectAttributes rttr) {
		
		log.info("remove..." + uno);
		
		List<AttachVO> attachList = service.getAttachList(uno);
		
		if(service.remove(uno) == 1) {
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/login";
	}
	
	@GetMapping(value = "/getAttachList",
			produces = {MediaType.APPLICATION_JSON_VALUE})
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long uno){
		log.info("getAttachList" + uno);
		
		return new ResponseEntity<>(service.getAttachList(uno), HttpStatus.OK);
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
