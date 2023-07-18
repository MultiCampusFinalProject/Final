<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  	<style>
		.placeRecommendBox {
		    position: fixed;
		    top: 500px;
		    left: 1200px;
		    box-sizing: border-box;\
		}
		
		.stars::before {
		  content: "★";
		}
		
		.stars[data-score="1"]::before {
		  content: "★";
		  color:#ffd400;
   		  font-size:30px;
		}
		
		.stars[data-score="2"]::before {
		  content: "★★";
		  color:#ffd400;
   		  font-size:30px;	  
		}
		
		.stars[data-score="3"]::before {
		  content: "★★★";
		  color:#ffd400;
   		  font-size:30px;
  		}
		
		.stars[data-score="4"]::before {
		  content: "★★★★";
		  color:#ffd400;
   		  font-size:30px;
		}
		
		.stars[data-score="5"]::before {
		  content: "★★★★★";
		  color:#ffd400;
   		  font-size:30px;
		}
	</style>
</head>
<body>
	<div class = "placeRecommendBox">
	
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
	    		&nbsp;&nbsp;&nbsp;&nbsp;추천 장소
	    		</h3>
		</div>
		
   		<div>	  
				<c:forEach items="${requestScope.placeDTOList}" var = "place" varStatus = "placeSt">
					
					<div style = "margin: 5px;
								  background-color: #f5f5f5;
								  border-bottom:2px solid #D5D5D5;
								  border-radius: 10px;
								  width: 600px;
								  padding-left: 30px;
								  overflow:hidden;">
						
							<div style="display: flex;
										flex-direction: row;
								        justify-content: left;
								        align-items: center;
								        margin-top:0px;
								        margin-bottom:0px;
										padding-top:0px;
										padding-bottom:0px;">
						
								<img style="padding-top:0px;
											padding-bottom:0px;" src="/example/letsgo.png" alt= "go!" width= "40px;">&nbsp;&nbsp;
										<h4 style="background-color: white;
												   padding-right: 5px;
												   border-radius: 5px;
												   color: #353535;
												   padding-top:0px;
												   padding-bottom:0px;">	     
											[ ${place.placeName} ]
										</h4>
										<c:choose>
											<c:when test="${place.placeAvgScore >= 0.0 && place.placeAvgScore < 1.0}">
												<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;</span>
											</c:when>
											<c:when test="${place.placeAvgScore >= 1.0 && place.placeAvgScore < 2.0}">
												<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★</span>
											</c:when>
											<c:when test="${place.placeAvgScore >= 2.0 && place.placeAvgScore < 3.0}">
												<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★</span>
											</c:when>
											<c:when test="${place.placeAvgScore >= 3.0 && place.placeAvgScore < 4.0}">
												<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★★</span>
											</c:when>
											<c:when test="${place.placeAvgScore >= 4.0 && place.placeAvgScore < 5.0}">
												<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★★★</span>
											</c:when>
											<c:when test="${place.placeAvgScore == 5.0}">
												<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★★★★</span>
											</c:when>
										</c:choose>		    				 
							</div>	  
						<h4 style="display: inline-block;
								   margin-top: 0px;
								   margin-bottom: 10px;
								   font-weight: normal;
								   color: black;">${place.address}</h4>

					</div>
					
				</c:forEach>
			
   		</div>		
	
	</div>
</body>
</html>
