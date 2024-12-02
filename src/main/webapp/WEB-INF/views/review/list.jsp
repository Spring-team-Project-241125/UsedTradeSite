<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<%@ include file="../includes/header.jsp" %>


 <div class="container py-5">
        <h2 class="py-3">Table</h2>
    
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
                    <th scope="row">${review.rno}</th> <!-- 리뷰 번호 -->
                    <td>${review.pno}</td> <!-- 상품명 -->
                    <td>${review.uno}</td> <!-- 작성자 ID -->
                    <td>${review.r_content}</td> <!-- 리뷰 내용 -->
                    <td><fmt:formatDate value="${review.r_regdate}" pattern="yyyy.MM.dd" /></td> <!-- 작성일 -->
                </tr>
            </c:forEach>
        </tbody>
            
           
        </table>

        <nav class="d-flex justify-content-center mt-5" aria-label="Page navigation">
            <ul class="pagination">
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    
    </div>


<%@ include file="../includes/footer.jsp" %> 