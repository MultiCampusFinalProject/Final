<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/myPageInform.css">
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class="signupDone">
		<br><br><br><br><br><br><br><br><br>
		<img src="https://cdn-icons-png.flaticon.com/512/4550/4550058.png" height = "80px">
		<h3>${sessionScope.userName} 님의 가입이 완료되었습니다.</h3>
		<p>이제 즐거운 여행을 위한 Course를 직접 만들어보실 수 있습니다.</p>
		<p>감사합니다.	</p>
		<input class="button" type="button" value="시작하기!" onclick="location.href='/home'">
	</div>
</body>
</html>