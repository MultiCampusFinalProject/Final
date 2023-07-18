<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.spring.dto.PlaceDTO" %> 
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="javax.servlet.http.HttpServletRequest" %>
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
      <input class="left input" type="text" id="areaName" name="areaName" placeholder="지역명 ex)홍대">
      <input class="left input" type="text" id="categoryName" name="categoryName" placeholder="업종명 ex)음식점">
      <button class="left button" type="submit">검색</button>
    </form>
  </div>
  
   <div class="sidebar2" >
    <form id="saveMark" action="/saveMarker" method="POST" accept-charset="UTF-8">
     <input type="hidden" id="placeId1" name="placeId1" value=>
     <input type="hidden" id="placeId2" name="placeId2" value=>
     <input type="hidden" id="placeId3" name="placeId3" value=>
     <input type="hidden" id="placeId4" name="placeId4" value=>
     <input type="hidden" id="placeId5" name="placeId5" value=>
     <textarea class="userGuide" readonly>
      &#8595;코스제작 가이드 &#8595;
      
&#10112;좌측 상단 검색창을 통해 검색을 해주세요.
예시 : 지역명 홍대 
	    업종명 음식점
	    
&#10113;나온 검색결과를 클릭해서 지도에 마커를 추가해서 장소를 확인하세요.(최대 5개)

&#10114;선택한 장소를 확인 후 우측 사이드바에서 코스이름 코스에 대한 설명을 작성해주세요.

&#10115;작성이 끝나면 코스만들기를 눌러서 자신만의 코스를 만들어주세요.
    </textarea>
    <input class="Coursename" id="courseName" type="text" name="courseName" value="코스 이름을 입력해주세요." onfocus="clearInputValue(this)">
	<input id="courseNumber" type="hidden" name="courseNumber">
	<textarea id="courseContent" class="courseContent" name="courseContent" required onfocus="clearTextareaValue(this)">코스에 대한 설명을 작성해주세요.</textarea>
    <button class = "submit" type="submit">코스 제작하기!</button>
    </form>
  </div> 
</div>

<script>
	function clearInputValue(input) {
	  if (input.value === input.defaultValue) {
	    input.value = '';
	  } 
	  
	}
	
	function clearTextareaValue(textarea) {
	  if (textarea.value === textarea.defaultValue) {
	    textarea.value = '';
	  }
	}
</script>

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
	        // placeId에 저장된 값을 input 박스안에 각각 집어넣어졌는지 확인.
			  document.getElementById("placeId1").value = placeId.length >=1 ?placeId[0]:null ;
			  document.getElementById("placeId2").value = placeId.length >=2 ? placeId[1] : null;
			  document.getElementById("placeId3").value = placeId.length >=3  ? placeId[2] : null;
			  document.getElementById("placeId4").value = placeId.length >=4  ? placeId[3] : null;
			  document.getElementById("placeId5").value = placeId.length >=5  ? placeId[4] : null;
	        event.preventDefault();
	        console.log("전송 버튼이 눌렸습니다!");
	        console.log(placeId);
	        
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
	<% 
	  List<PlaceDTO> places = (List<PlaceDTO>) request.getAttribute("placesByAreaOrCategory");
	  if (places != null && !places.isEmpty()) { 
	%>
	<div class="searchResults">
	  <h2 class= "resultsarea" id="area"></h2>
	  <div>
	    <ul style="display: flex; flex-direction: column; align-items: center;">
	      <% for (PlaceDTO place : places) { %>
	        <div style="display: flex; justify-content: center; align-items: center; width: 200px; height: 60px;" class="box in">
	          <div onclick="placeClicked('<%= place.getPlaceId()%>',' <%= place.getLatitude() %>', '<%= place.getLongitude() %>','<%=place.getPlaceName()%>', );">
	            <li><%= place.getPlaceName() %></li>
	          </div>
	        </div>
	      <% } %>
	    </ul>
	  </div>
	</div>
	<% } %>
	
	<div class="markerInputs" onclick="deleteMarker(event)">
	  <ul id="markerInputs" class="horizontal-list"></ul>
	</div>
	
	<div class="markerList" id="markerList" type="hidden">
	<ul type="hidden"></ul>
	</div>
	
	
	
   	<div class="displayMap">
    <div id="map" class="map">
 

