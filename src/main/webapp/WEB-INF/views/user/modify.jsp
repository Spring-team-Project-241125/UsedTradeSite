<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

    <div class="container py-5">
        <h2 class="py-3">내 정보 수정</h2>
        
        <div class="mb-3 col-lg-5">
            <label for="profile" class="form-label">프로필 사진</label>
            <input class="form-control" type="file" id="profile" name="uploadFile">
            <div class="uploadResult mt-3">   	
	            <ul></ul>
            </div>
        </div> 

        <form action="/user/modify" method="post">
            <input type="hidden" name="uno" value="${ vo.uno }">
            
            <div class="mb-3 col-lg-5">   
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId"
                 name="id" value="${ vo.id }" readonly>
            </div>  
            <div class="mb-3 col-lg-5"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="userPwd"
                 name="pwd" value="${ vo.pwd }">
            </div>    
            <div class="mb-3 col-lg-5"> 
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" 
                 name="phone"  value="${ vo.phone }">
            </div>        

            <button type="submit" data-oper="modify" class="btn btn-primary mt-3">회원정보 수정</button>
            <button type="submit" data-oper="remove" class="btn btn-danger mt-3">회원 탈퇴</button>
        </form>
    </div>
        
<%@include file="../includes/footer.jsp" %>

<script>
	$(function(){
		const formObj =$('form');
		
		$('button').click(function(e){
			e.preventDefault();
			
			let operation = $(this).data('oper');
			console.log()
			
			if(operation == 'modify'){
				alert("회원정보가 수정되었습니다.");
				
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

			}else if(operation == 'remove'){
				if(confirm("정말로 회원탈퇴 하시겠습니까?")){					
					formObj.attr('action', '/user/remove');
				}
			}
			
			formObj.submit();
		});
	});
</script>

<script>
$(function(){
	let uno = '<c:out value="${vo.uno}" />';
	
	$.ajax({
		url: '/user/getAttachList',
		method: 'get',
		data: {uno: uno},
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