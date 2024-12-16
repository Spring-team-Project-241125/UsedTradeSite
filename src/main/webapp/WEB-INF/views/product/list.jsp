<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

<style>
    .pagination {
        margin: 0;
    }

    .pagination .page-item {
        margin: 0 5px; /* 각 페이지 번호 사이에 간격을 추가 */
    }

    .pagination .page-link {
        border-radius: 5px; /* 버튼에 둥근 테두리 추가 */
        padding: 10px 15px; /* 버튼 크기 조정 */
    }

    .pagination .active .page-link {
        background-color: #007bff; /* 활성화된 페이지 번호 색상 */
        color: white; /* 텍스트 색상 */
    }

    .pagination .page-link:hover {
        background-color: #f8f9fa; /* 호버 시 배경 색상 변경 */
    }

    .pagination .page-item:first-child .page-link,
    .pagination .page-item:last-child .page-link {
        padding: 10px 15px; /* 첫 번째와 마지막 페이지 버튼에 패딩 */
    }
</style>

    <div class="container py-5">
        <h2 class="py-3">상품 목록</h2>
        <div class="d-flex justify-content-end">
        <a href="/product/register" class="btn btn-primary mb-3">상품등록</a>
		</div>
        <div class="container">
    <div class="row">
        <c:forEach items="${productList}" var="product">
            <div class="col-lg-3 col-sm-6 product-container" data-pno="${product.pno}">
            <a href="/product/get?pno=${product.pno}">
                <div class="uploadResult">   	
	                <ul></ul>
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
                             		value='<c:out value="${pageMaker.cri.keyword }"/>'/>
                             		 <input type='hidden' name='pagenum' value='1'/>
                             		<input type='hidden' name='amount' 
                             		value='<c:out value="${pageMaker.cri.amount }"/>'/>
                             		<button class='btn btn-default'>Search</button>
                             	</form>
                             	</div>
                             </div>
                             <!-- 검색창 끝 -->


<!-- 페이징처리 시작 -->
<nav class="d-flex justify-content-center mt-5" aria-label="Page navigation">
    <ul class="pagination pagination-sm">
    
    
        <!-- 이전 페이지 및 처음페이지 -->
        <c:if test="${pageMaker.prev}">
        
        <li class="paginate_button first">
                <a href="/product/list?pagenum=1&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}" class="page-link">First</a>
            </li>
        
        
            <li class="paginate_button previous">
                <a href="/product/list?pagenum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}" class="page-link">Previous</a>
            </li>
        </c:if>

        <!-- 페이지 번호들 -->
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="paginate_button ${pageMaker.cri.pagenum == num ? 'active' : ''}">
                <a href="/product/list?pagenum=${num}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}" class="page-link">${num}</a>
            </li>
        </c:forEach>

        <!-- 다음 페이지 및 마지막페이지 -->
        <c:if test="${pageMaker.next}">
        
            <li class="paginate_button next">
                <a href="/product/list?pagenum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}" class="page-link">Next</a>
            </li>
            
               <li class="paginate_button last">
            <a href="/product/list?pagenum=${pageMaker.totalPage}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}" class="page-link">Last</a>
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

<!-- 수정 완료 모달 시작 -->
<div class="modal fade" id="modifySuccessModal" tabindex="-1" aria-labelledby="modifySuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modifySuccessModalLabel">수정 완료</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                게시글이 성공적으로 수정되었습니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- 수정 완료 모달 끝 -->

<%@include file="../includes/footer.jsp" %>

<script>
$(function () {
    // 상품별로 AJAX 호출
    $('.product-container').each(function () {
        let container = $(this); // 현재 상품 컨테이너
        let pno = container.data('pno'); // data-pno에서 pno 값 추출

        // AJAX 요청
        $.ajax({
            url: '/product/getAttachList',
            method: 'get',
            data: { pno: pno },
            dataType: 'json',
            success: function (result) {
                console.log("pno:", pno, "result:", result);

                let str = '';
                
                	 let fileCallPath = encodeURIComponent(
                			 result[0].uploadPath + '/' + result[0].uuid + '_' + result[0].fileName
                         );
                         str += '<li data-path="' + result[0].uploadPath + '" data-uuid="' + result[0].uuid;
                         str += '" data-filename="' + result[0].fileName + '" data-type="' + result[0].fileType + '">';
                         str += '<img src="/display?fileName=' + fileCallPath + '">';
                         str += '</li>';
               

                // 현재 상품의 uploadResult에 결과 추가
                container.find('.uploadResult ul').html(str);
            }
        });
    });
});
</script>

<script>
    $(document).ready(function(){
        // result 값을 JavaScript 변수로 전달
        var result = "${result}";

        // 삭제 후 result 값이 'removesuccess'일 때 삭제 완료 모달 띄우기
        if(result === 'removesuccess'){
            $('#deleteSuccessModal').modal('show');
        }

        // 수정 후 result 값이 'modifysuccess'일 때 수정 완료 모달 띄우기
        if(result === 'modifysuccess'){
            $('#modifySuccessModal').modal('show');
        }
    });
</script>
