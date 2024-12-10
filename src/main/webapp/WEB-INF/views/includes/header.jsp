<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
 
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고 거래 사이트</title>

    <!-- bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- WEB Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<!-- Link Swiper's CSS -->
 	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <style>
        
        a {
        	text-decoration: none;
        	color: #333;
        }

        .fs-sm {
            font-size: 12px;
            margin-bottom: 0.3rem;
            color: #999;
        }
        

		ul, li {
			list-style: none;
			padding: 0;
		}
		
		.uploadResult ul li {		   
		   padding: 10px;
		   display: inline-block;
		}
		
		.uploadResult ul li img {
		   width: 100%;
		}

		
		
		
    html,body {
      position: relative;
      height: 100%;
    }

    body {
      font-family: "Noto Sans KR", sans-serif;
      font-size: 14px;
      color: #000;
      margin: 0;
      padding: 0;
    }

    .swiper {
      width: 100%;
      height: 100%;
    }

    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .swiper-slide img {
      display: block;
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    </style>
</head>

<body>
    <header>
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="/product/list">아나바다</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="/product/list">상품</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/review/list">리뷰</a>
                        </li>
                    </ul>
                    <div class="d-flex">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        
                        <sec:authorize access="isAuthenticated()">
                            <li class="nav-item">
                                <a class="nav-link" href="/user/store">내상점</a>
                            </li>
                            <form action="/customLogout" method="post" style="display: inline; margin-top: 8px;">
   							 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    							<button type="submit" class="btn btn-link nav-link" style="padding: 0; border: none; background: none;">
       										 로그아웃
   					 			</button>
							</form>
                        </sec:authorize>  
                          
                        <sec:authorize access="isAnonymous()">
                        	<c:out value="${ pinfo.username }"></c:out>
                            <li class="nav-item">
                                <a class="nav-link" href="/user/register">회원가입</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/customLogin">로그인</a>
                            </li>
                        </sec:authorize>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </header>