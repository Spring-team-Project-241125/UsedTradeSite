<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

		 <div class="container py-5">
        <h2 class="py-3">상품 상세</h2>
        
        <div class="row">
            <div class="col-lg-6">
                <img src="https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?q=80&w=1353&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    alt="product" width="100%">
            </div>
            <div class="col-lg-6">
                <h3 class="pb-5"><c:out value="${product.p_title}" /></h3>
                <h4 class="text-end pb-3"> <fmt:formatNumber value="${product.p_price}" pattern="#,###" />
    원</h4>
    
     <p>판매자: <c:out value="${product.sellerId}" /></p> 
    
                <div class="text-end">
                    <button type="button" class="btn btn-warning mt-3 ">장바구니</button>
                    <button type="button" class="btn btn-danger mt-3 ">구매하기</button>
                    
                    <a href="/product/modify?pno=${product.pno}" class="btn btn-primary mt-3">   수정하기   </a>
                    <button type="button" class="btn btn-danger mt-3" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제하기</button>
                </div>        
                
                <!-- 삭제 확인 모달 시작 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">게시글 삭제</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                정말로 이 게시글을 삭제하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
                <!-- 삭제를 위한 폼 -->
                <form action="/product/remove" method="POST" id="deleteForm">
                    <input type="hidden" name="pno" value="${product.pno}">
                    <button type="submit" class="btn btn-danger">예</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 삭제 확인 모달 끝 -->


            </div>
        </div>

        <nav class="pt-5">
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home"
                    type="button" role="tab" aria-controls="nav-home" aria-selected="true">상품 설명</button>
                <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"
                    type="button" role="tab" aria-controls="nav-profile" aria-selected="false">리뷰</button>
                <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact"
                    type="button" role="tab" aria-controls="nav-contact" aria-selected="false">거래방법</button>
            </div>
        </nav>
        <div class="tab-content py-3" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab"
                tabindex="0">${product.p_content}</div>
            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                리뷰 보여주기</div>
            <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">
                거래방법 설명</div>
        </div>
    </div>
    
	
	<%@include file="../includes/footer.jsp"%>
	
