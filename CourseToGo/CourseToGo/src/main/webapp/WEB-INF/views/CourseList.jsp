<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spring.dto.CourseInformDTO" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Set" %>
<!DOCTYPE html>
<html>
<head>
    <title class="searchList" >Searching Courses</title>

</head>
<style>

@import url('https://fonts.googleapis.com/css2?family=Cute+Font&family=Dongle:wght@300;700&family=Sunflower:wght@300&family=VT323&display=swap');
#mainForm
{   
  display: flex;
 
}
body{

 overflow: auto;
}
  .searchList{
 position: relative;

  
font-weight: bold;

   top: 0;
    left: 250px;
    right: 600px;
    bottom: 0;
  }
    #child {
      display: flex;
    transform: translateX(-50%);
  }
  
 .recommendedSearchList{
 position: relative;

  font-weight: bold;


   top: 0;
    left: 250px;
    right: 600px;
    bottom: 0;

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
                    var suggestionsHtml = " &nbsp  검색 키워드    :";   // 결과를 표시할 HTML 문자열
                    
                    // 추천 결과를 HTML로 생성
                    for (var i = 0; i < suggestions.length; i++) {
                    	 suggestionsHtml += "<span stye='position: relative; z-index: 1;'>" + suggestions[i]+" " + "</span>";
                        
                    }
              
                    // 결과를 표시할 위치에 HTML 추가
                    $('#suggestions').html(suggestionsHtml);
                }
            });
        });
    });
    
    function getUserLocation() {
    	  // 위치 정보를 가져오는 로직을 작성합니다.
    	  // 예: Geolocation API를 사용하여 사용자 위치를 가져옴
    	  if (navigator.geolocation) {
    	    navigator.geolocation.getCurrentPosition(function(position) {
    	      // 위치 정보를 사용하여 필요한 작업을 수행합니다.
    	      // 예: 위도와 경도를 얻어온 후 다른 기능에 활용
    	      var latitude = position.coords.latitude;
    	      var longitude = position.coords.longitude;
    	      console.log(latitude, longitude);
    	      // 여기서 필요한 로직을 추가하세요.
    	    });
    	  } else {
    	    console.log("Geolocation is not supported by this browser.");
    	  }
    	}