<script>
  map = new naver.maps.Map('map', {
	  center: new naver.maps.LatLng(37.5714, 126.9768),
	  zoom: 16,
	  minZoom: 12,
	  maxZoom: 16
  });

  var MAX_MARKER_COUNT = 5; // 최대 마커 개수
  var selectedMarker = null; // 선택된 마커
  var markerList = [];
  var myList = [];
  var placeName = [];
  var placeId = [];

  if (myList === null) {
  } else if (myList.length >= MAX_MARKER_COUNT) {
    myList = myList.slice(0, MAX_MARKER_COUNT);
  }

  for (var i = 0; i < myList.length; i++) {
    var lat = myList[i][0];
    var lng = myList[i][1];
    var name = myList[i][2];

    var marker = new naver.maps.Marker({
      position: new naver.maps.LatLng(lat, lng),
      map: map,
      draggable: false,
      name: name,
      id: i.toString()
    });

    markerList.push(marker);

    addMarkerEventListeners(marker);
  }

  function updateMarkers() {
    updateMarkerInputs();
    updateMarkerList();
  }

  function updateMarkerInputs() {
    var markerInputs = '';
    for (var i = 0; i < placeName.length; i++) {
      var name = placeName[i];
      markerInputs += '<li>' + (i + 1) + ' ' + name + '</li>';
    }
    document.getElementById('markerInputs').innerHTML = markerInputs;
  }

  function updateMarkerList() {
    var markerListHTML = '';
    for (var i = 0; i < markerList.length; i++) {
      var marker = markerList[i];
      var markerName = placeName[i];
      if (markerName) {
        markerListHTML += '<li>' + (i + 1) + ' ' + markerName + '</li>';
      }
    }
    document.getElementById('markerList').innerHTML = markerListHTML;
  }

  var selectedMarker = null;

  function addMarkerEventListeners(marker) {
    naver.maps.Event.addListener(marker, 'click', function () {
      var index = markerList.indexOf(marker);
      if (index !== -1) {
        marker.setMap(null);
        markerList.splice(index, 1);
        placeName.splice(index, 1);
        placeId.splice(index, 1);
        myList.splice(index, 1);
        selectedMarker = null;
        updateMarkers();
        updateMarkerOrder();
        console.log("Marker removed");
        console.log("markerList:", markerList);
        console.log("placeName:", placeName);
        console.log("placeId:", placeId);
        console.log("myList:", myList);
      }
    });
  

    naver.maps.Event.addListener(marker, 'dragend', function () {
      updateMarkerInputs();
    });
  }

  function deleteMarker(event) {
    var clickedIndex = Array.from(event.target.parentNode.children).indexOf(event.target);
    if (clickedIndex !== -1) {
      var markerToRemove = markerList[clickedIndex];
      if (markerToRemove) {
        markerToRemove.setMap(null);
        markerList.splice(clickedIndex, 1);
        placeName.splice(clickedIndex, 1);
        placeId.splice(clickedIndex, 1);
        myList.splice(clickedIndex, 1);
        updateMarkers();
        updateMarkerOrder();
        console.log("Marker removed");
        console.log("markerList:", markerList);
        console.log("placeName:", placeName);
        console.log("placeId:", placeId);
        console.log("myList:", myList);
      }
    }
  }

  function placeClicked(id, lat, lng, name, marker) {
    if (myList === null) {
      myList = [];
    } else if (myList.length >= MAX_MARKER_COUNT) {
      console.log(myList);
      return; // 마커 개수가 제한에 도달한 경우 마커 생성하지 않음
    }

    for (var i = 0; i < myList.length; i++) {
      // 마커가 이미 찍힌지 비교
      if (name === placeName[i]) {
        return;
      }
    }

    console.log(myList);
    var newPlace = [name, lat, lng];
    placeName.push(name);
    myList.push(newPlace);

    var markerHTML = [
      '<div class="cs_mapbridge">',
      '  <div class="map_group _map_group crs">',
      '    <div class="map_marker _marker num1 num1_big">',
      '      <span class="ico _icon">' + getCircleNumber(placeName.indexOf(name)) + name + '</span>',
      '      <span class="shd"></span>',
      '    </div>',
      '  </div>',
      '</div>'
    ].join('');

    function getCircleNumber(index) {
      var baseCharCode = 9312; // '①'의 유니코드 값
      return String.fromCharCode(baseCharCode + index);
    }

    var marker = new naver.maps.Marker({
      position: new naver.maps.LatLng(lat, lng),
      map: map,
      icon: {
        content: markerHTML,
        size: new naver.maps.Size(38, 58),
        anchor: new naver.maps.Point(19, 58),
      },
      draggable: false,
    });

    marker.index = markerList.length;
    markerList.push(marker);
    updateMarkers();
    updateMarkerOrder();
    addMarkerEventListeners(marker);

    placeId.push(id);
    map.setCenter(marker.getPosition());
  }

  function updateMarkerOrder() {
    var baseCharCode = 9312; // '①'의 유니코드 값
    for (var i = 0; i < markerList.length; i++) {
      var marker = markerList[i];
      if (marker) {
        var markerName = placeName[i];
        var circleNumber = String.fromCharCode(baseCharCode + i);
        var markerHTML = [
          '<div class="cs_mapbridge">',
          '  <div class="map_group _map_group crs">',
          '    <div class="map_marker _marker num1 num1_big">',
          '      <span class="ico _icon">' + circleNumber + markerName + '</span>',
          '      <span class="shd"></span>',
          '    </div>',
          '  </div>',
          '</div>'
        ].join('');
        marker.setIcon({
          content: markerHTML,
          size: new naver.maps.Size(38, 58),
          anchor: new naver.maps.Point(19, 58)
        });
      }
    }
  }

  updateMarkers();
</script>

	</div>   
</div>

<jsp:include page="sidebar.jsp"></jsp:include>
   
</body>
</html>
