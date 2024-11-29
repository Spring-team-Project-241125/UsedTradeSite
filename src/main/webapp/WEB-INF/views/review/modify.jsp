<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="container py-5">
    <h2 class="py-3">리뷰 수정</h2>
    
    <!-- 리뷰 수정 폼 -->
    <form action="/review/modify" method="post">
        <!-- 리뷰 ID (숨겨진 필드로 전송) -->
        <input type="hidden" name="rno" value="${review.rno}" />
	
        <div class="mb-3">
            <label for="p_title" class="form-label">상품명 및 판매자</label>
            <input type="text" id="p_title" name="p_title" value="${review.p_title} , ${review.sellerId}" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="buyerId" class="form-label">구매자 ID</label>
            <input type="text" id="buyerId" name="buyerId" value="${review.buyerId}" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="r_content" class="form-label">리뷰 내용</label>
            <textarea class="form-control" id="r_content" name="r_content" style="height: 100px;">${review.r_content}</textarea>
        </div>

	

        <!-- 버튼들 (수정 완료, 취소) -->
        <div class="d-flex justify-content-between mt-3">
            <!-- 수정 완료 버튼 (폼 제출) -->
            <button type="submit" class="btn btn-primary">수정 완료</button>
            
            <!-- 취소 버튼 (리스트 페이지로 이동) -->
            <a href="/review/list" class="btn btn-danger">취소</a>
        </div>
        
    </form>
</div>

<%@ include file="../includes/footer.jsp" %>
