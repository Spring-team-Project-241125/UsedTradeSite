<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="includes/header.jsp" %>

    <div class="container py-5 col-lg-4">
        <h2 class="py-3 text-center">로그인</h2>

        <form action="/product/list" method="get">
            <div class="mb-3">   
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId" placeholder="아이디를 입력해주세요">
            </div>  
            <div class="mb-3"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="userPwd" placeholder="비밀번호를 입력해주세요">
            </div>

            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-primary mt-3">로그인</button>
            </div>  
        </form>

    </div>

<%@include file="includes/footer.jsp" %>