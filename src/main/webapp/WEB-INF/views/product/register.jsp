<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

		 <div class="container py-5">
        <h2 class="py-3">판매상품 등록</h2>
    
    
    
        <form id="productForm" role="form" action="/product/register" method="post" enctype="multipart/form-data">
        <div class="mb-3 col-lg-5">
            <label for="formFileMultiple" class="form-label">상품 이미지 첨부</label>
            <input class="form-control" type="file" id="formFileMultiple" name="p_image" multiple>
        </div>
        <div id="imagePreview" class="mb-3">
            <!-- 업로드된 이미지 미리보기 -->
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
	
	
	<script>
	$(document).ready(function() {
    $('#uploadBtn').on('click', function() {
        var formData = new FormData();
        var files = $('#formFileMultiple')[0].files;

        // 선택된 파일이 있을 경우에만 업로드
        if (files.length > 0) {
            // FormData에 파일 추가
            for (var i = 0; i < files.length; i++) {
                formData.append("p_image", files[i]);
            }

            $.ajax({
                url: '/product/uploadImage',  // 서버에서 이미지를 처리할 URL
                type: 'POST',
                data: formData,
                processData: false,  // FormData 사용시 false
                contentType: false,  // FormData 사용시 false
                success: function(response) {
                    if (response.success) {
                        // 성공적으로 업로드되면 이미지 미리보기
                        var imgPreview = '<img src="' + response.imageUrl + '" alt="Uploaded Image" class="img-thumbnail" width="100">';
                        $('#imagePreview').html(imgPreview);
                    } else {
                        alert('이미지 업로드 실패');
                    }
                },
                error: function() {
                    alert('서버 오류로 이미지 업로드 실패');
                }
            });
        } else {
            alert('파일을 선택해주세요');
        }
    });
});
	</script>
