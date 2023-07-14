<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>테스트</title>

	<style>
		.screenLeft {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 200px;
		    height: 100%;
		    background-color: #87ceeb;
		    border-top-right-radius: 20px;
		    border-bottom-right-radius: 20px;
		    padding: 20px;
		    box-sizing: border-box;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    box-shadow: 5px 0px 10px rgba(0, 0, 0, 0.3); /* 우측에 그림자 효과 추가 */
		 } 
		
		.screenRightTop {
			margin-left: 200px;
			width: calc(100% - 200px);
			height: 200px;
			float: left;
		}
		
		.screenRightMiddle{
			margin-left: 200px;
			width: calc(100% - 200px);
			height: calc(100% - 200px);
			float: left bottom;
			z-index: 3;
		}
			
		    .button-container {
		      display: flex;
		    }
	    
		    .button {
			    display: block;
			    text-decoration: none;
			    color: black;
			    font-weight: bold;
			    padding: 10px;
			    border-radius: 10px;
			    text-align: center;
			    background-color: #fff;
			    width: 170px;
			    margin:auto;
		    }
		    
		   	.my-content-box {
			  width: 90%;
			  height: calc(90vh - 200px);
			  margin: 5vh auto;
			  margin-left: 5%;
			  margin-right: 5%;
			  border-radius: 10px;
			  border: 2px solid #ccc;
			  background-color: #f2f2f2;
			  display: flex;
			  flex-direction: column;
			  justify-content: left;
			  align-items: left;
			  overflow: auto;
			}
		
	</style>	
	
</head>
<body>
	<div class= "screenLeft">
       <%@ include file="sidebar.jsp" %>		
	</div>
	<div class = "screenRightTop">
	    <div>
		   	<img src="https://github.com/Paprika0290/Paprika0290/assets/59499235/3e6dcc8a-648e-4727-8474-1aee71a99cb4">
		    <div class="loginAndSignup">
		        <%@ include file="loginbtn.jsp" %>
		    </div>
	   </div>
		     <br><br>
		     <div class="button-container">
				 <button class="button" onclick="changeContent('/userCourse')"> 나의 코스</button>
				 <button class="button" onclick="changeContent('/userReview')">나의 리뷰</button>
				 <button class="button" onclick="changeContent('/userBookmarkList')">내가 찜한 코스</button>
			</div>
		<br>
	</div>
	<div class= "screenRightMiddle">
		<div class="my-content-box" id="myContentBox">
		  <p>콘텐츠 내용이 표시됩니다.</p>		
		</div>	
	</div>
	
				<script>
			function changeContent(page) {
			  var myContentBox = document.getElementById('myContentBox');
			  
			  // AJAX를 사용하여 JSP 파일의 내용을 가져옴
			  var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      myContentBox.innerHTML = this.responseText;
			    }
			  };
			  
			  // 요청 보내기
			  xhttp.open("GET", page, true);
			  xhttp.send();
			}
			</script>
</body>
</html>