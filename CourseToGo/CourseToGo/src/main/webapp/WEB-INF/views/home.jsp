<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Course To Go</title>
</head>
<body>
    <div class="container">
        <!-- 사이드바 -->
        <div class="sidebar">
            <%@ include file="sidebar.jsp" %>
        </div>
        <!-- 메인 상단부(검색바 + 로그인버튼 + 회원가입 버튼) // class 및 include file(jsp) 변경-->
        <div class="searchbar">
            <%@ include file="search.jsp" %>
        </div>
        <div class="loginAndSignup">
            <%@ include file="loginbtn.jsp" %>
        </div>
        <!-- 메인 중단부(광고 및 이벤트 배너) -->
        <div class="banner">
        	<%@ include file="banner.jsp" %>
        </div>
        <!-- 메인 하단부(추천 코스 리스트) -->
        <div class="recommendCourse">
        	<%@ include file="recommendCourse.jsp" %>
        </div>
        <!-- 메인 중단부(추천 장소 리스트) -->
        <div class="recommendPlace">
        	<%@ include file="recommendPlace.jsp" %>
        </div>
    </div>
</body>
</html>