<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="container py-5">
    <h2 class="py-3">상품 수정</h2>
    
    <form action="/product/modify" method="post">
        <!-- 상품 ID (숨겨진 필드로 전송) -->
        <input type="hidden" name="pno" value="${product.pno}" />
        
        <div class="row">
            <div class="col-lg-6">
                <img src="https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?q=80&w=1353&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    alt="product" width="100%">
            </div>
            <div class="col-lg-6">
                <label for="title">상품 제목</label>
                <input type="text" id="title" name="p_title" class="form-control" value="${product.p_title}" required />

                <label for="price" class="mt-3">상품 가격</label>
                <input type="number" id="price" name="p_price" class="form-control" value="${product.p_price}" required 
                    placeholder="가격을 입력해주세요" min="1000" step="1000" oninput="formatPrice(this)" />

                <label for="content" class="mt-3">상품 설명</label>
                <textarea id="content" name="p_content" class="form-control" rows="5" required >${product.p_content}</textarea>

                <div class="text-end mt-3">
                    <button type="submit" class="btn btn-primary">수정 완료</button>
                    <a href="get.jsp?pno=${product.pno}" class="btn btn-secondary">취소</a>
                </div>
            </div>
        </div>
    </form>
</div>

<%@ include file="../includes/footer.jsp" %>
