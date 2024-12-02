<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>


    <div class="container py-5">
        <h2 class="py-3">상품 목록</h2>
        <div class="d-flex justify-content-end">
        	 <a href="register" class="btn btn-primary mb-3">상품등록</a>
		</div>
        <div class="container">
    <div class="row">
        <c:forEach items="${productList}" var="product">
            <div class="col-lg-3 col-sm-6">
                <div class="pimg">
                <a href="/product/get?pno=${product.pno}">
                    <img src="https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?q=80&w=1353&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                     alt="${product.p_title}" width="100%">
                     </a>
                </div>
                <div class="pcontent pt-3">
                <a href="/product/get?pno=${product.pno}">
                    <h3>${product.p_title}</h3>
                    <p class="text-end"><fmt:formatNumber value="${product.p_price}" pattern="#,###" />
    원</p>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 검색창 시작 -->
 <div class='row'>
                             	 <div class="col-lg-12 d-flex justify-content-center">
                             	<form id='searchForm' action="/product/list" method='get'>
                             		<select name='type'>
                             			<option value=""
                             				<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
                             				<option value="T"
                             				<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
                             				<option value="C"
                             				<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
                             				<option value="W"
                             				<c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
                             				<option value="TC"
                             				<c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
                             				<option value="TW"
                             				<c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자</option>
                             				<option value="TWC"
                             				<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
                             		</select>
                             		<input type='text' name='keyword' 
                             		value='<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>'/>
                             		<input type='hidden' name='pagenum' 
                             		value='<c:out value="${pageMaker.cri.pagenum }"/>'/>
                             		<input type='hidden' name='amount' 
                             		value='<c:out value="${pageMaker.cri.amount }"/>'/>
                             		<button class='btn btn-default'>Search</button>
                             	</form>
                             	</div>
                             </div>
                             <!-- 검색창 끝 -->


<!-- 페이징처리 시작 -->
        <nav class="d-flex justify-content-center mt-5" aria-label="Page navigation">
            <ul class="pagination">
    
    <c:if test="${pageMaker.prev }">
    	<li class="paginate_button previous">
    	<a href="${pageMaker.startPage-1 }">Previous</a>
    	</li>
    </c:if>
    
    <c:forEach var="num" begin="${pageMaker.startPage }"
    end="${pageMaker.endPage }">
    <li class="paginate_button ${pageMaker.cri.pagenum == num ? "active":""} ">
    <a href="${num} ">${num }</a>
    </li>
    </c:forEach>
    
    <c:if test="${pageMaker.next }">
    	<li class="paginate_button next">
    	<a href="${pageMaker.endPage+1 }">Next</a>
    	</li>
    </c:if>
    </ul>
        </nav>
        <!-- 페이징처리 끝 -->
        
        <form id='actionForm' action="/product/list" method='get'>
	<input type='hidden' name='pagenum' value = '${pageMaker.cri.pagenum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value = '<c:out value="${pageMaker.cri.type }"/>'>
	<input type='hidden' name='keyword' value = '<c:out value="${pageMaker.cri.keyword }"/>'>
</form>

    </div>
    
    <!-- 삭제 완료 모달 시작 -->
<div class="modal fade" id="deleteSuccessModal" tabindex="-1" aria-labelledby="deleteSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteSuccessModalLabel">삭제 완료</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                게시글이 성공적으로 삭제되었습니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- 삭제 완료 모달 끝 -->


<%@include file="../includes/footer.jsp" %>

<script>
    $(document).ready(function(){
        // 삭제 후 'result' 값이 'success'일 때 삭제 완료 모달 띄우기
        <c:if test="${not empty result && result == 'success'}">
            $('#deleteSuccessModal').modal('show');
        </c:if>
    });
</script>