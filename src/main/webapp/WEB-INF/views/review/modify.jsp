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
        	 <div class="mb-3 col-lg-5">
            <label for="profile" class="form-label">리뷰 사진 </label>
            <input class="form-control" type="file" id="profile" name="uploadFile">
            <div class="uploadResult mt-3">   	
	            <ul></ul>
            </div>
        </div> 
	
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
            
            <!-- 수정, 삭제 버튼을 본인에게만 보이도록 -->
          <%--   <c:if test="${review.buyerId == loggedInUserId}">
            	
            	<a href="/review/remove?rno=${review.rno}" class="btn btn-danger">삭제</a>
            </c:if> --%>
            
        </div>
        
    </form>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
	$(function(){
		const formObj =$('form');
		
		$('button').click(function(e){
			e.preventDefault();
			
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
					let fileCallPath = encodeURIComponent(attach.uploadPath + '/s_' 
							+ attach.uuid + '_' + attach.fileName);
					
					str += '<li data-path="'+ attach.uploadPath +'" data-uuid="'+ attach.uuid;
					str += '" data-filename="'+ attach.fileName +'" data-type="'+ attach.fileType +'"><div>';
					str += '<span>'+ attach.fileName + '</span>';
					str += '<button type="button" data-file="'+ fileCallPath +'" data-type="image"';
					str += 'class="btn btn-sm btn-danger btn-circle m-2">';
					str += '<i class="bi bi-x"></i></button><br>';
					str += '<img src="/display?fileName='+ fileCallPath +'">';
					str += '</div></li>';
				}else {		
					let fileCallPath = encodeURIComponent(attach.uploadPath + '/' 
							+ attach.uuid + '_' + attach.fileName);
					
					str += '<li data-path="'+ attach.uploadPath +'" data-uuid="'+ attach.uuid;
					str += '" data-filename="'+ attach.fileName +'" data-type="'+ attach.fileType +'"><div>';
					str += '<span>'+ attach.fileName + '</span>';
					str += '<button type="button" data-file="'+ fileCallPath +'" data-type="image"';
					str += 'class="btn btn-sm btn-danger btn-circle m-2">';
					str += '<i class="bi bi-x"></i></button><br>';
					str += '<img src="/resources/img/attach.png">';
					str += '</div></li>';				}
			});
			$('.uploadResult ul').html(str);
		}
	});
	
	// 첨부파일 'x'버튼 클릭시 화면상에서 사라지도록
	$('.uploadResult').on('click', 'button', function(){
		console.log('delete file');
		
		if(confirm('파일을 삭제하시겠습니까?')){
			let targetLi = $(this).closest('li');
			targetLi.remove();
		}
	});
	
	// 파일 업로드 유효성 검사
	//const regex = new RegExp('(.*?)\.(exe|sh|zip|alz)$');
	const regex = new RegExp('(.*?)\.(jpg|jpeg|png|gif)$', 'i');
	const maxSize = 5242880;  // 5MB
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert('파일 사이즈 초과');
			return false;
		}
		
		if(!regex.test(fileName)){
			alert('해당 종류의 파일은 업로드할 수 없습니다.');
			return false;
		}
		
		return true;
	}
	
	// <input type="file">의 내용이 변경되는 것을 감지
	$('input[type="file"]').change(function(e){			
		const formData = new FormData();
		const inputFile = $('input[name="uploadFile"]');
		let files = inputFile[0].files;

		for(let i=0; i<files.length; i++){
			console.log(i)
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append('uploadFile', files[i]);
		}			
		
		$.ajax({
			url: '/uploadAjaxAction',
			type: 'post',
			processData: false,
			contentType: false,
			data: formData,
			dataType: 'json',
			success: function(result){
				console.log(result);
				showUploadResult(result); // 업로드 결과 처리 함수 호출
			}
		});
	});
	
	// 업로드된 결과를 화면에 섬네일 등을 만들어서 처리하는 부분
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0){return;}
		
		const uploadUL = $('.uploadResult ul');
		
		let str = '';
			console.log("uploadResultArr : "+uploadResultArr)
		
		$(uploadResultArr).each(function(i, obj){
			console.log("fileType:" + obj.fileType)
			// image type
			if(obj.fileType){
				let fileCallPath = encodeURIComponent(obj.uploadPath + '/s_' 
						+ obj.uuid + '_' + obj.fileName);
				
				str += '<li data-path="'+ obj.uploadPath +'" data-uuid="'+ obj.uuid;
				str += '" data-filename="'+ obj.fileName +'" data-type="'+ obj.fileType +'"><div>';
				str += '<span>'+ obj.fileName + '</span>';
				str += '<button type="button" data-file="'+ fileCallPath +'" data-type="image"';
				str += 'class="btn btn-sm btn-danger btn-circle m-2">';
				str += '<i class="bi bi-x"></i></button><br>';
				str += '<img src="/display?fileName='+ fileCallPath +'">';
				str += '</div></li>';
			}else {
				let fileCallPath = encodeURIComponent(obj.uploadPath + '/' 
						+ obj.uuid + '_' + obj.fileName);
				let fileLink = fileCallPath.replace(new RegExp(/\\/g), '/');
				
				str += '<li data-path="'+ obj.uploadPath +'" data-uuid="'+ obj.uuid;
				str += '" data-filename="'+ obj.fileName +'" data-type="'+ obj.fileType +'"><div>';
				str += '<span>'+ obj.fileName + '</span>';
				str += '<button type="button" data-file="'+ fileCallPath +'" data-type="file"';
				str += 'class="btn btn-sm btn-danger btn-circle m-2">';
				str += '<i class="bi bi-x"></i></button><br>';
				str += '<img src="/resources/img/attach.png">';
				str += '</div></li>';
			}
		});
		
		uploadUL.append(str);
	}
	
});

</script>
