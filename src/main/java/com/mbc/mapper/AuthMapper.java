package com.mbc.mapper;

import com.mbc.domain.AuthVO;

public interface AuthMapper {
    
    // 사용자 권한 추가
    void insertAuth(AuthVO auth);
}