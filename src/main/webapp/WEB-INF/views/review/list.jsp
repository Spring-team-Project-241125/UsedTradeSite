<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>




<div class="container py-5">
	<h2 class="py-3">리뷰 목록</h2>

        
        <div class="d-flex justify-content-end">
            <a href="register" class="btn btn-primary mb-3">리뷰등록</a>
      </div>
	


	<!-- 메시지가 있을 경우 alert로 표시 -->
	<c:if test="${not empty message}">
		<script type="text/javascript">
			alert("${message}");
		</script>
	</c:if>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">상품명</th>
				<th scope="col">작성자ID</th>
				<th scope="col">내용</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>

		<tbody>
			<!-- 모델에서 전달된 리뷰 목록을 반복하여 표시 -->
			<c:forEach var="review" items="${list}">
				<tr>
					<td><a href="/review/get?rno=${review.rno}">${review.rno}</a></td>
				    <td><a href="/review/get?rno=${review.rno}">${review.p_title}</a></td>
				    <td><a href="/review/get?rno=${review.rno}">${review.buyerId}</a></td>
				    <td><a href="/review/get?rno=${review.rno}">${review.r_content}</a></td>
				    <td><a href="/review/get?rno=${review.rno}"><fmt:formatDate value="${review.r_regdate}" pattern="yyyy.MM.dd" /></a></td>
					<!-- 작성일 -->
					
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<nav class="d-flex justify-content-center mt-5"
		aria-label="Page navigation">
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="#"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
			<li class="page-item active"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</ul>
	</nav>



</div>


<%@ include file="../includes/footer.jsp"%>
