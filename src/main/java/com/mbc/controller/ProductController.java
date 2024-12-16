package com.mbc.controller;


import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.mbc.domain.ProductVO;
import com.mbc.domain.UserVO;
import com.mbc.domain.AttachVO;
import com.mbc.domain.Criteria;
import com.mbc.domain.PageDTO;
import com.mbc.service.ProductService;
import com.mbc.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product")
@RequiredArgsConstructor

// @PostMapping("/register") → ProductController의 register() → ProductServicempl의 
// register() → ProductMapper의 insertSelectKey() → 데이터베이스 작업 → 완료 후 
// ProductController로 돌아가서 리다이렉트.

public class ProductController {
	
	private final ProductService service;
	
	private final UserService userservice;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		
//		log.info("list");
//		
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model, Principal principal) {
		
		cri.setAmount(12);
		
		log.info("list: " + cri);
		
		// 로그인한 사용자 정보 추가
	    if (principal != null) {
	        String username = principal.getName(); // 로그인한 사용자 이름
	        model.addAttribute("username", username); // 모델에 추가
	    }
	    
	    // 상품 목록 추가
		model.addAttribute("productList", service.getList(cri));
		
		// 전체 페이지 수
		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}

	@GetMapping("/register")
	public void register() {
		
	}
	
	@Secured({"ROLE_USER"})
	@PostMapping("/register")
	public String register(@ModelAttribute ProductVO product, RedirectAttributes rttr, Principal principal) {
	    log.info("register: " + product);

	    // 로그인한 사용자 이름을 가져옵니다
	    String username = principal.getName();

	    // 해당 사용자의 uno 값 조회
	    Long uno = userservice.getUnoByUsername(username);

	    // 사용자 uno 값으로 설정
	    product.setUno(uno);

	    // 첨부파일 리스트 로깅
	    if (product.getAttachList() != null) {
	        product.getAttachList().forEach(attach -> log.info(attach));
	    }

	    // 서비스 로직 처리
	    service.register(product);

	    // 등록 후 플래시 속성으로 pno 전달
	    rttr.addFlashAttribute("result", product.getPno());

	    return "redirect:/product/list";
	}

	private String getFolder() {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    String str = sdf.format(date);
	    return str.replace("-", File.separator);
	}

	private boolean checkImageType(File file) {
	    try {
	        // 파일의 MIME 타입을 확인
	        String contentType = Files.probeContentType(file.toPath());
	        
	        // MIME 타입이 image로 시작하는지 확인
	        if (contentType != null && contentType.startsWith("image")) {
	            return true;  // 이미지 파일일 경우 'I' 반환
	        }
	    } catch (Exception e) {
	        log.error("파일 타입 확인 오류: " + e.getMessage());
	    }
	    return false;  // 이미지가 아닌 파일은 'O' 반환
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("pno") Long pno, @ModelAttribute("cri") Criteria cri, 
	                Model model, Principal principal) {
	    log.info("/get or modify");

	    // 상품 정보 가져오기
	    ProductVO product = service.getProductWithSellerId(pno);

	    // 판매자 정보 조회
	    String sellerId = null;
	    if (product.getUno() != null) {
	        UserVO seller = userservice.get(product.getUno()); // `uno`로 사용자 정보 가져오기
	        sellerId = (seller != null) ? seller.getId() : null; // ID 추출
	    }
	    product.setSellerId(sellerId); // 조회한 판매자 ID를 ProductVO에 세팅

	    model.addAttribute("product", product);

	    // 로그인 여부 및 작성자 여부 확인
	    boolean isWriter = false;
	    if (principal != null) { // 로그인된 사용자라면
	        String username = principal.getName(); // 로그인된 사용자 ID
	        Long userId = userservice.getUnoByUsername(username); // 사용자 ID 가져오기
	        isWriter = product.getUno().equals(userId); // 작성자인지 확인
	    }

	    model.addAttribute("isWriter", isWriter); // 작성자 여부 전달
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("pno") Long pno, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {  //, String writer
		
		log.info("remove.......");
		
		List<AttachVO> attachList = service.getAttachList(pno);
		
		if(service.remove(pno) == 1) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "removesuccess");
		}
		rttr.addAttribute("pagenum", cri.getPagenum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/product/list";
	}
	
	@PostMapping("/modify")
	public String modify(ProductVO Product, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		
		log.info("modify: " + Product);
		
		if(service.modify(Product) == 1) {
			rttr.addFlashAttribute("result", "modifysuccess");
		}
		
		rttr.addAttribute("pagenum", cri.getPagenum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/product/list";
	}
	
	@GetMapping(value = "/getAttachList",
			produces = {MediaType.APPLICATION_JSON_VALUE})
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long pno){
		log.info("getAttachList" + pno);
		
		return new ResponseEntity<>(service.getAttachList(pno), HttpStatus.OK);
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
