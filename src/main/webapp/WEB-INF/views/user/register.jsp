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
                <input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력해주세요">
                <button type="button" class="btn btn-secondary mt-2" id="checkIdBtn">중복 확인</button>
            </div>  
            <div class="mb-3 col-lg-5"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요">
            </div>

            <button type="submit" class="btn btn-primary mt-3">회원가입</button>
        </form>

    </div>

<%@include file="../includes/footer.jsp" %>

<script>
	$(function(){
		$('#checkIdBtn').click(function(){
			const id = $('#id').val();
			
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
	});
</script>