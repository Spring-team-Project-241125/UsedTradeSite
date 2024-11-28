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
                <tr>
                    <th scope="row">1</th>
                    <td>(새것) 헤어팩 - XXX제품</td>
                    <td>쿨거래맨</td>
                    <td>쿨 거래 감사합니다~</td>
                    <td>2025.01.01</td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>(새것) 헤어팩 - XXX제품</td>
                    <td>쿨거래맨</td>
                    <td>쿨 거래 감사합니다~</td>
                    <td>2025.01.01</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>(새것) 헤어팩 - XXX제품</td>
                    <td>쿨거래맨</td>
                    <td>쿨 거래 감사합니다~</td>
                    <td>2025.01.01</td>
                </tr>
                <tr>
                    <th scope="row">4</th>
                    <td>(새것) 헤어팩 - XXX제품</td>
                    <td>쿨거래맨</td>
                    <td>쿨 거래 감사합니다~</td>
                    <td>2025.01.01</td>
                </tr>
                <tr>
                    <th scope="row">5</th>
                    <td>(새것) 헤어팩 - XXX제품</td>
                    <td>쿨거래맨</td>
                    <td>쿨 거래 감사합니다~</td>
                    <td>2025.01.01</td>
                </tr>
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