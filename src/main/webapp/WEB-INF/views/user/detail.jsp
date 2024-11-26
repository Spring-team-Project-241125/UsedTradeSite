<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../include/header.jsp" %>

    <div class="container py-5">
        <h2 class="py-3">내 정보</h2>

        <form>
            <div class="mb-3 col-lg-5">
                <label for="profile" class="form-label">프로필 사진</label>
                <input class="form-control" type="file" id="profile">
            </div> 
            <div class="mb-3 col-lg-5">   
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId" value="${ vo.id }">
            </div>  
            <div class="mb-3 col-lg-5"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="userPwd" value="${ vo.pwd }">
            </div>

            <button type="submit" class="btn btn-primary mt-3">회원정보 수정</button>
            <button type="submit" class="btn btn-danger mt-3">회원 탈퇴</button>
        </form>
    </div>

    </div>
    
<%@include file="../include/footer.jsp" %>