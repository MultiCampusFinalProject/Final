<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Course To Go / My Page</title>

	<style>
	
		.button {
			  color: black;
			  font-weight: bold;
			  padding: 10px;
			  border-radius: 10px;
			  text-align: center;
			  background-color: #fff;
			  width: 170px;	
		}
		
	</style>	
	
</head>
<body>
	<!-- 사이드바 -->
	<div class = "sidebar">
		<%@ include file = "sidebar.jsp" %>
	</div>
	<!-- 배너 -->	
	<div class = "banner" style = "margin-left: 200px;">
		<img src="https://github.com/Paprika0290/Paprika0290/assets/59499235/3e6dcc8a-648e-4727-8474-1aee71a99cb4">
	</div>
	<!-- 로그인/회원정보 -->
	<div class = "loginAndSignup">
		<%@ include file="loginbtn.jsp" %>
	</div>
	<br><br>
	<!-- 버튼 박스 -->	
	<div class = "buttonContainer"
		 style = "margin-left: 200px;
		 		  display: flex;
		 		  justify-content: space-between;" >
		<button class="button" style="margin-left:10%;" onclick="changeContent('/userCourse')" >나의 코스</button>
		<button class="button" onclick="changeContent('/userReview')">나의 리뷰</button>
		<button class="button" style="margin-right:10%;" onclick="changeContent('/userBookmarkList')" >내가 찜한 코스</button>
	</div>
	<br>
	
	
	
	<!-- 메인 컨텐츠 박스 -->
	<div class = "contentsBox"
		 style = "margin-left: calc(5vw + 200px);
		 		  margin-right: 5vw;
		 		  height: calc(90vh - 200px);
		 		  border-radius: 10px;
		 		  border: 2px solid #ccc;
				  display: flex;
	  			  flex-direction: column;
				  justify-content: left;
				  overflow: auto;">
				  
		<%@ include file="userCourseList.jsp" %>

	</div>
	
		<script>
		function changeContent(page) {
			  var contentsBox = document.querySelector('.contentsBox');
	
			  // AJAX를 사용하여 JSP 파일의 내용을 가져옴
			  var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState === 4 && this.status === 200) {
			      contentsBox.innerHTML = this.responseText;
			    }
			  };
	
			  // 요청 보내기
			  xhttp.open('GET', page, true);
			  xhttp.send();
			}
	</script>

	



</body>
</html>