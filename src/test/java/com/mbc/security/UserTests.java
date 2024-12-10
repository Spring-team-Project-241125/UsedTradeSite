package com.mbc.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class UserTests {
	
	@Autowired
	private PasswordEncoder pwencoder;
	
	@Autowired
	private DataSource ds;
	
	@Test
	public void testInsertUser() {
		
		log.info("진입확인용");
		
		String sql = "insert into users(uno,id,pwd) values (?,?,?)";
		
		for(int i=6; i<101; i++) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(3, pwencoder.encode("1234"));
				
				if(i<80) {
					
					pstmt.setLong(1, i);
					pstmt.setString(2, "일반사용자"+i);
					
				}else if (i<90) {
					
					pstmt.setLong(1, i);
					pstmt.setString(2, "운영자"+i);
					
				}else {
					
					pstmt.setLong(1, i);
					pstmt.setString(2, "관리자"+i);
					
				}
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {try {pstmt.close();}catch(Exception e) {}}
				if(con != null) {try {con.close();}catch(Exception e) {}}
			}
		}//end for
	}
	
	@Test
	public void testInsertAuth() {
		
		String sql = "insert into users_auth (uno, auth) values (?,?)";
		
		for(int i=6; i<101; i++) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				
				if(i<80) {
					
					pstmt.setLong(1,i);
					pstmt.setString(2, "ROLE_USER");
					
				}else if(i<90) {
					
					pstmt.setLong(1, i);
					pstmt.setString(2, "ROLE_MEMBER");
					
				}else {
					
					pstmt.setLong(1, i);
					pstmt.setString(2, "ROLE_ADMIN");
					
				}
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {try {pstmt.close();}catch(Exception e) {}}
				if(con != null) {try {con.close();}catch(Exception e) {}}
			}
		}//end for
	}

}
