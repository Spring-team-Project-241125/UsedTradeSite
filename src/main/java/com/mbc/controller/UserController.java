package com.mbc.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.UserVO;
import com.mbc.mapper.AttachMapper;
import com.mbc.domain.AttachVO;
import com.mbc.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
	
	private final UserService service;
	
	@GetMapping("/store")
	public void myStroe(@RequestParam("uno") Long uno, Model model) {
		log.info("my store...");
		
		model.addAttribute("vo", service.get(uno));		
		
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
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(vo);
		log.info("register after : " + vo);
		
		return "redirect:/login";
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
