<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인 정보 수정</title>
	<link rel="stylesheet" href="css/setUser.css">
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	
	<form action="/signupDone" method="POST">
		<div class="myPageInform">
			<table>
				<tr>
 					<td style="width: 500px;">
 						<div align="center" id="left-column" width="500px">
							<div class="imgArea">
								<div class="title"><h1>프로필</h1></div>
								<img id="profileImage" src="https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile1.png?raw=true" alt="profileImage" width="80" height="80">
								<p><h3>${sessionScope.newUser.userName}</h3></p>
								<p><h4 style="color: grey;">${sessionScope.newUser.userEmail}</h4></p>
								<div class="img-btn">
								</div>
							</div>
						</div>
					</td>
					<td>
 						<div align="center" id="right-column" class="textArea">
							<div >
							<div class="title"><h1>User Info</h1></div>
								<h3 class="profileH3">닉네임</h3>
								<input id="userNickname" class="userNickname" type="text" name="userNickname" value="${sessionScope.newUser.userNickname}" maxlength="6">
								<span id="userNickname-check" style="display:block; font-size: 2px; width:400px; height:20px;"></span>
								<h3 class="profileH3">자기소개</h3>
								<input class="introduce" type="text" name="userIntroduce" value="${sessionScope.newUser.userIntroduce}" maxlength="15"><br>
								<input type="hidden" name="userPhoto" id="userPhoto" value="${sessionScope.newUser.userPhoto}">
							</div>
							<br/>
							<div>
								<input id="editcomplete" class="button" type="submit" value="프로필 수정 완료" onclick="updateProfile()">
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>