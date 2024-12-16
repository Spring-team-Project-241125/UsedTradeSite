<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="includes/header.jsp" %>

    <div class="container py-5 col-lg-4">
        <h2 class="py-3 text-center">로그인</h2>
        <h2><c:out value="${error }"/></h2>
		<h2><c:out value="${logout }"/></h2>

        <form method="post" action="/login" >
            <div class="mb-3">   
                <label for="userId" class="form-label">아이디</label>
                <input type="text" name='username' class="form-control" id="id" placeholder="아이디를 입력해주세요">
            </div>  
            <div class="mb-3"> 
                <label for="userPwd" class="form-label">비밀번호</label>
                <input type="password" name='password' class="form-control" id="pwd" placeholder="비밀번호를 입력해주세요">
            </div>

            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-primary mt-3" id="loginBtn">로그인</button>
            </div>  
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
            
        </form>

    </div>

<%@include file="includes/footer.jsp" %>

<script>
   $(function(){
      $('#loginBtn').click(function(e){
         e.preventDefault();
         
         if($('#id').val() == ''){
            alert('아이디를 입력하세요.');
         }else if($('#pwd').val() == ''){
            alert('비밀번호를 입력하세요.');
         }else {
            $('form').submit();
         }
      });      
   });
</script>