<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spring.dto.CourseInformDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title class="searchList" >Searching Courses</title>

</head>
<style>
#mainForm
{   
  display: flex;
    justify-content: center;
    align-items: center;
}
body{

 overflow: auto;
}
  .searchList{
 position: relative;

  


   top: 0;
    left: 250px;
    right: 600px;
    bottom: 0;
  }
    #child {
      display: flex;
    transform: translateX(-50%);
  }
</style>
<body>

    <div class="sidebar" >
            <%@ include file="sidebar.jsp" %>
        </div>
<div class="searchList" >
 </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
   <div class="searchList"> <h1 >"어디"로 갈지 모르시겠나요? 다른 이들과 저희의 추천을 받아보세요.</h1></div>
    <!-- 검색 엔진 -->
    <script>
    $(document).ready(function() {
    	var suggestions = [];
        $('#keyword').on('input', function() {
        	suggestions=[];
            var query = $(this).val();
            $.ajax({
                url: '/search',
                data: { query: query },
                success: function(response) {
                    // 추천 결과를 처리하는 로직
                    // 예: 결과를 동적으로 표시하거나 자동완성 기능 구현
                    var suggestions = response;  // 응답으로 받은 추천 결과
                    var suggestionsHtml = "";   // 결과를 표시할 HTML 문자열

                    // 추천 결과를 HTML로 생성
                    for (var i = 0; i < suggestions.length; i++) {
                        suggestionsHtml += "<p>" + suggestions[i] + "</p>";
                    }

                    // 결과를 표시할 위치에 HTML 추가
                    $('#suggestions').html(suggestionsHtml);
                }
            });
        });
    });
    
    
</script>
    <!-- 검색 창 -->
    
    <div  class="searchList">
    	<form id="mainForm" class="row justify-content-center g-3" action="/courseListWithPagination" method="GET">
			<div class="col-auto">
				
					<input	 style="width: 300px;"
						type="text" 
						class="form-control" 
						id="keyword"
						placeholder="Keyword" 
						name="keyword"
						value="${pageInfo.pageRequest.keyword}"><div id="suggestions"></div>
			</div>
			<div class="col-auto">
				<input type="hidden" name="pageNum" value="${pageInfo.pageRequest.pageNum}" />
				<input type="hidden" name="amount" value="${pageInfo.pageRequest.amount}" />
				<input  type="submit" class="btn btn-primary mb-3" value="Search" />
			</div>
		</form>
		</div>
    	<%
    List<CourseInformDTO> courseInformList = (List<CourseInformDTO>) request.getAttribute("CourseInformList");
    if (courseInformList != null) {
        for (CourseInformDTO course : courseInformList) {
        	int courseId = course.getCourseId();
        
            String courseName = course.getCourseName();
            int userId = course.getUserId();
          	double AvgScore = course.getCourseAvgScore();
            String courseList = course.getCourseList();
            String courseIdList = course.getCourseIdList();
            String courseContent = course.getCourseContent();
            String[] placeNames = courseList.split(",");
            String[] placeIds = courseIdList.split(",");
            String query="";
            int courseNumber = course.getCourseNumber();
         
            query+=("courseId="+ String.valueOf(courseId)+"&");
            for(int i= 0; i< courseNumber; i++){
            	query+="placeId"+(i+1) + "="+placeIds[i];
            	if(i!= courseNumber-1)query+="&";
            	else{
            	
            	}
            }
         
%>

    <div class="searchList">
<li class="list-group-item" style="width:100%;">
  <div class=" ">
    <a href="/courseList/Map?<%= query %>">
      <h2>Course Id: <span class="course-id"><%= courseId %></span> &nbsp <span> <%= courseName %></span>&nbsp	<span>제작자: <%= userId %></span></h2>

      
		<br>
      
      <%-- placeIds 배열을 활용하여 필요한 작업 수행 --%>

      <% for (String placeName : placeNames) { %>
     &nbsp &nbsp &nbsp &nbsp &nbsp
      <span class="well" stle="padding:20px"><%= placeName %>   </span>
      &nbsp &nbsp &nbsp &nbsp &nbsp

      <% }      %>


    </a>
    <br>
    
       <br>
      
    <h3>소개글: <%= courseContent %></h3>
  </div> 
	<form action="/courseBookmark" method="POST">
		<div style="float:right;">
			<button type="submit" class="add-button">찜하기</button>
		</div>
		<br>
		<input type="hidden" name="courseId" id="courseIdInput" value="<%= courseId %>" >
	</form>
  </div>

</li>
<%
    }
  }
%>
</div>
    	
    
      <div class="searchList">
    <div class="row justify-content-center" >
		<div class="col-6">
			<nav class="page navigation">
				<ul class="pagination">
					<c:if test="${pageInfo.prev}">
						<li class="page-item">
							<a class="page-link" aria-label="Previous" 
							 href="#">Prev</a>
							<!--  href="/courseListWithPagination?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}&keyword=${pageInfo.pageRequest.keyword}">Prev</a>-->	
						</li>
					</c:if>
					<c:forEach var="num" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<li class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
							<a class="page-link" id="page-1"
							href="#">${num}</a>
							<!--	href="/courseListWithPagination?pageNum=${num}&amount=${pageInfo.pageRequest.amount}&keyword=${pageInfo.pageRequest.keyword}">${num}</a>-->	
						</li>
					</c:forEach>
					<c:if test="${pageInfo.next}">
						<li class="page-item next">
							<a class="page-link" aria-label="next" 
							 href="#">Next</a>
							<!--	 href="/courseListWithPagination?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}">Next</a>-->	
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
    </div>
   <script type="text/javascript">
	//step01 : 페이징 버튼 클릭시 지정 url 요청갈수 있도록 이벤트 등록
	console.log()
	
	Array.from(document.getElementsByClassName('page-link'))
		.forEach((pagingButton) => {
			
			pagingButton.addEventListener('click', function(e){
				// 해당 객체의 기본적인 이벤트(a:href 로 이동) 를 방지
				e.preventDefault();
				console.log("---");
				//step02 : 등록 후, action : '/main' 으로 요청 시, keyword 값 유무에 따라 queryString 변경
				console.log(e)
				//step03 : 
				let mainForm = document.getElementById('mainForm');
				console.log(e.target.innerHTML);
				// 현재 페이지 값으로 변경하여 /main 요청하도록 지정
			/*	mainForm.pageNum = */
			mainForm.pageNum.value = e.target.innerHTML;
			if(mainForm.keyword.value == '') {
				mainForm.keyword.remove();
			}
			
			mainForm.action = '/courseListWithPagination';
			mainForm.method = 'GET';
			mainForm.submit();
		})
})

	//step02 : 등록 후 , action : '/main' 으로 요청 시, keyword 값 유무에 따라 queryString 변경
	//step03 : 요청
	

	// bookmark 관련 코드=======================================================
	 $(document).ready(function() {
	  $('.add-button').on('click', function() {
	    var courseId = $('#courseIdInput').val(); // courseId 값을 가져옴
	    $('#courseForm').submit(); // 폼 제출
	  });
	});
</script>

 
	
</body>
</html>