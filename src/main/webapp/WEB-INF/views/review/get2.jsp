<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="container py-5">
    <h2 class="py-3">리뷰 상세보기</h2>

    <!-- 리뷰 상세 폼 -->
    <form role="form" action="/review/update" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="rno" class="form-label">리뷰 번호</label>
            <input type="text" id="rno" name="rno" value="${review.rno}" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="pno" class="form-label">상품 번호</label>
            <input type="text" id="pno" name="pno" value="${review.pno}" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="uno" class="form-label">작성자 ID</label>
            <input type="text" id="uno" name="uno" value="${review.uno}" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="r_content" class="form-label">리뷰 내용</label>
            <textarea class="form-control" id="r_content" name="r_content" readonly style="height: 100px;">${review.r_content}</textarea>
        </div>

       

        <!-- 리뷰 등록 후 수정할 수 없도록 readonly를 추가했습니다 -->
        <div class="mb-3">
            <label for="r_regdate" class="form-label">작성일</label>
            <input type="text" id="r_regdate" name="r_regdate" value="<fmt:formatDate value='${review.r_regdate}' pattern='yyyy.MM.dd'/>" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label for="r_updatedate" class="form-label">수정일</label>
            <input type="text" id="r_updatedate" name="r_updatedate" value="<fmt:formatDate value='${review.r_updatedate}' pattern='yyyy.MM.dd'/>" readonly class="form-control">
        </div>

        <button type="submit" class="btn btn-primary mt-3" disabled>리뷰 수정 불가</button>
    </form>

</div>

<%@ include file="../includes/footer.jsp" %>
