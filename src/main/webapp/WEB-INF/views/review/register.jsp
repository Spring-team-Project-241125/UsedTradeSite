<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

       <div class="container py-5">
        <h2 class="py-3">리뷰 등록</h2>
    
        <form role="form" action="/review/register" method="post" enctype="multipart/form-data">
    <div class="mb-3 col-lg-5">
        <label for="formFileMultiple" class="form-label">상품 이미지 첨부</label>
        <input class="form-control" type="file" id="formFileMultiple" name="r_image" multiple>
    </div> 
    
    <div class="mb-3">
        <label for="description">자세한 설명</label>
        <textarea class="form-control" id="description" name="r_content" placeholder="자세한 설명을 입력해주세요" style="height: 100px;"></textarea>                
    </div>
    
    <button type="submit" class="btn btn-primary mt-3">상품등록</button>
</form>
    
    </div>
   
   <%@include file="../includes/footer.jsp"%>