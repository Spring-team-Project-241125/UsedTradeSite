<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

    <div class="container py-5">
        <h2 class="py-3">내 상점</h2>

        <div class="row">
            <div class="col-3">
                <img src="/resources/img/unknown.jpg" alt="user" style="width:100%;">
            </div>
            <div class="col-9">
                <h3 class="pb-2">아이디 : ${ vo.id }</h3>                

            </div>
        </div>

        <nav class="pt-5"></nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="nav-sale-tab" data-bs-toggle="tab" data-bs-target="#nav-sale"
                    type="button" role="tab" aria-controls="nav-sale" aria-selected="true">판매내역</button>
                <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-purchase"
                    type="button" role="tab" aria-controls="nav-purchase" aria-selected="false">구매내역</button>
                <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-reviews"
                    type="button" role="tab" aria-controls="nav-reviews" aria-selected="false">리뷰정보</button>
            </div>
        </nav>
        
        <div class="tab-content py-3" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-sale" role="tabpanel" aria-labelledby="nav-sale-tab"
                tabindex="0"> 
                <div class="d-flex justify-content-end mt-3">
		        	 <a href="/product/register" class="btn btn-sm btn-primary mb-3">상품등록</a>
				</div>
				               
                <c:if test="${ not empty productList }">
                <table class="table">
		            <thead>
		                <tr>
		                    <th scope="col">#</th>
		                    <th scope="col">이미지</th>
		                    <th scope="col">상품명</th>
		                    <th scope="col">가격</th>		
		                    <th scope="col">등록일</th>
		                    <th scope="col">수정일</th>
		                </tr>
		            </thead>
		            <tbody>
		            	<c:forEach items="${ productList }" var="product">
		                <tr>
		                	
		                    <th scope="row">${ product.pno }</th>
		                    <td class="pimg">
		                    	<a href="/product/get?pno=${ product.pno }">			                    
			                   		<img src="https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?q=80&w=1353&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			                     alt="${ product.p_title }" width="100px">
			                    </a>   
		                    </td>
		                    <td><a href="/product/get?pno=${ product.pno }">${product.p_title}</a></td>
		                    <td><fmt:formatNumber value="${ product.p_price }" pattern="#,###" />원</td>
		                    <td><fmt:formatDate value="${ product.p_regdate }" type="date" dateStyle="default" /></td>
		                    <td><fmt:formatDate value="${ product.p_updatedate }" type="date" dateStyle="default" /></td>
		                    
		                </tr>
		                </c:forEach>
		            </tbody>
		        </table>
		    	</c:if>
		    	
		    	<c:if test="${ empty productList }">
                <p class="text-center mt-5">판매 내역이 없습니다.</p>
                </c:if>
                
			</div>
			
            <div class="tab-pane fade" id="nav-purchase" role="tabpanel" aria-labelledby="nav-purchase-tab" tabindex="0">            	
            	<p class="text-center mt-5">구매 내역이 없습니다.</p>
            </div>
            
            <div class="tab-pane fade" id="nav-reviews" role="tabpanel" aria-labelledby="nav-reviews-tab" tabindex="0">
            	<div class="d-flex justify-content-end mt-3">
		        	 <a href="/review/register" class="btn btn-sm btn-primary mb-3">리뷰등록</a>
				</div>
            	
            	<c:if test="${ not empty reviewList }">           	
            	<table class="table">
		            <thead>
		                <tr>
		                    <th scope="col">#</th>
		                    <th scope="col">상품명</th>
		                    <th scope="col">작성자ID</th>
		                    <th scope="col">내용</th>
		                    <th scope="col">작성일</th>
		                </tr>
		            </thead>
		            
		            <tbody>
		            <!-- 모델에서 전달된 리뷰 목록을 반복하여 표시 -->
		            <c:forEach var="review" items="${reviewList}">
		                <tr>
		                    <th scope="row">${review.rno}</th> <!-- 리뷰 번호 -->
		                    <td>${review.p_title}</td> <!-- 상품명 -->
		                    <td>${review.sellerId}</td> <!-- 작성자 ID -->
		                    <td>${review.r_content}</td> <!-- 리뷰 내용 -->
		                    <td><fmt:formatDate value="${review.r_regdate}" pattern="yyyy.MM.dd" /></td> <!-- 작성일 -->
		                </tr>
		            </c:forEach>
		        	</tbody>	            
		           
		        </table>
		        </c:if>
		        
		        <c:if test="${ empty reviewList }">
            	<p class="text-center mt-5">리뷰 정보가 없습니다.</p>
            	</c:if>
            </div>
        </div>
    </div>

<%@include file="../includes/footer.jsp" %>