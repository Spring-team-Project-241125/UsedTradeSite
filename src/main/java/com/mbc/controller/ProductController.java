package com.mbc.controller;


import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.mbc.domain.ProductVO;
import com.mbc.domain.AttachVO;
import com.mbc.domain.Criteria;
import com.mbc.domain.PageDTO;
import com.mbc.service.ProductService;

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
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		
//		log.info("list");
//		
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list: " + cri);
		model.addAttribute("productList", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}

	@GetMapping("/register")
	public void register() {
		
	}
	

	@PostMapping("/register")
	public String register(@ModelAttribute ProductVO product, 
	                       @RequestParam("p_image") MultipartFile[] files, 
	                       RedirectAttributes rttr) {
	    log.info("register: " + product);

	    // 1~5 사이의 랜덤 정수 생성
	    long uno = (int) (Math.random() * 5) + 1;
	    product.setUno(uno);

	    // 첨부파일 저장 처리
	    List<AttachVO> attachList = new ArrayList<>();
	    String uploadFolder = "C:\\upload";
	    String uploadFolderPath = getFolder();

	    File uploadPath = new File(uploadFolder, uploadFolderPath);
	    if (!uploadPath.exists()) {
	        uploadPath.mkdirs();
	    }

	    for (MultipartFile file : files) {
	        if (!file.isEmpty()) {
	            String originalFileName = file.getOriginalFilename();
	            String uuid = UUID.randomUUID().toString();
	            String saveName = uuid + "_" + originalFileName;

	            File saveFile = new File(uploadPath, saveName);
	            try {
	                file.transferTo(saveFile);

	                // attachVO 객체 생성
	                AttachVO attach = new AttachVO();
	                attach.setUuid(uuid);
	                attach.setFileName(originalFileName);
	                attach.setUploadPath(uploadFolderPath);
	                attach.setFileType(checkImageType(saveFile));
	                
	              
	                attach.setPno(product.getPno());  //  상품 번호(pno)를 설정

	                // attachList에 추가
	                attachList.add(attach);
	            } catch (Exception e) {
	                log.error("파일 저장 중 오류 발생: " + e.getMessage());
	            }
	        }
	    }

	    // ProductVO에 attachList 설정
	    product.setP_image(attachList);  // attachVO 리스트를 설정

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
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("pno") Long pno, @ModelAttribute("cri") Criteria cri, 
			Model model) {
		
		log.info("/get or modify");
		
		ProductVO product = service.getProductWithSellerId(pno);
		
		// 판매자 정보 조회 (상품의 uno를 기준으로 사용자 ID 조회)
      //  String sellerId = userService.getUserIdByUno(product.getUno());
      //  product.setSellerId(sellerId);  // 조회한 판매자 ID를 ProductVO에 세팅
		
		model.addAttribute("product", product);
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("pno") Long pno, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {  //, String writer
		
		log.info("remove.......");
		if(service.remove(pno) == 1) {
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

}
