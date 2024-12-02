<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

    <div class="container py-5">
        <h2 class="py-3">회원 가입</h2>

        <form action="/user/register" method="post">
        	
            <div class="mb-3 col-lg-5">
                <label for="profile" class="form-label">프로필 사진</label>
                <input class="form-control" type="file" id="profile" name="u_img_name">
            </div> 
            <div class="mb-3 col-lg-5">   
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId" name="id" placeholder="아이디를 입력해주세요">
                <button type="button" class="btn btn-secondary mt-2" id="checkIdBtn">중복 확인</button>
            </div>  
            <div class="mb-3 col-lg-5"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="userPwd" name="pwd" placeholder="비밀번호를 입력해주세요">
            </div>
            <div class="mb-3 col-lg-5"> 
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="전화번호를 입력해주세요">
            </div>

            <button type="submit" class="btn btn-primary mt-3" 
            	data-bs-toggle="modal" data-bs-target="#registerModal">회원가입</button>
        </form>

    </div>
    
    <!-- modal start -->
	<div id="registerModal" class="modal fade" tabindex="-1" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">회원 가입</h5>
	      </div>
	      <div class="modal-body">
	        <p>회원 등록이 완료되었습니다.<br>로그인 후 이용해주세요~</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- modal end -->
    

<%@include file="../includes/footer.jsp" %>

<script>
	$(function(){
		const checkIdModel = $('#chekcIdModal')
		
		$('#checkIdBtn').click(function(){
			const id = $('#userId').val();
			
			if(!id){
				alert("아이디를 입력해주세요.");
				return;
			}
			
			$.ajax({
				url: '/user/check-id',
				type: 'get',
				data: {id: id},
				success: function(response){
					alert(response.msg);					
				},
				error: function(){
					console.log("ajax error");
				}
			});
		});
		
		const formObj = $('form');
		
		$('button[type="submit"]').click(function(e){
			e.preventDefault();
			
			alert("회원에 가입되었습니다.\n로그인후 이용해주세요~");
			formObj.submit();
		});
		
		// 파일 업로드 유효성 검사
		const regex = new RegExp('(.*?)\.(exe|sh|zip|alz)$');
		const maxSize = 5242880;  // 5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert('파일 사이즈 초과');
				return false;
			}
			
			if(regex.test(fileName)){
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
			
			for(let i=0; i<files.lenght; i++){
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
			
			$(uploadResultArr).each(function(i, obj){
				// image type
				if(obj.image){
					
				}else {
					
				}
			});
			
			uploadUL.append(str);
		}

	});
</script>