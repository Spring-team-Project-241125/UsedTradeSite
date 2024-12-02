<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

	<div class="container py-5">
        <h2 class="py-3">내 정보</h2>

        <form>
            <div class="mb-3 col-lg-5">
                <img alt="profile" src="/resources/img/unknown.jpg" width="200px">
            </div> 
            <div class="mb-3 col-lg-5">   
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId"
                 name="id" value="${ vo.id }" readonly>
            </div>  
            <div class="mb-3 col-lg-5"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="userPwd"
                 name="pwd" value="${ vo.pwd }" readonly>
            </div>

            <button type="button" class="btn btn-primary mt-3" 
            onclick="location.href='/user/modify?uno=${vo.uno}'">회원정보 수정</button>
        </form>
    </div>

<%@include file="../includes/footer.jsp" %>