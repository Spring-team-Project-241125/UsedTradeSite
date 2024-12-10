package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.UserVO;
import com.mbc.domain.AttachVO;
import com.mbc.domain.AuthVO;
import com.mbc.mapper.UserMapper;
import com.mbc.mapper.AttachMapper;
import com.mbc.mapper.AuthMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
	
	private final UserMapper mapper;
	
	private final AttachMapper attachMapper;
	
	private final AuthMapper authMapper;
	
	// 사용자 인증
	@Override
    public UserVO authenticate(String id, String pwd) {
        // DB에서 사용자 인증 정보 조회
        return mapper.checkUser(id, pwd);  // 사용자가 존재하면 1 이상 반환
    }
	
	@Override
	public UserVO get(Long uno) {
		log.info("get.....");
		
		return mapper.readByUno(uno);
	}

	@Transactional
	@Override
	public void register(UserVO vo) {
		log.info("register.....");
		
		mapper.create(vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		
		vo.getAttachList().forEach(attach -> {
			attach.setUno(vo.getUno());
			attachMapper.insertUno(attach);
		});
		
		// 권한 부여 처리
        AuthVO auth = new AuthVO();
        auth.setUno(vo.getUno());  // 등록된 사용자 uno 설정
        auth.setAuth("ROLE_USER");  // 기본 역할 부여

        authMapper.insertAuth(auth);  // 권한 추가

	}
	
	@Override
	public boolean isIdAvailable(String id) {
		log.info("id Available?");		
		
		return mapper.existsById(id);
	}

	@Transactional
	@Override
	public int modify(UserVO vo) {
		log.info("modify.....");
		
		attachMapper.deleteAllUno(vo.getUno());
		
		int modifyResult = mapper.update(vo);
		
		if(modifyResult == 1 && vo.getAttachList() != null &&
				vo.getAttachList().size() > 0) {
			
			vo.getAttachList().forEach(attach -> {
				attach.setUno(vo.getUno());
				attachMapper.insertUno(attach);
			});
		}
		
		return modifyResult;

	}

	@Transactional
	@Override
	public int remove(Long uno) {
		log.info("remove.....");
		
		attachMapper.deleteAllUno(uno);
		
		return mapper.delete(uno);
	}
	
	@Override
	public List<AttachVO> getAttachList(Long uno) {
		log.info("uno : " + uno);
		
		return attachMapper.findByUno(uno);
	}
	
	@Override
	public Long getUnoByUsername(String username) {
	    log.info("getUnoByUsername...");
	    return mapper.findUnoByUsername(username); // UserMapper에 해당 메서드 필요
	}

}