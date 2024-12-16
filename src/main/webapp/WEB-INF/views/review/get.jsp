<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="container py-5">
    <h2 class="py-3">리뷰 상세보기</h2>
    

    <!-- 리뷰 상세 폼 -->
    <form role="form" action="/review/update" method="post" enctype="multipart/form-data">
			
		 <div class="mb-3 col-lg-5">
            	<div class="uploadResult">   	
	                <ul></ul>
            	</div>
            </div> 

        <div class="mb-3">
            <label for="pno" class="form-label">상품명 및 판매자</label>
            <input type="text" id="pno" name="pno" value="${review.p_title} , ${review.sellerId} " readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="uno" class="form-label">구매자 ID</label>
            <input type="text" id="uno" name="uno" value="${review.buyerId}" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="r_content" class="form-label">리뷰 내용</label>
            <textarea class="form-control" id="r_content" name="r_content" readonly style="height: 100px;">${review.r_content}</textarea>
        </div>

       

        <!-- 리뷰 등록 후 수정할 수 없도록 readonly를 추가했습니다 -->
        <div class="mb-3">
            <label for="r_regdate" class="form-label">작성일</label>
            <input type="text" id="r_regdate" name="r_regdate" value="<fmt:formatDate value='${review.r_regdate}' pattern='yyyy.MM.dd'/>" readonly class="form-control">
        </div>
        
    </form>
	
		<button data-oper='list' class="btn btn-primary mt-3"
        onclick="location.href='/review/list'">목록</button>
	
			<!-- 작성자인 경우 -->
   				 	<c:if test="${isWriter}">
		<a href="/review/modify?rno=${review.rno}" class="btn btn-primary mt-3">수정</a>
		
		
		<button type="button" class="btn btn-danger mt-3" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
		</c:if>
		
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
                <form action="/review/remove" method="POST" id="deleteForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="rno" value="${review.rno}">
                    <button type="submit" class="btn btn-danger">예</button>
                <!-- 삭제를 위한 폼 -->
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 삭제 확인 모달 끝 -->
			
			

</div>

<%@ include file="../includes/footer.jsp" %>

<script>
$(function(){
	let rno = '<c:out value="${review.rno}" />';
	
	$.ajax({
		url: '/review/getAttachList',
		method: 'get',
		data: {rno: rno},
		dataType: 'json',
		success: function(result){
			console.log(result);
			
			let str = '';
			
			$(result).each(function(i, attach){
				// image type
				if(attach.fileType){
					let fileCallPath = encodeURIComponent(attach.uploadPath + '/' 
							+ attach.uuid + '_' + attach.fileName);
					
					str += '<li data-path="'+ attach.uploadPath +'" data-uuid="'+ attach.uuid;
					str += '" data-filename="'+ attach.fileName +'" data-type="'+ attach.fileType +'">';
					str += '<img src="/display?fileName='+ fileCallPath +'">';
					str += '</li>';
				}else {										
					str += '<li data-path="'+ attach.uploadPath +'" data-uuid="'+ attach.uuid;
					str += '" data-filename="'+ attach.fileName +'" data-type="'+ attach.fileType +'">';
					str += '<span>'+ attach.fileName + '</span><br>';
					str += '<img alt="profile" src="/resources/img/unknown.jpg" width="100px">';
					str += '</li>';
				}
			});
			$('.uploadResult ul').html(str);

		}
	});
	
});
</script>
