<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course To Go</title>
	  <style>
    .button-container {
      display: flex;
      margin-left: 200px;
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
	  width: 80%;
	  max-width: calc(100% - 200px);
	  height: 65%;
	  position: absolute;
	  margin-left: calc(3% + 200px);
	  margin-right: 50px;
	  border-radius: 10px;
	  border: 2px solid #ccc;
	  padding: 20px;
	  background-color: #f2f2f2;
	  display: flex;
	  flex-direction: column;
	  justify-content: left;
	  align-items: left;
	}
	
  </style>
</head>
<body>

        <div class="sidebar">
            <%@ include file="sidebar.jsp" %>
        </div>
        
        <div>
        	<img src="https://github.com/Paprika0290/Paprika0290/assets/59499235/3e6dcc8a-648e-4727-8474-1aee71a99cb4"
         		 style="margin-left: 200px">
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
		  
		<div class="my-content-box" id="myContentBox">
		  <!-- 초기 내용 -->
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>
		  <p>초기 내용을 보여줄 수도 있습니다.</p>


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