<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인 정보 수정</title>
	<link rel="stylesheet" href="css/myPageInform.css">
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	
	<form action="/signupDone" method="POST">
		<div class="myPageInform">
			<table>
				<tr>
					<td style="width: 400px;">
						<div align="center" class="left-column" width="500px">
							<h1>프로필</h1>
							<img src="https://github.com/S2ll/S2ll/blob/main/userProfile1.png?raw=true" alt="profileImage" width="80" height="80" >
							<p><h3>${sessionScope.newUser.userName}</h3></p>
							<p><h4 style="color: grey;">${sessionScope.newUser.userEmail}</h4></p><br>
						</div>
					</td>
					<td>
						<div align="left" class="right-column">
							<div>
								<h3 class = "profileH3" >${sessionScope.newUser.userName}님 반갑습니다.</h3>
								<p>CourseToGo에서 사용하실 닉네임을 작성해주세요.</p>
								
								<input type="text" name="userNickname" value="${sessionScope.newUser.userNickname}" maxlength="6">
								<h3 class = "profileH3" > 자기소개</h3>
								<p>프로필에 표시될 자기소개를 작성해주세요.</p>
								<input class = "introduce" type="text" name="userIntroduce" value="${sessionScope.newUser.userIntroduce}" maxlength="15"><br>
								<br><input class ="button" type="submit" value="회원가입" >
							</div>
							<br/>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>	
	

	
</body>
</html>