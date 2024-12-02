<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<%@ include file="../includes/header.jsp" %>

<div class="container py-5">
        <h2 class="py-3">리뷰 등록</h2>
        
		<!-- 리뷰 등록 폼 -->    
        <form action="/review/register" method="post">
        	<!-- 리뷰 내용 입력 -->
            <div class="mb-3">
                <label for="description">자세한 설명</label>
                <textarea class="form-control" name="r_content" placeholder="자세한 설명을 입력해주세요" style="height: 100px;" id="description"></textarea>                
            </div>  
            
            <!-- 등록 버튼 -->
            <button type="submit" class="btn btn-primary mt-3">등록하기</button>
        </form>
        
        <form action="/review/attach" method="post" enctype="multipart/form-data">
        <!-- 상품 이미지 첨부 -->
            <div class="mb-3 col-lg-5">
                <label for="formFileMultiple" class="form-label">상품 이미지 첨부</label>
                <input class="form-control"  type="file" id="formFileMultiple" multiple>
            </div> 
        </form>
    
    </div>
    
 <%@ include file="../includes/footer.jsp" %> 