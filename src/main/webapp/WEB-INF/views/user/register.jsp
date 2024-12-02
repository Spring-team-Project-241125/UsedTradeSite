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
		
		$('button[type="submit"]').click(function(e){
			e.preventDefault();
			
			alert("회원에 가입되었습니다.\n로그인후 이용해주세요~");
			$('form').submit();
		});
	});
</script>