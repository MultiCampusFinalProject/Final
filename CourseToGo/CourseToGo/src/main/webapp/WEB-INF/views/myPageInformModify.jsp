<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.spring.dto.CtgUserDTO" %>
<c:set var="userId" value="${sessionScope.user.userId}" />


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인 정보 수정</title>
	<link rel="stylesheet" href="css/myPageInform.css">
</head>
<body>
	<!-- 사이드바 -->
	<div>
		<%@ include file="sidebar.jsp" %>
	</div>
	<!-- 배너 -->	
	<div class = "banner" style = "margin-left: 200px;">
		<img src="https://github.com/Paprika0290/Paprika0290/assets/59499235/3e6dcc8a-648e-4727-8474-1aee71a99cb4">
	</div>
	<!-- 로그인/회원정보 -->
	<div class = "loginAndSignup">
		<%@ include file="loginbtn.jsp" %>
	</div>
	
	<form action="/myPageInformModify" method="POST">
		<div class="myPageInform">
			<table>
				<tr>
 					<td style="width: 500px;">
 						<div align="center" id="left-column" width="500px">
							<div class="imgArea">
								<div class="title"><h1>프로필</h1></div>
								<img id="profileImage" src="${sessionScope.user.userPhoto}" alt="profileImage" width="80" height="80">
								<p><h3>${sessionScope.user.userName}</h3></p>
								<p><h4 style="color: grey;">${sessionScope.user.userEmail}</h4></p>
								<div class = "user-count">
									<div id="my-course"><h4>${sessionScope.myCourseCount}</h4><h4 style="color: grey;">나의 코스</h4></div>
									<div id="bookmark-course"><h4>${sessionScope.myBookmarkCount}</h4><h4 style="color: grey;">찜한 코스</h4></div>
									<div id="my-review"><h4>${sessionScope.myReviewCount}</h4><h4 style="color: grey;">나의 리뷰</h4></div>
								</div><br/>
								<div class="img-btn">
									<button class="button" id="fix" onclick="showSampleImages()">프로필 사진 수정하기</button>
									<button class="button" id="delete" onclick="deleteProfileImage()">프로필 사진 삭제하기</button>
								</div>
							</div>
						</div>
					</td>
					<td>
 						<div align="center" id="right-column" class="textArea">
							<div >
							<div class="title"><h1>User Info</h1></div>
								<h3 class="profileH3">닉네임</h3>
								<input id="userNickname" class="userNickname" type="text" name="userNickname" value="${sessionScope.user.userNickname}" maxlength="6">
								<span id="userNickname-check" style="display:block; font-size: 2px; width:400px; height:20px;"></span>
								<h3 class="profileH3">자기소개</h3>
								<input class="introduce" type="text" name="userIntroduce" value="${sessionScope.user.userIntroduce}" maxlength="15"><br>
								<input type="hidden" name="userPhoto" id="userPhoto" value="${sessionScope.user.userPhoto}">
							</div>
							<br/>
							<div>
								<input id="editcomplete" class="button" type="submit" value="프로필 수정 완료" onclick="updateProfile()">
								<input id="unsign" class="button" type="button" value="회원 탈퇴" onclick="unsignConfirm()">
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
		
		// 닉네임 input 기본값 설정 및 이벤트 처리=================================================================
		var userNicknameInput = document.getElementById('userNickname');
		var defaultUserNickname = userNicknameInput.value;

		userNicknameInput.addEventListener('focus', function() {
		    if (userNicknameInput.value === defaultUserNickname) {
		        userNicknameInput.value = '';
		    }
		});

		userNicknameInput.addEventListener('blur', function() {
		    if (userNicknameInput.value === '') {
		        userNicknameInput.value = defaultUserNickname;
		    }
		});

		// 자기소개 input 기본값 설정 및 이벤트 처리
		var userIntroduceInput = document.querySelector('.introduce');
		var defaultUserIntroduce = userIntroduceInput.value;

		userIntroduceInput.addEventListener('focus', function() {
		    if (userIntroduceInput.value === defaultUserIntroduce) {
		        userIntroduceInput.value = '';
		    }
		});

		userIntroduceInput.addEventListener('blur', function() {
		    if (userIntroduceInput.value === '') {
		        userIntroduceInput.value = defaultUserIntroduce;
		    }
		});


		// 이미지 선택 팝업 창========================================================================
		function showSampleImages() {
			// 이미지 주소
			var imageUrls = [
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile2.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile3.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile4.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile5.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile6.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile7.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile8.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile9.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile10.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile11.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile12.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile13.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile14.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile15.png?raw=true",
				"https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile16.png?raw=true"
			];
			
			// 팝업 창 화면 중앙에 출력
			var popupWidth = 500;
			var popupHeight = 500;
			var screenWidth = window.screen.width;
			var screenHeight = window.screen.height;
			var left = (screenWidth - popupWidth) / 2;
			var top = (screenHeight - popupHeight) / 2;
			
			top = (screenHeight - popupHeight) / 2 - (screenHeight * 0.3); // 10%의 상단 여백을 추가
			
			var popup = window.open("", "_blank", "width=" + popupWidth + ",height=" + popupHeight + ",left=" + left + ",top=" + top);
			var html = "<html><body><div align='center'><h1>프로필 사진 선택</h1>";
			
			// 팝업창에 이미지 반목문으로 1~16출력
			for (var i = 0; i < imageUrls.length; i++) {
				var imageUrl = imageUrls[i];
				// 이미지 클릭 시, 부모 창의 selectImage 함수 호출하여 이미지 URL 전달
				html += "<img src='" + imageUrl + "' alt='profileImage' width='80' height='80' onclick='window.opener.selectImage(\"" + imageUrl + "\")'> ";
			}
			
			html += "<br><br><button onclick='window.close()'>확인</button>";
			html += "</div></body></html>";
			popup.document.write(html);
		}
		
		// 팝업창에서 이미지 선택 시 개인정보 수정창의 이미지 변경(src값을 변경)
		function selectImage(imageUrl) {
			document.getElementById("profileImage").src = imageUrl;
			document.getElementById("userPhoto").value = imageUrl;
		}
		
		// 프로필 수정 완료 버튼 클릭 시 현재 이미지 태그의 src 값을 userPhoto에 저장	
		function updateProfile() {
		    var confirmResult = confirm("변경하시겠습니까?");
		    if (confirmResult) {
			    var userPhoto = document.getElementById("userPhoto").value;
			    document.getElementById("profileImage").src = userPhoto;
		    }
		}
		
		// 프로필 사진 삭제 버튼 클릭 시 기본이미지(userProfile1.png)로 변경 및 userPhoto에 저장
		function deleteProfileImage() {
			document.getElementById("profileImage").src = "https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile1.png?raw=true";
 			document.getElementById("userPhoto").value = "https://github.com/MultiCampusFinalProject/Final/blob/main/CourseToGo/CourseToGo/src/main/resources/static/example/userProfile1.png?raw=true";
		}
		
		// 회원탈퇴 버튼 클릭 시 사용자에게 확인을 요청하는 알림창
		function unsignConfirm() {
			var confirmResult1 = confirm("정말로 회원을 탈퇴하시겠습니까?");
			if (confirmResult1) {
				var confirmResult2 = confirm("탈퇴 후에는 이전 정보를 되돌릴 수 없습니다. 탈퇴하시겠습니까?");
				if(confirmResult2) {
					unsignUser();
				}
			}
		}
		
		// 알림창에서 확인버튼 클릭 시 회원탈퇴===============================================================
	    function unsignUser() {
	    	var userId = parseInt('<%= pageContext.getAttribute("userId") %>');
	
	        var form = document.createElement('form');
	        form.method = 'POST';
	        form.action = '/myPageInformModify';
	
	        var input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = '_method';
	        input.value = 'PUT';
	        form.appendChild(input);
	
	        input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'userId';
	        input.value = userId;
	        form.appendChild(input);
	
	        document.body.appendChild(form);
	        form.submit();
		}
	</script>
</body>
</html>
