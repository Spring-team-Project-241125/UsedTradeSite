<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

       <div class="container py-5">
        <h2 class="py-3">리뷰 등록</h2>
    
        <form role="form" action="/review/register" method="post" enctype="multipart/form-data">
    
    <div class="mb-3">
        <label for="description">자세한 설명</label>
        <textarea class="form-control" id="description" name="r_content" placeholder="자세한 설명을 입력해주세요" style="height: 100px;"></textarea>                
    </div>
    
    <div class="mb-3 col-lg-5">
        <label for="formFileMultiple" class="form-label">상품 이미지 첨부</label>
        <input class="form-control" type="file" id="formFileMultiple" name="uploadFile" multiple>
     	 <div class="uploadResult">
					<ul>
					</ul>
				</div>      
    </div> 

		 <!-- 버튼들 -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary mt-3">등록완료</button>
            <button type="button" class="btn btn-secondary mt-3" onclick="window.location.href='/review/list';">등록취소</button>
        </div>
    
</form>
    
    </div>

   <%@include file="../includes/footer.jsp"%>
   
   <script>
   $(function(){
		
		const formObj = $('form');
		
		$('button[type="submit"]').click(function(e){
			e.preventDefault();
			
			alert("회원에 가입되었습니다.\n로그인후 이용해주세요~");

			// 첨부파일 정보는 <input type="hidden">으로 처리하고
			// form 태그로 전송하는 부분
			let str = '';
			
			$('.uploadResult ul li').each(function(i, obj){
				const jobj = $(obj);
				console.dir(jobj);  //JavaScript 객체 속성을 인터랙티브한 목록으로 표시
				
				str += '<input type="hidden" name="attachList['+ i +'].fileName" value="'+ jobj.data('filename') +'">';
				str += '<input type="hidden" name="attachList['+ i +'].uuid" value="'+ jobj.data('uuid') +'">';
				str += '<input type="hidden" name="attachList['+ i +'].uploadPath" value="'+ jobj.data('path') +'">';
				str += '<input type="hidden" name="attachList['+ i +'].fileType" value="'+ jobj.data('type') +'">';
			});
			
			formObj.append(str).submit();

		});
	});	
   
   
   </script>
   
   <%@include file="../includes/file_register.jsp" %>