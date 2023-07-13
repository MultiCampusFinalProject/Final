<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.spring.dto.PlaceDTO" %> 
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> 

<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=61p0dd1v1a"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <meta charset="EUC-KR">
    <title>Marker Test</title>
    <link rel="stylesheet" type="text/css" href="css/Map.css">
    <style>
  ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }
</style>
</head>
<script>
window.onload = function() {
var queryString = window.location.search;
var urlParams = new URLSearchParams(queryString);

var areaName = urlParams.get('areaName'); // "홍대"
document.getElementById("area").innerHTML = areaName;

};
</script>
<body>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.js"></script>
<link rel="stylesheet" href="Map.css">

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<div class="middle">
  <div class="left">
    <form id="searchForm" method="get" action="/jSearchAC" accept-charset="utf-8">
      <input type="text" id="areaName" name="areaName" placeholder="검색어를 입력하세요">
      <input type="text" id="categoryName" name="categoryName" placeholder="검색어를 입력하세요">
      <button type="submit">검색</button>
    </form>
  </div>
  <div class="right">
    <form id="saveMark" action="/saveMarker" method="POST" accept-charset="UTF-8">
      <input type="hidden" name="placeId1" value="1">
      <input type="hidden" name="placeId2" value="2">
      <input type="hidden" name="placeId3" value="3">
      <input type="hidden" name="placeId4" value="4">
      <input type="hidden" name="placeId5" value="5">
      <input id="courseName" type="text" name="courseName" value="myCourse">
      <input id="courseNumber" type="hidden" name="courseNumber">
      <textarea id="courseContent" style="width: 50%" class="text" name="courseContent" required>코스에 대한 설명을 작성해주세요.</textarea>
      <button type="submit">전송</button>
    </form>
  </div>
</div>

<!--  전송 버튼에 대한 스크립트 -->
	<script>
		// 버튼 중복 클릭시 한번만 전송
	    var submitButtonClicked = false;
	
	    function submitForm() {
	        if (submitButtonClicked) {
	            return false; // 이미 중복 클릭된 경우 중단
	        }
	        submitButtonClicked = true; // 버튼 클릭 상태로 설정
	        var form = document.getElementById("saveMark");
	        form.submit(); // 폼 제출
	    }
	    
	    document.getElementById("saveMark").addEventListener("submit", function(event) {
	        // 추가 동작을 수행합니다.
	       
	        event.preventDefault();
	        console.log("전송 버튼이 눌렸습니다!");
	        var courseNameInput = document.getElementById("courseName");
	        var courseNameValue = courseNameInput.value.trim();
	        if (courseNameValue === "") {
	            alert("이름을 입력해주세요.");
	            submitButtonClicked = false; // 버튼 클릭 상태 초기화
	            return;
	        }
	        var courseContentField = document.getElementById("courseContent");
	        var courseContentValue = courseContentField.value;
	        if (courseContentValue === "") {
	            alert("코스내용을 입력해주세요.");
	            submitButtonClicked = false; // 버튼 클릭 상태 초기화
	            return;
	        }
	        if (placeName.length === 0) {
	            alert("최소 1개 이상의 장소를 선택해주세요.");
	            submitButtonClicked = false; // 버튼 클릭 상태 초기화
	            return;
	        }
	        var inputElement = document.getElementById("courseNumber");
	        inputElement.value = placeName.length;
	        submitForm(); // 폼 제출
	    });
	</script>
	
	</div>



<script>
    document.getElementById("searchForm").addEventListener("submit", function(event) {
        // 추가 동작을 수행합니다.
        event.preventDefault(); 
        console.log("검색 버튼이 눌렸습니다!");
        var elements = document.getElementsByClassName("well well-sm");
        while (elements.length > 0) {
            elements[0].parentNode.removeChild(elements[0]);
          }
        this.submit();
      
        // 폼을 서버로 제출합니다.
      

        
       // 기본 동작을 막기 위해 이벤트의 기본 동작을 취소합니다.
    });
    
    
