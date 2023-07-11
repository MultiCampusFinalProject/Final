<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Places</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
 
    </script>
</head>
<body>
    <h1>장소 전체 검색</h1>
    <form id="searchForm" method="get" action="/search">
        <input type="text" id="placeName" name="placeName" placeholder="검색어를 입력하세요" >
        <button type="submit">검색</button>
    </form>


</body>
</html>
