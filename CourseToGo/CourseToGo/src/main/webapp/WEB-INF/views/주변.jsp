<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>API 호출 예시</title>
</head>
<body>

<%
    // 네이버 API 호출에 필요한 클라이언트 아이디와 클라이언트 시크릿
    String clientId = "fg_SKSMEpklMJCNOFtAq";
    String clientSecret = "Lp9AL8pcfk";

    // API 호출을 위한 URL
    String apiUrl = "https://openapi.naver.com/v1/search/local.xml?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=random";

    // API 호출을 위한 HTTP 요청 객체 생성
    java.net.URL url = new java.net.URL(apiUrl);
    java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("X-Naver-Client-Id", clientId);
    conn.setRequestProperty("X-Naver-Client-Secret", clientSecret);

    // API 응답 코드 확인
    int responseCode = conn.getResponseCode();

    // API 응답 데이터 읽기
    java.io.BufferedReader br = new java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream()));
    String line;
    StringBuilder sb = new StringBuilder();
    while ((line = br.readLine()) != null) {
        sb.append(line);
    }
    br.close();

    // API 응답 데이터를 화면에 출력
    out.println(sb.toString());
%>

</body>
</html>