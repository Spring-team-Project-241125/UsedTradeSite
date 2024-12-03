<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

	<div class="container py-5">
        <h2 class="py-3">내 정보</h2>

        <form>
            <div class="mb-3 col-lg-5">
            	<div class="uploadResult">   	
	                <ul></ul>
            	</div>
            </div> 
            <div class="mb-3 col-lg-5">   
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId"
                 name="id" value="${ vo.id }" readonly>
            </div>  
            <div class="mb-3 col-lg-5"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="userPwd"
                 name="pwd" value="${ vo.pwd }" readonly>
            </div>
            <div class="mb-3 col-lg-5"> 
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" 
                 name="phone"  value="${ vo.phone }">
            </div>

            <button type="button" class="btn btn-primary mt-3" 
            onclick="location.href='/user/modify?uno=${vo.uno}'">회원정보 수정</button>
        </form>
    </div>

<%@include file="../includes/footer.jsp" %>

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