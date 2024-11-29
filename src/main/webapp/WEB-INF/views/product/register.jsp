<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

		 <div class="container py-5">
        <h2 class="py-3">판매상품 등록</h2>
    
        <form role="form" action="/product/register" method="post" enctype="multipart/form-data">
    <div class="mb-3 col-lg-5">
        <label for="formFileMultiple" class="form-label">상품 이미지 첨부</label>
        <input class="form-control" type="file" id="formFileMultiple" name="p_image" multiple>
    </div> 
    <div class="mb-3 col-lg-5">   
        <label for="productTitle" class="form-label">상품명</label>
        <input type="text" class="form-control" id="productTitle" name="p_title" placeholder="상품명을 입력해주세요">
    </div>  
    <div class="mb-3 col-lg-5"> 
    <label for="price" class="form-label">가격</label>
    <input type="number" class="form-control" id="price" name="p_price" placeholder="가격을 입력해주세요" min="1000" step="1000">
	</div>
    <div class="mb-3 col-lg-5">
        <label for="category" class="form-label">카테고리</label>
        <select class="form-select" id="category" name="cate_no">
            <option value="1">전자제품</option>
            <option value="2">의류</option>
            <option value="3">생활용품</option>
        </select>
    </div>
    <div class="mb-3 col-lg-5">
    <label for="quantity" class="form-label">수량</label>
    <input type="number" class="form-control" id="quantity" name="p_quantity" placeholder="수량을 입력해주세요" min="1">
</div>
    <div class="mb-3">
        <label for="description">자세한 설명</label>
        <textarea class="form-control" id="description" name="p_content" placeholder="자세한 설명을 입력해주세요" style="height: 100px;"></textarea>                
    </div>
    
    <button type="submit" class="btn btn-primary mt-3">상품등록</button>
</form>
    
    </div>
	
	<%@include file="../includes/footer.jsp"%>