<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spring.dto.PlaceDTO" %>
<%@ page import="com.spring.dto.CourseReview" %>
<!DOCTYPE html>
<html>
 <style>

 .header{
 height:50px;}
body {

	height: 100%;
	margin: 0;
	padding: 0;
	
	

}
    .search{
      display: flex;
      justify-content: center;
      align-items: center;
      
      border: 1px solid black;
    }
    .test {
	
	padding: 5px;
	width: 80%;
	height: 800px;
	background-color: #fa8;
	border: 1px solid #000;

background-clip: content-box;

}
 .middle{
 	
 }
.contain{
 width: 100px;
 
	
}
}
  </style>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eeovn23rmv&submodules=geocoder&callback=init"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

</head>

<header class="header">
header
  <title>List View Example</title>
    <link rel="stylesheet" href="/css/bootstrap.css">
</header>
<body>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<div  class='middle'>



<div style="display: flex;position: fixed;width:100%; left: 50px;
            ">
  <div class="test" id="map" style="float: left;"></div>
  
   <title>슬라이드 메뉴</title>
    <style>
        /* 슬라이드 메뉴 스타일 */
        .slider-menu {
        
            position: fixed;
            top: 10%;
            right: 350px; /* 초기에는 왼쪽에 숨겨진 상태 */
            width: 200px;
            height: 90%;
            background-color: #f1f1f1;
            transition: right 0.3s ease;
        }
        
        /* 슬라이드 메뉴 버튼 스타일 */
        .slider-button {
            position: fixed;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            width: 30px;
            height: 30px;
            background-color: #ccc;
            cursor: pointer;
            z-index: 9999;
        }
    </style>
    <script>
        window.onload = function() {
            var sliderMenu = document.getElementById("slider-menu");
            var sliderButton = document.getElementById("slider-button");
            
            // 슬라이드 메뉴를 토글하는 함수
            function toggleSliderMenu() {
                if (sliderMenu.style.right === "350px") {
                    sliderMenu.style.right = "0";
                    sliderMenu.style.display = "none";
                   
                } else {
                    sliderMenu.style.right = "350px";
                    sliderMenu.style.display = "block";
                }
            }
            
            // 슬라이드 메뉴 버튼 클릭 이벤트 핸들러
            sliderButton.onclick = function() {
                toggleSliderMenu();
            };
        };
    </script>
    <div id="slider-menu" class="slider-menu">
        <!-- 슬라이드 메뉴 내용 -->
        <div style="text-align: center; width: 200px; height: 80px;margin : 0"" class="well well-sm">
        <h3>리뷰 슬라이드</h3>
          </div>
       <%
    List<CourseReview> reviewList = (List<CourseReview>)request.getAttribute("CourseReview");
   	for(int i = 0 ; i < reviewList.size(); i++){
   		%>
   	    <div style="text-align: center; width: 200px; height: 80px;margin : 0"" class="well well-sm">
   	       <%= reviewList.get(i).getContent() %>
   	       <%= reviewList.get(i).getCourseScore() %>
   	       <%= reviewList.get(i).getUserId() %>
   	    </div>
   	 
   	
   	      <%
   	   
   	

    }
%>
        
    </div>
    

  <span class="contain">
 
   <div style="text-align: center; width: 200px; height: 80px;margin : 0 " class="well well-sm">
   	        <h3 style="font-weight: bold;">${Course.courseName}</h3>
   	        
   	    </div>
   	    <div style="text-align: center; width: 200px; height: 80px;margin : 0" class="well well-sm">
   	        <h3 style="font-weight: bold;">${Course.courseId}</h3>
   	    </div>
   	    <div style="text-align: center; width: 200px; height: 80px;margin : 0"" class="well well-sm">
   	        <h3 style="font-weight: bold;">${Course.courseAvgScore}</h3>
   	    </div>
    <%
    List<PlaceDTO> placeList = (List<PlaceDTO>) request.getAttribute("PlaceList");
   	for(int i = 0 ; i < placeList.size(); i++){
   		%>
   	    <div style="text-align: center; width: 200px; height: 80px;margin : 0"" class="well well-sm">
   	        <h3 style="font-weight: bold;"><%= placeList.get(i).getPlaceName() %></h3>
   	    </div>
   	     <%
   	    if(i != placeList.size()-1){
   	 	%>
   	    <div style="text-align: center; width: 200px; height: 70px;">
   	        <img style="width: 50px; height: 50px;" src="<%= request.getContextPath() %>/images/arrow.png" alt="화살표">
   	    </div>
   	      <%
   	    }
   	

    }
%>
<div style="text-align: center; width: 200px; height: 80px;" class="well well-sm">
   	       <script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> 
   	        <script src="sidebars.js"></script>
   	        <div id="slider-button" href= style="font-weight: bold;">리뷰 보러가기</div>
   	    </div>
  </span>
   

</div>

</body>
<!-- footer -->
<h3 style="font-weight: bold; bottom:0px">${Course.courseContent}</h3>

<script>
//polyline

init();

