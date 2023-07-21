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
								<input id="userNickname" class="userNickname" type="text" name="userNickname" value="${sessionScope.newUser.userNickname}" maxlength="8">
								<span id="userNickname-check" style="display:block; font-size: 2px; width:400px; height:20px;"></span>
								<h3 class="profileH3">자기소개</h3>
								<input class="introduce" type="text" name="userIntroduce" value="${sessionScope.newUser.userIntroduce}" maxlength="50"><br>
								<input type="hidden" name="userPhoto" id="userPhoto" value="${sessionScope.newUser.userPhoto}">
							</div>
							<br/>
							<div>
								<input id="editcomplete" class="button" type="submit" value="회원 가입" onclick="updateProfile()">
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
	
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		// 닉네임 중복 검사==============================================================================
		$('#userNickname').keyup(function() {
			var userNickname = $('#userNickname').val();
			
			$.ajax({
				url: "/myPageInformModify/nicknameCheck",
				type: "get",
				data: {
					userNickname: userNickname
				},
				success: function(res) {
					console.log(res);
					if(res == 1) {
						$("#userNickname-check").html('이미 사용중인 닉네임입니다.');
						$("#userNickname-check").css({
							  'color': 'red',
							  'font-weight': 'bold'
							});
					} else if(res == 0) {
						$("#userNickname-check").html('사용 가능한 닉네임입니다.');
						$("#userNickname-check").css({
							  'color': '#4c92b1',
							  'font-weight': 'bold'
							});
					} else if(res == -1) {
						$("#userNickname-check").html('닉네임을 입력해주세요.(닉네임은 비어있을 수 없습니다.)');
						$("#userNickname-check").css({
							  'color': 'red',
							  'font-weight': 'bold'
							});
					}
				},
  				error: function() {
					alert("서버 요청 실패");
				}
			});
		});
	</script>
</body>
</html>