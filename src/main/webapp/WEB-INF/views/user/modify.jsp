<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

    <div class="container py-5">
        <h2 class="py-3">내 정보 수정</h2>

        <form action="/uploadFormAction" method="post" enctype="myltipart/form-data">
            <div class="mb-3 col-lg-5">
                <label for="profile" class="form-label">프로필 사진</label>
                <input class="form-control" type="file" id="profile" name="u_img_name">
            </div> 
        </form>
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
			}else if(operation == 'remove'){
				if(confirm("정말로 회원탈퇴 하시겠습니까?")){					
					formObj.attr('action', '/user/remove');
				}
			}
			
			formObj.submit();
		});
	});
</script>