</script>
<div style="text-align:left;">
    <h2 id ="area"></h2>
    <%-- <h3>검색결과</h3>--%>
    <ul>
        <%
            List<PlaceDTO> places = (List<PlaceDTO>) request.getAttribute("placesByAreaOrCategory");
            if (places != null) {
                int count = 0;
                for (PlaceDTO place : places) {
                    if (count >= 10) {
                        break; // 5번 이상 반복하지 않도록 종료
                  }
        %>
        <div style="text-align: center; width: 200px; left:20px;height: 40px;" class="well well-sm">
        <div onclick="placeClicked('<%= place.getLatitude() %>', '<%= place.getLongitude() %>','<%=place.getPlaceName()%>');">
            <li><%= place.getPlaceName() %> </li>
        </div>
        </div>
        <%
                    count++;
                }
            }
        %>
    </ul>
    <div id="markerInputs" style="width:50%; bottom:0px;left:0px; padding: 10px;"></div>
</div>    
</body>
    
<body>
    <div id="map" style="width:100%;height:100vh; margin: 0 auto; float : Right">
    
    
    <script type="text/javascript">
	    map = new naver.maps.Map('map', {
		    center: new naver.maps.LatLng(37.5714, 126.9768),
		    zoom: 14
		});
        var map = new naver.maps.Map("map", {});
        var markerList = [];
        var MAX_MARKER_COUNT = 5; // 최대 마커 개수
        var selectedMarker = null; // 선택된 마커
        var myList = [];
		var placeName=[];
        if (myList === null) {
        } else if (myList.length >= MAX_MARKER_COUNT) {
            myList = myList.slice(0, MAX_MARKER_COUNT);
        }
        
        // 기존에 생성된 마커들을 지도에 표시합니다.
        for (var i = 0; i < myList.length; i++) {
            var lat = myList[i][0];
            var lng = myList[i][1];
            var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(lat, lng),
                map: map,
                draggable: true
            });
            markerList.push(marker);
            updateMarkerInputs();
            addMarkerEventListeners(marker);
        }
        
        function updateMarkerInputs() {
            var markerInputs = '';
            for(var i = 0; i <placeName.length; i++) {
                var name = placeName[i];
                markerInputs += '마커' + (i + 1) + ': (' + name + ')<br>';
            }
            document.getElementById('markerInputs').innerHTML = markerInputs;
        }

        function addMarkerEventListeners(marker) {
            naver.maps.Event.addListener(marker, 'click', function() {
                if (selectedMarker !== marker) {
                    if (selectedMarker) {
                        selectedMarker.setIcon('https://openapi.map.naver.com/openapi/v3/maps_responsive/imgs/transparent.png');
                    }
                    selectedMarker = marker;
                    selectedMarker.setIcon('https://openapi.map.naver.com/openapi/v3/maps_responsive/imgs/pin_spot2.png');
                } else {
                    var index = markerList.indexOf(marker);
                    if (index !== -1) {
                    	placeName.splice(index, 1);
                        markerList.splice(index, 1);
                        marker.setMap(null);
                        selectedMarker = null;
                        updateMarkerInputs();
                    }
                }
            });

            naver.maps.Event.addListener(marker, 'dragend', function() {
                updateMarkerInputs();
            });
        }

        function placeClicked(lat, lng, name) {
            if (myList === null) {
                myList = [];
            } else if (myList.length >= MAX_MARKER_COUNT) {
            	console.log(myList);
                return; // 마커 개수가 제한에 도달한 경우 마커 생성하지 않음
            }
            for(var i = 0 ; i < myList.length; i++){ // 마커가 이미 찍힌지 비교
            	if(name ==placeName[i])return;
            }
           
            placeName.push(name);
            myList.push(placeName);
            
            var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(lat, lng),
                map: map,
                draggable: true
            });
            markerList.push(marker);
            updateMarkerInputs();
            addMarkerEventListeners(marker);

            // 첫 번째 마커로 지도를 이동합니다. -x
          
            map.setCenter(marker.getPosition());
        
        }
    </script>
	
   
</body>
</html>
