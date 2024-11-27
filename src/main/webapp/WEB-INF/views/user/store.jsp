<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp" %>

    <div class="container py-5">
        <h2 class="py-3">내 상점</h2>

        <div class="row">
            <div class="col-lg-2">
                <img src="/resources/img/unknown.jpg" alt="user" width="100px">
            </div>
            <div class="col-lg-10">
                <h3 class="pb-2">ID : ${ vo.id }</h3>
                

            </div>
        </div>

        <nav class="pt-5"></nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="nav-sale-tab" data-bs-toggle="tab" data-bs-target="#nav-sale"
                    type="button" role="tab" aria-controls="nav-sale" aria-selected="true">판매내역</button>
                <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-purchase"
                    type="button" role="tab" aria-controls="nav-purchase" aria-selected="false">구매내역</button>
                <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-reviews"
                    type="button" role="tab" aria-controls="nav-reviews" aria-selected="false">리뷰정보</button>
            </div>
        </nav>
        <div class="tab-content py-3" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-sale" role="tabpanel" aria-labelledby="nav-sale-tab"
                tabindex="0">나의 판매내역 리스트</div>
            <div class="tab-pane fade" id="nav-purchase" role="tabpanel" aria-labelledby="nav-purchase-tab" tabindex="0">
                나의 구매내역 리스트</div>
            <div class="tab-pane fade" id="nav-reviews" role="tabpanel" aria-labelledby="nav-reviews-tab" tabindex="0">
                나의 리뷰 리스트</div>
        </div>
    </div>

<%@include file="../includes/footer.jsp" %>