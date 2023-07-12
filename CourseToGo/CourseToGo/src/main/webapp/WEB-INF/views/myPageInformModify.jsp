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
	
	<form action="/myPageInformModify" method="POST">
		<div class="myPageInform">
			<table>
				<tr>
					<td style="width: 400px;">
						<div align="center" class="left-column" width="500px">
							<h1>프로필</h1>
							<img id="profileImage" src="${sessionScope.userPhoto}" alt="profileImage" width="80" height="80">
							<p><h3>${sessionScope.userName}</h3></p>
							<p><h4 style="color: grey;">${sessionScope.userEmail}</h4></p><br>
							<button class="button" id="fix" onclick="showSampleImages()">프로필 사진 수정하기</button>
							<button class="button" id="delete" onclick="deleteProfileImage()">프로필 사진 삭제하기</button>
						</div>
					</td>
					<td>
						<div align="center" class="right-column">
							<div>
								<h3 class="profileH3">닉네임</h3>
								<input type="text" name="userNickname" value="${sessionScope.userNickname}" maxlength="6">
								<h3 class="profileH3">자기소개</h3>
								<input class="introduce" type="text" name="userIntroduce" value="${sessionScope.userIntroduce}" maxlength="15"><br>
								<br><br>
								<input type="hidden" name="userPhoto" id="userPhoto" value="${sessionScope.userPhoto}">
							</div>
							<br/>
							<div>
								<input class="button" type="submit" value="프로필 수정 완료" onclick="updateProfile()">
								<input class="button" type="button" value="회원 탈퇴" onclick="unsignConfirm()">
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>

	<script>
		// 이미지 선택 팝업 창
		function showSampleImages() {
			// 이미지 주소
			var imageUrls = [
			 "https://github.com/S2ll/S2ll/blob/main/userProfile2.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile3.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile4.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile5.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile6.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile7.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile8.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile9.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile10.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile11.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile12.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile13.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile14.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile15.png?raw=true",
			 "https://github.com/S2ll/S2ll/blob/main/userProfile16.png?raw=true"
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
			document.getElementById("profileImage").src = "https://github.com/S2ll/S2ll/blob/main/userProfile1.png?raw=true";
			document.getElementById("userPhoto").value = "https://github.com/S2ll/S2ll/blob/main/userProfile1.png?raw=true";
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
		
		// 알림창에서 확인버튼 클릭 시 회원탈퇴
	    function unsignUser() {
	        var userId = '<%= session.getAttribute("userId") %>';
	
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