//지도를 그려주는 함수 실행
function init(){
	

	var map;
	let markers = new Array(); //마커 정보를 담는 배열
	let infoWindows = new Array(); // 정보창을 담는 배열  
	//검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
	
	var polylinePath = new Array();
    
	 

	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.3595704, 127.105399),
	    zoom: 10
	});
 
  
    
 

    <c:forEach var="place" items="${PlaceList}">

    var counter = 0;
   
   

    
 //   polylinePath.push(new naver.maps.LatLng( ${place.latitude}, ${place.longitude}));
    	

    var marker = new naver.maps.Marker({
    
        position: new naver.maps.LatLng(${place.latitude}, ${place.longitude}),
    	
        map: map
    });
    
    markers.push(marker);
    
	var contentString = [
	    '<div class="iw_inner">', '<p>place Name: ${place.placeName}</p>',
	   ${place.latitude}, ${place.longitude},
	    '</div>'
	].join('');	
    
    var infoWindow = new naver.maps.InfoWindow({

        content: contentString,

        maxWidth: 140,
        backgroundColor: "#eee",
        borderColor: "#2db400",
        borderWidth: 5,
        anchorSize: new naver.maps.Size(30, 30),
        anchorSkew: true,
        anchorColor: "#eee",

        pixelOffset: new naver.maps.Point(20, -20)
    });

    infoWindows.push(infoWindow); // 생성한 정보창을 배열에 담는다.
    
    
  
    </c:forEach>
    for (var i=0, ii=markers.length; i<ii; i++) {
        naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
    }
   
    var polyline = new naver.maps.Polyline({
        path: polylinePath,      //선 위치 변수배열
        strokeColor: '#FF0000', //선 색 빨강 #빨강,초록,파랑
        strokeOpacity: 0.8, //선 투명도 0 ~ 1
        strokeWeight: 6,   //선 두께
        map: map           //오버레이할 지도
    });


    //---------------direction
    
    var polylinePath = new Array();
    
    
    <c:forEach var="direction" items="${DirectionList}">
    polylinePath.push(new naver.maps.LatLng( ${direction.latitude}, ${direction.longitude}));
    </c:forEach>
    console.log(polylinePath);
    


     //    var map = new naver.maps.Map('map', {
        //     center: new naver.maps.LatLng(37.5112, 127.0981), // 잠실 롯데월드를 중심으로 하는 지도
          //   zoom: 15
        // });
 		
         var polyline = new naver.maps.Polyline({
             path: polylinePath,      //선 위치 변수배열
             strokeColor: '#FF0000', //선 색 빨강 #빨강,초록,파랑
             strokeOpacity: 0.8, //선 투명도 0 ~ 1
             strokeWeight: 6,   //선 두께
             map: map           //오버레이할 지도
         });
         var marker = new naver.maps.Marker({
             position: new naver.maps.LatLng(37.5112, 127.0981),
             map: map,
             title:'사기',
             
          
             
         });
         
        
         
    
 
}





function ClickMap(i) {
	  return function () {
	    var infoWindow = infoWindows[i];
	    infoWindow.close()
	  }
	}

function getClickHandler(seq) {
	
    return function(e) {  // 마커를 클릭하는 부분
        var marker = markers[seq]; // 클릭한 마커의 시퀀스로 찾는다.
        var infoWindow = infoWindows[seq]; // 클릭한 마커의 시퀀스로 찾는다

        if (infoWindow.getMap()) {
            infoWindow.close();
        } else {
        	console.log("표시");
        	
        	
            infoWindow.open(map, marker); // 표출
            console.log(map, marker,infoWindow);
        }
	}
}

	
	
	
	
	
	
	
	

//지도를 그려주는 함수
function selectMapList() {
	
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.3595704, 127.105399),
	    zoom: 10
	});
}


// 지도를 이동하게 해주는 함수
function moveMap(len, lat) {
	var mapOptions = {
		    center: new naver.maps.LatLng(len, lat),
		    zoom: 15,
		    mapTypeControl: true
		};
    var map = new naver.maps.Map('map', mapOptions);
    var marker = new naver.maps.Marker({
        position: new naver.maps.LatLng(len, lat),
        map: map
    });
}
function calculateDistance(lat1, lon1, lat2, lon2) {
	  const earthRadius = 6371; // 지구 반지름 (단위: km)

	  // 각도를 라디안으로 변환
	  const lat1Rad = (lat1 * Math.PI) / 180;
	  const lon1Rad = (lon1 * Math.PI) / 180;
	  const lat2Rad = (lat2 * Math.PI) / 180;
	  const lon2Rad = (lon2 * Math.PI) / 180;

	  // 위도와 경도의 차이 계산
	  const latDiff = lat2Rad - lat1Rad;
	  const lonDiff = lon2Rad - lon1Rad;

	  // Haversine 공식 적용
	  const a =
	    Math.sin(latDiff / 2) * Math.sin(latDiff / 2) +
	    Math.cos(lat1Rad) * Math.cos(lat2Rad) * Math.sin(lonDiff / 2) * Math.sin(lonDiff / 2);
	  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	  const distance = earthRadius * c;

	  return distance;
	}

</script>

<div class="sidebar">
          
        </div>
</html>