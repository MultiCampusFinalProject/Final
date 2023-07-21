<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/sidebar.css">
</head>
<body>
	<form action="/home" method="GET" name="sidebarForm" id="sidebarForm">
		<div class="sidebar">
		    <div class="logo">Course To Go</div>
		    <ul>
		    	<li><input type="button" class="home" value="홈" onclick="location.href='/home'" id="homebtn"></li>
		    	<li><input type="button" class="course" value="코스" onclick="location.href='/courseListWithPagination'" id="coursebtn"></li>
		    	<c:if test="${empty sessionScope.user.userId}">
		    		<li><input type="button" class="create-course" value="코스 제작" onclick="notLogin()"></li>
		    		<li><input type="button" class="mypage" value="마이페이지" onclick="location.href='/userContents'" id="mypagebtb"></li>
		    	</c:if>
		    	
		    	<c:if test="${not empty sessionScope.user.userId}">
		    		<li><input type="button" class="create-course" value="코스 제작" onclick="location.href='/courseMake'" id="createbtn"></li>
		    		<li><input type="button" class="mypage" value="마이페이지" onclick="location.href='/userContents'" id="mypagebtn"></li>
		    		<li class="profile"><img src="${sessionScope.user.userPhoto}" alt="프로필 사진"></li>
			        <li class="name">${sessionScope.user.userNickname} 님</li>
			        <li><input type="button" class="logout-btn" value="로그아웃" onclick="location.href='/logout'"></li>
			        <li><input type="button" class="edit-profile-btn" value="개인정보 수정" onclick="location.href='/myPageInformModify'" id="informbtn"></li>
		    	</c:if>
		    </ul>
		</div>
	</form>
	
	<script>
		function notLogin() {
		  alert("로그인을 해주세요.");
		}
		
		// 버튼 클릭 시 해당 버튼 focus 적용
 		var currentUrl = window.location.href;;
		
		var homebtn = '/home';
		var coursebtn = '/courseListWithPagination';
		var createbtn = '/naverMap';
		var mypagebtn = '/userContents';
		var informbtn = '/myPageInformModify';
		
		function setFocusOnButton(buttonId) {
	        var button = document.getElementById(buttonId);
	        button.focus();
	    }
		
		if(currentUrl.includes(homebtn)) {
			setFocusOnButton('homebtn');
		} else if(currentUrl.includes(coursebtn)) {
			setFocusOnButton('coursebtn');
		} else if(currentUrl.includes(createbtn)) {
			setFocusOnButton('createbtn');
		} else if(currentUrl.includes(mypagebtn)) {
			setFocusOnButton('mypagebtn');
		} else if(currentUrl.includes(informbtn)) {
			setFocusOnButton('informbtn');
		}
		

	</script>
</body>
</html>