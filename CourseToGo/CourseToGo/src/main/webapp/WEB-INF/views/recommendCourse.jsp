<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<style>
		.courseRecommendBox {
		    position: fixed;
		    top: 500px;
		    left: 250px;
		    box-sizing: border-box;\
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
	<div class = "courseRecommendBox">
	
		<div style = "border-radius: 15px;
					  width: 350px;
					  height: 50px;
					  display: flex;
				      flex-direction: row;
				      justify-content: left;
				      align-items: center;
				      background-color: #87ceeb;
				      padding-right: 50px;
				      padding-left: 30px;">
				      
				<img src="/example/recommend.png" alt="recommend"
					width= "20px" style= "margin: 10px;">
				<h3 style = "display: inline-block; /* 폼 요소를 인라인 블록으로 표시 */
	    				 	 white-space: nowrap;
	    				 	 color: white;
	    				 	 font-size: 15pt;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;추천 코스
	    		</h3>
		</div>
		
   		<div>	  
				<c:forEach items="${requestScope.courseInformDTOList}" var = "course" varStatus = "courseSt">
					
					<div style = "margin: 5px;
								  background-color: #f5f5f5;
								  border-bottom:2px solid #D5D5D5;
								  border-radius: 10px;
								  width: 800px;
								  padding-left: 30px;">
						
							<div style="display: flex;
										flex-direction: row;
								        justify-content: left;
								        align-items: center;
								        padding-top: 10px;">
						
								<img src="/example/letsgo.png" alt= "go!" width= "40px;">&nbsp;&nbsp;
	 			                    <c:forEach items="${fn:split(course.courseList, ',')}" var="place">
				                        <div class="item" style = "display: inline-block;
	       								    				 	   white-space: nowrap;
				                        						   padding:5px;
				                        						   background-color: #91B6D0;
				                        						   border-radius:5px;
				                        						   color: #353535;
				                        						   margin-left: 10px;
				                        						   overflow:hidden;"><b>${place}</b></div>
				                    </c:forEach>
									<br>
									<c:choose>
										<c:when test="${course.courseAvgScore == 1.0}">
											<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★</span>
										</c:when>
										<c:when test="${course.courseAvgScore == 2.0}">
											<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★</span>
										</c:when>
										<c:when test="${course.courseAvgScore == 3.0}">
											<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★★</span>
										</c:when>
										<c:when test="${course.courseAvgScore == 4.0}">
											<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★★★</span>
										</c:when>
										<c:when test="${course.courseAvgScore == 5.0}">
											<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★★★★</span>
										</c:when>
									</c:choose>		    				 
							
							</div>	  
							<div>
								<h4 style="background-color: white;
										   margin-top: 5px;
										   padding-right: 5px;
										   border-radius: 5px;
										   color: #353535;
										   display: inline-block;">	     
									[ ${course.courseName} ]
								</h4>
									<span style="color: black; font-weight: normal;">${course.courseContent}</span>
							</div>

					</div>
					
				</c:forEach>
			
   		</div>		
	
	</div>
</body>
</html>
