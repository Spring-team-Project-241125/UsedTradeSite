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

<nav class="d-flex justify-content-center mt-5" aria-label="Page navigation">
    <ul class="pagination">
        <!-- Previous Button -->
        <c:if test="${pageMaker.prev}">
            <li class="page-item">
                <a class="page-link" href="/review/list?pagenum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}
                    <c:if test="${not empty pageMaker.cri.type}"> &type=${pageMaker.cri.type}</c:if>
                    <c:if test="${not empty pageMaker.cri.keyword}"> &keyword=${pageMaker.cri.keyword}</c:if>"
                    aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
        </c:if>

        <!-- Page Numbers -->
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="page-item ${pageMaker.cri.pagenum == num ? 'active' : ''}">
                <a class="page-link" href="/review/list?pagenum=${num}&amount=${pageMaker.cri.amount}
                    <c:if test="${not empty pageMaker.cri.type}"> &type=${pageMaker.cri.type}</c:if>
                    <c:if test="${not empty pageMaker.cri.keyword}"> &keyword=${pageMaker.cri.keyword}</c:if>">${num}</a>
            </li>
        </c:forEach>

        <!-- Next Button -->
        <c:if test="${pageMaker.next}">
            <li class="page-item">
                <a class="page-link" href="/review/list?pagenum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}
                    <c:if test="${not empty pageMaker.cri.type}"> &type=${pageMaker.cri.type}</c:if>
                    <c:if test="${not empty pageMaker.cri.keyword}"> &keyword=${pageMaker.cri.keyword}</c:if>" 
                    aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<!-- Hidden Form for Pagination -->
<form id="actionForm" action="/review/list" method="get">
    <input type="hidden" name="pagenum" value="${pageMaker.cri.pagenum}">
    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    <c:if test="${not empty pageMaker.cri.type}">
        <input type="hidden" name="type" value="${pageMaker.cri.type}">
    </c:if>
    <c:if test="${not empty pageMaker.cri.keyword}">
        <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
    </c:if>
</form>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 페이지 번호 링크들을 가져옵니다.
        const paginationLinks = document.querySelectorAll(".pagination a");
        const actionForm = document.getElementById("actionForm");

        paginationLinks.forEach(function(link) {
            link.addEventListener("click", function(e) {
                e.preventDefault();  // 기본 링크 동작 방지

                // href 속성에서 pagenum= 값을 추출 (예: list?pagenum=2)
                const url = link.getAttribute("href");
                const pageNumMatch = url.match(/pagenum=(\d+)/);  // pagenum=뒤의 숫자를 추출

                if (pageNumMatch) {
                    const pageNum = pageNumMatch[1];  // 추출한 페이지 번호
                    const pageInput = actionForm.querySelector("input[name='pagenum']");
                    pageInput.value = pageNum;  // 페이지 번호를 input에 설정
                    actionForm.submit();  // 폼 제출
                }
            });
        });
    });
</script>


 
                <!-- 검색 조건 시작 -->
                <div class="row">
    <div class="col-lg-12 d-flex justify-content-center">
        <form action="/review/list" method="get" id="searchForm">
            <select name="type">
                <option value="" ${pageMaker.cri.type == null ? 'selected' : ''}>--</option>
                <option value="T" ${pageMaker.cri.type == 'T' ? 'selected' : ''}>상품명</option>
                <option value="C" ${pageMaker.cri.type == 'C' ? 'selected' : ''}>작성자</option>
                <option value="W" ${pageMaker.cri.type == 'W' ? 'selected' : ''}>내용</option>
                <option value="TC" ${pageMaker.cri.type == 'TC' ? 'selected' : ''}>상품명 또는 작성자</option>
                <option value="TW" ${pageMaker.cri.type == 'TW' ? 'selected' : ''}>상품명 또는 내용</option>
                <option value="TCW" ${pageMaker.cri.type == 'TCW' ? 'selected' : ''}>상품명, 작성자, 내용</option>
            </select>
            <input type="text" name="keyword" value="${pageMaker.cri.keyword}">
            <input type="hidden" name="pagenum" value="1">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <button class="btn btn-default">Search</button>
        </form>
    </div>
</div>



<%@ include file="../includes/footer.jsp"%>