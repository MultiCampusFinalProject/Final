<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.spring.dto.CourseInformDTO" %>
<c:set var="courseInformList" value="${requestScope.courseInformList}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course To Go / Review List</title>
	<style>
	    table {
			width: 80%;
	    }
	    
        .inline-items {
             white-space: nowrap;
        }
        .item {
            display: inline-block;
            border: 1px solid #EAE8E8;
            margin: 5px;
            padding: 5px;
        }
        .stars::before {
		  content: "★";
		}
		
		.stars[data-score="1"]::before {
		  content: "★";
		  color:#ffd400;
   		  font-size:20px;
		}
		
		.stars[data-score="2"]::before {
		  content: "★★";
		  color:#ffd400;
   		  font-size:20px;	  
		}
		
		.stars[data-score="3"]::before {
		  content: "★★★";
		  color:#ffd400;
   		  font-size:20px;
  		}
		
		.stars[data-score="4"]::before {
		  content: "★★★★";
		  color:#ffd400;
   		  font-size:20px;
		}
		
		.stars[data-score="5"]::before {
		  content: "★★★★★";
		  color:#ffd400;
   		  font-size:20px;
		}
	</style>
</head>
<body>
		<c:if test="${empty requestScope.courseReviewList}">
			<p style="margin: auto; text-align: center;">아직 남기신 리뷰가 없네요.<br>다녀온 코스의 리뷰를 작성해보시는 건 어떨까요?</p>
		</c:if>
		
		<c:if test="${not empty requestScope.courseReviewList}">
			<div>		
		    	 	<c:forEach items="${requestScope.courseReviewList}" var="courseReview" varStatus="courseReviewSt">
	
				    	 		<div style="margin: 5px;
				    	 					background-color:white;
				    	 					border-radius: 5px;
			       	 					    border: 1px solid #EAE8E8;
			       	 					    padding: 10px;">			 
					    	 		<c:forEach items="${requestScope.courseDetailPageList}" var="coursePage" varStatus="pageSt">
					    	 			<c:if test="${courseReviewSt.index eq pageSt.index}">
					    	 				<c:set var="query" value="${coursePage}" scope="request" />
					    	 			</c:if>
					    	 		</c:forEach>
									
									<div style="margin-bottom:5px;
												background-color: #fafafa;
												border-radius: 5px;
												padding:5px;
				       	 					    padding-left: 20px;">
										<c:forEach items="${requestScope.courseInformDTOList}" var="courseInformDTO" varStatus= "courseInformSt">
											<c:if test="${courseReviewSt.index eq courseInformSt.index}">
												<b>${courseInformDTO.userNickName}</b> 님의 <a href="/courseList/Map?${query}"><b>${courseInformDTO.courseName}</b></a> 코스에 남긴 리뷰입니다. <b style="color: #B6B7B7;">${courseReview.reviewDate}</b>
											</c:if>
										</c:forEach>
									</div>
									<div class="stars" style = "text-align: center; margin-bottom:5px;" data-score="${courseReview.courseScore}"></div>
									<div style = "background-color: #DDEBF0;
												  padding:10px;
												  border-radius: 5px;
												  text-align: center;">
												 
										"&nbsp;&nbsp;${courseReview.content}&nbsp;&nbsp;"
										
									</div>								
																											
				    	 		</div>
			        </c:forEach>
			</div>
		</c:if>

</body>
</html>