</script>
    <!-- 검색 창 -->
   
    <div  class="searchList">
    

    	<form id="mainForm" class="row justify-content-center g-3" action="/courseListWithPagination" method="GET">
			<div class="col-auto" style="display: flex; ">
					<input  type="submit" class="btn btn-primary mb-3 " style="margin-left: 100px; value="검색" />
					<input	 style="width: 400px; height: 40px;"
					
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
				
			</div>
		</form>
		</div>
		<br>
	   <!--추천 코스 리스트 -->	
		    	<%
    List<CourseInformDTO> recommandedCourseInformList = (List<CourseInformDTO>) request.getAttribute("recommandedCourseInformList");
    if (recommandedCourseInformList != null) {
        for (CourseInformDTO course : recommandedCourseInformList) {
        	int courseId = course.getCourseId();
        
            String courseName = course.getCourseName();
            String userNickName = course.getUserNickName();
          	double AvgScore = course.getCourseAvgScore();
            String courseList = course.getCourseList();
            String courseIdList = course.getCourseIdList();
            String courseContent = course.getCourseContent();
            String areaString = course.getAreaNameList();
            String categoryString = course.getCategoryNameList();
            Set<String> areaSet =  new HashSet<>(Arrays.asList(areaString.split(",")));
            Set<String> categorySet =  new HashSet<>(Arrays.asList(categoryString.split(",")));
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

    <div class="recommendedSearchList">
<li class="list-group-item" style=" width:1400px;animation: spin 2s linear infinite; background-color: #87CEEB;	border-radius: 20px 20px 20px 20px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);">
  <div class=" " >
    <a  style="color: navy; font-family: 'Sunflower', sans-serif;" href="/courseList/Map?<%= query %>">
      <h1>No. <span class="course-id"><%= courseId %></span> &nbsp <span> 
      <%= courseName %></span>&nbsp	
      <span>제작자: <%= userNickName %></span>
         <%for (String area : areaSet) {%>
      <span>
      #<%= area %> </span><%} 
      %>
      
      
            <%for (String category : categorySet) {%>
      <span>
      #<%= category %> </span><%} 
      %>
      </h1>

      
		<br>
      
      <%-- placeIds 배열을 활용하여 필요한 작업 수행 --%>
<% for (int i = 0; i < placeNames.length; i++) { %>
  <% if (i > 0) { %>
    &nbsp;
    <img src="/images/dot2.png" alt="이미지_설명" width="50" height="auto" style="transform: rotate(90deg);">
    &nbsp;
 
  <% } %>
  
  <% if (i == 0) { %>
   <img src="/images/go1.png" alt="이미지_설명">
    &nbsp;
  <% } %>
  
  <span style="border: 2px solid blue; border-radius: 10px; padding: 20px; background-color: white;" padding: 20px; class="well" style="padding: 20px;"><img src="/images/point.png" alt="이미지_설명" width="30" height="auto"><%= placeNames[i] %></span>
  
  <% if (i == placeNames.length - 1) { %>
    &nbsp;
  <img src="/images/end2.png" alt="이미지_설명" width="50" height="auto">
  <% } %>
  
<% } %>


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
<br>
<%
    }
  }
%>
</div>
		
		
		
		
		
		
		
		
		
		<!--  사용자 코스 제작 리스트 -->
    	<%
    List<CourseInformDTO> courseInformList = (List<CourseInformDTO>) request.getAttribute("CourseInformList");
    if (courseInformList != null) {
        for (CourseInformDTO course : courseInformList) {
        	int courseId = course.getCourseId();
        
            String courseName = course.getCourseName();
            String userNickname = course.getUserNickName();
          	double AvgScore = course.getCourseAvgScore();
            String courseList = course.getCourseList();
            String courseIdList = course.getCourseIdList();
            String areaString = course.getAreaNameList();
            String categoryString = course.getCategoryNameList();
            String courseContent =course.getCourseContent();
            Set<String> areaSet =  new HashSet<>(Arrays.asList(areaString.split(",")));
            Set<String> categorySet =  new HashSet<>(Arrays.asList(categoryString.split(",")));
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
<li class="list-group-item"  style=" width:1400px;animation: spin 2s linear infinite; background-color: #6495ed;	border-radius: 20px 20px 20px 20px; box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);">
  <div class=" ">
    <a style="color: navy; font-family: 'Sunflower', sans-serif;" href="/courseList/Map?<%= query %>">
      <h1>No. <span class="course-id"><%= courseId %></span> &nbsp 
      <span> <%= courseName %></span>&nbsp
      	<span>제작자: <%= userNickname  %></span>
       <%for (String area : areaSet) {%>
      <span>
      #<%= area %> </span><%} 
      %>
      
      
         <%for (String category : categorySet) {%>
      <span>
      #<%= category %> </span><%} 
      %>
      
      </h1>

      
		<br>
      
      <%-- placeIds 배열을 활용하여 필요한 작업 수행 --%>
<% for (int i = 0; i < placeNames.length; i++) { %>
  <% if (i > 0) { %>
    &nbsp;
    <img src="/images/dot2.png" alt="이미지_설명" width="50" height="auto" style="transform: rotate(90deg);">
    &nbsp;
 
  <% } %>
  
  <% if (i == 0) { %>
   <img src="/images/go1.png" alt="이미지_설명">
    &nbsp;
  <% } %>
  
  <span style="border: 2px solid blue; border-radius: 10px; padding: 20px; background-color: white;" padding: 20px; class="well" style="padding: 20px;"><img src="/images/point.png" alt="이미지_설명" width="30" height="auto"><%= placeNames[i] %></span>
  
  <% if (i == placeNames.length - 1) { %>
    &nbsp;
  <img src="/images/end2.png" alt="이미지_설명" width="50" height="auto">
  <% } %>
  
<% } %>



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
	<br>
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