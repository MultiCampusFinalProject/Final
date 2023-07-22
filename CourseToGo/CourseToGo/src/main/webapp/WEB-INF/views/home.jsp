<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Course To Go</title>
    <style>
    	    .placeReviewTop3 img,
		    .placeReviewTop3 span {
		        display: inline-block; /* img와 텍스트를 가로로 나란히 배치 */
		        vertical-align: middle; /* 세로 정렬 기준선을 중앙으로 설정 */
		    }
		
		    .placeReviewTop3 span {
		        margin-left: 5px; /* 아이콘과 텍스트 사이에 5px의 여백 추가 */
		    }
		    
       	    .courseReviewTop3 img,
		    .courseReviewTop3 span {
		        display: inline-block; /* img와 텍스트를 가로로 나란히 배치 */
		        vertical-align: middle; /* 세로 정렬 기준선을 중앙으로 설정 */
		    }
		
		    .courseReviewTop3 span {
		        margin-left: 5px; /* 아이콘과 텍스트 사이에 5px의 여백 추가 */
		    }
		    #on {
	background-color: #daeefe;
}

    </style>
    	<link rel="stylesheet" href="css/sidebar.css">   
</head>
<body>

	<!-- 사이드바 -->
	<form action="/home" method="GET" name="sidebarForm" id="sidebarForm">
		<div class="sidebar">
		    <div class="logo">Course To Go</div>
		    <ul>
		    	<li><input type="button" class="home" value="홈" id="on" onclick="location.href='/home'"></li>
	       		<li><input type="button" class="course" value="코스" onclick="location.href='/courseListWithPagination'"></li>
	    		<li><input type="button" class="create-course" value="코스 제작"  onclick="location.href='/naverMap'"></li>
       			<li><input type="button" class="mypage" value="마이페이지" onclick="location.href='/userContents'"></li>
		    	<c:if test="${not empty sessionScope.user.userId}">
		    		<li class="profile"><img src="${sessionScope.user.userPhoto}" alt="프로필 사진"></li>
			        <li class="name">${sessionScope.user.userNickname} 님</li>
			        <li><input type="button" class="logout-btn" value="로그아웃" onclick="location.href='/logout'"></li>
			        <li><input type="button" class="edit-profile-btn" value="개인정보 수정" onclick="location.href='/myPageInformModify'" ></li>
		    	</c:if>
		    </ul>
		</div>
	</form>
    <!-- 랭킹 -->
    <div style="display: flex;
    			margin-left: 250px;">
    			
	    <div class = "courseMakeKing"
	    	 style = "background-color: #DAF3FD;
	    			  margin-top:50px;
	    			  width: 200px;
	    			  border-radius: 5px;
	    			  border: 2px solid #85C6E2;
	    			  text-align: center;">
	    	<b>코스 작성 TOP3</b><br>
				<div class="courseReviewTop3">
				    <c:forEach items="${requestScope.courseMakeKingUserIds}" var="userId" varStatus="kingSt">
				        <c:choose>
				            <c:when test="${kingSt.index == 0}">
				                <img src="/images/goldMedal.png" alt="gold">
				            </c:when>
				            <c:when test="${kingSt.index == 1}">
				                <img src="/images/silverMedal.png" alt="silver">
				            </c:when>
				            <c:when test="${kingSt.index == 2}">
				                <img src="/images/bronzeMedal.png" alt="bronze">
				            </c:when>
				        </c:choose>
				        <span>
				            <c:forEach items="${requestScope.courseMakeKingUserNicknames}" var="courseKingNick" varStatus="courseKingNickSt">
				                <c:if test="${kingSt.index eq courseKingNickSt.index}">
				                    ${courseKingNick}
				                </c:if>
				            </c:forEach>
				        </span>
				        <br>
				    </c:forEach>
				</div>
	    </div>

	    <div class = "courseReveiwKing"
    		 style = "background-color: #DAF3FD;
	    			  margin-top:50px;
	    			  width: 200px;
	    			  border-radius: 5px;
	    			  border: 2px solid #85C6E2;
	    			  text-align: center;
	    			  margin-left:50px;">
	    	<b>코스 리뷰 TOP3</b><br>
				<div class="courseReviewTop3">
				    <c:forEach items="${requestScope.courseReviewKingUserIds}" var="userId" varStatus="kingSt">
				        <c:choose>
				            <c:when test="${kingSt.index == 0}">
				                <img src="/images/goldMedal.png" alt="gold">
				            </c:when>
				            <c:when test="${kingSt.index == 1}">
				                <img src="/images/silverMedal.png" alt="silver">
				            </c:when>
				            <c:when test="${kingSt.index == 2}">
				                <img src="/images/bronzeMedal.png" alt="bronze">
				            </c:when>
				        </c:choose>
				        <span>
				            <c:forEach items="${requestScope.courseReviewKingUserNicknames}" var="courseKingNick" varStatus="courseKingNickSt">
				                <c:if test="${kingSt.index eq courseKingNickSt.index}">
				                    ${courseKingNick}
				                </c:if>
				            </c:forEach>
				        </span>
				        <br>
				    </c:forEach>
				</div>
	    </div>	    
	    
	    <div class = "placeReveiwKing" 
	    	 style = "background-color: #DAF3FD;
	    			  margin-top:50px;
	    			  width: 200px;
	    			  border-radius: 5px;
	    			  border: 2px solid #85C6E2;
	    			  text-align: center;
	    			  margin-left:50px;">
	    	<b>장소 리뷰 TOP3</b><br>
				<div class="placeReviewTop3">
				    <c:forEach items="${requestScope.placeReviewKingUserIds}" var="userId" varStatus="kingSt">
				        <c:choose>
				            <c:when test="${kingSt.index == 0}">
				                <img src="/images/goldMedal.png" alt="gold">
				            </c:when>
				            <c:when test="${kingSt.index == 1}">
				                <img src="/images/silverMedal.png" alt="silver">
				            </c:when>
				            <c:when test="${kingSt.index == 2}">
				                <img src="/images/bronzeMedal.png" alt="bronze">
				            </c:when>
				        </c:choose>
				        <span>
				            <c:forEach items="${requestScope.placeReviewKingUserNicknames}" var="placeKingNick" varStatus="placeKingNickSt">
				                <c:if test="${kingSt.index eq placeKingNickSt.index}">
				                    ${placeKingNick}
				                </c:if>
				            </c:forEach>
				        </span>
				        <br>
				    </c:forEach>
				</div>
	    </div>
    </div>
    <div class="container">
        <!-- 사이드바 -->
        <div class="sidebar">
            <%@ include file="sidebar.jsp" %>
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