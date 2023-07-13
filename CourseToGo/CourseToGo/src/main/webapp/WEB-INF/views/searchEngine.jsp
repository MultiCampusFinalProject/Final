<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('#searchInput').on('input', function() {
            var query = $(this).val();
            $.ajax({
                url: '/search',
                data: { query: query },
                success: function(response) {
                    // 추천 결과를 처리하는 로직
                    // 예: 결과를 동적으로 표시하거나 자동완성 기능 구현
                    var suggestions = response;  // 응답으로 받은 추천 결과
                    var suggestionsHtml = "";   // 결과를 표시할 HTML 문자열

                    // 추천 결과를 HTML로 생성
                    for (var i = 0; i < suggestions.length; i++) {
                        suggestionsHtml += "<p>" + suggestions[i] + "</p>";
                    }

                    // 결과를 표시할 위치에 HTML 추가
                    $('#suggestions').html(suggestionsHtml);
                }
            });
        });
    });
</script>

<input type="text" id="searchInput" placeholder="검색어를 입력하세요">
<div id="suggestions"></div>


</body>
</html>