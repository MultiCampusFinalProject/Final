<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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

var areaName = urlParams.get('areaName'); // "ȫ��"
document.getElementById("area").innerHTML = areaName;

};
</script>
<body>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.js"></script>
<!-- �������� �ּ�ȭ�� �ֽ� CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- �ΰ����� �׸� -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- �������� -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- �������� �ּ�ȭ�� �ֽ� �ڹٽ�ũ��Ʈ -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<div  class='middle'>





<div><form id="saveMark" action="/saveMarker" method="POST">
        <input type="hidden" name="placeId1" value="1">
        <input type="hidden" name="placeId2" value="2">
        <input type="hidden" name="placeId3" value="3">
        <input type="hidden" name="placeId4" value="4">
        <input type="hidden" name="placeId5" value="5">
        <input type="hidden" name="courseName" value="myCourse">
        <input id= "courseNumber" type="hidden" name="courseNumber" >
        <button type="submit">����</button>
    </form>
    
    </div>
    <script>
    
    
    
    document.getElementById("saveMark").addEventListener("submit", function(event) {
        // �߰� ������ �����մϴ�.
       
        event.preventDefault();
        console.log("�˻� ��ư�� ���Ƚ��ϴ�!");
        var inputElement = document.getElementById("courseNumber");
        inputElement.value = placeName.length;
      	

        
         // �⺻ ������ ���� ���� �̺�Ʈ�� �⺻ ������ ����մϴ�.
    });
    </script>
    
    <div id="map" style="width:75%;height:930px; margin: 0 auto; float : Right">
    
    
    <script type="text/javascript">
	    map = new naver.maps.Map('map', {
		    center: new naver.maps.LatLng(37.5714, 126.9768),
		    zoom: 14
		});
        var map = new naver.maps.Map("map", {});
        var markerList = [];
        var MAX_MARKER_COUNT = 5; // �ִ� ��Ŀ ����
        var selectedMarker = null; // ���õ� ��Ŀ
        var myList = [];
		var placeName=[];
        if (myList === null) {
        } else if (myList.length >= MAX_MARKER_COUNT) {
            myList = myList.slice(0, MAX_MARKER_COUNT);
        }
        
        // ������ ������ ��Ŀ���� ������ ǥ���մϴ�.
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
                markerInputs += '��Ŀ' + (i + 1) + ': (' + name + ')<br>';
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
                return; // ��Ŀ ������ ���ѿ� ������ ��� ��Ŀ �������� ����
            }
            for(var i = 0 ; i < myList.length; i++){ // ��Ŀ�� �̹� ������ ��
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

            // ù ��° ��Ŀ�� ������ �̵��մϴ�. -x
          
            map.setCenter(marker.getPosition());
        
        }
    </script>
</div>

    <h2>������,������ �˻�</h2>
   <form id="searchForm" method="get" action="/jSearchAC" accept-charset="utf-8">
    <input type="text" id="areaName" name="areaName" placeholder="�˻�� �Է��ϼ���">
    <input type="text" id="categoryName" name="categoryName" placeholder="�˻�� �Է��ϼ���">
    <button type="submit">�˻�</button>
</form>

<script>
    document.getElementById("searchForm").addEventListener("submit", function(event) {
        // �߰� ������ �����մϴ�.
        event.preventDefault(); 
        console.log("�˻� ��ư�� ���Ƚ��ϴ�!");
        var elements = document.getElementsByClassName("well well-sm");
        while (elements.length > 0) {
            elements[0].parentNode.removeChild(elements[0]);
          }
        this.submit();
      
        // ���� ������ �����մϴ�.
      

        
       // �⺻ ������ ���� ���� �̺�Ʈ�� �⺻ ������ ����մϴ�.
    });
    
    
</script>

    <h2 id ="area"></h2><h2>   �˻����</h2>
    <ul>
        <%
            List<PlaceDTO> places = (List<PlaceDTO>) request.getAttribute("placesByAreaOrCategory");
            if (places != null) {
                int count = 0;
                for (PlaceDTO place : places) {
                    if (count >= 10) {
                        break; // 5�� �̻� �ݺ����� �ʵ��� ����
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
	
    
</body>
</html>
