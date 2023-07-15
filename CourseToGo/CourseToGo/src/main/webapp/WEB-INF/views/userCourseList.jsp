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
<title>Insert title here</title>
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
	</style>
</head>
<body>
		<c:if test="${empty requestScope.courseInformList}">
			<p style="margin: auto; text-align: center;">등록된 코스가 존재하지 않습니다.<br>나만의 코스를 만들어볼까요?</p>
		</c:if>
		
		<c:if test="${not empty requestScope.courseInformList}">
			<div>		
		    	 	<c:forEach items="${requestScope.courseInformList}" var="courseInformDTO" varStatus="courseSt">
	
				    	 		<div style="margin: 5px;
				    	 					background-color:white;
				    	 					border-radius: 5px;
			       	 					    border: 1px solid #EAE8E8;
			       	 					    padding: 5px">
			       	 					    
						    	 	<c:forEach items="${requestScope.courseMakerUserNameList}" var="userName" varStatus="userSt">
					    	 			<c:if test="${courseSt.index eq userSt.index}">
					    	 				<b>${userName} </b>님의
					    	 			</c:if>
					    	 		</c:forEach>
					    	 		
					    	 		<c:forEach items="${requestScope.courseDetailPageList}" var="coursePage" varStatus="pageSt">
					    	 			<c:if test="${courseSt.index eq pageSt.index}">
					    	 				<c:set var="query" value="${coursePage}" scope="request" />
					    	 			</c:if>
					    	 		</c:forEach>
					    	 		
				    	 			<a href="/courseList/Map?${query}" style="color: blue;"><b>${courseInformDTO.courseName} </b></a> Course: ${courseInformDTO.courseContent} <br>
				    	 			
					                <div class="inline-items">
					                    <c:forEach items="${fn:split(courseInformDTO.courseList, ',')}" var="place">
					                        <div class="item">${place}</div>
					                    </c:forEach>
					                </div>
					                
									<c:forEach begin="1" end="${courseInformDTO.courseAvgScore}" varStatus="status">
									    <span>&#9733;</span>
									</c:forEach>
		
				    	 		</div>
			        </c:forEach>
			</div>
		</c:if>

</body>
</html>