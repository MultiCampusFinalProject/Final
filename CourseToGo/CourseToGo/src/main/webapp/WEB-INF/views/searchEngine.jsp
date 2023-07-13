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
                    // ��õ ����� ó���ϴ� ����
                    // ��: ����� �������� ǥ���ϰų� �ڵ��ϼ� ��� ����
                    var suggestions = response;  // �������� ���� ��õ ���
                    var suggestionsHtml = "";   // ����� ǥ���� HTML ���ڿ�

                    // ��õ ����� HTML�� ����
                    for (var i = 0; i < suggestions.length; i++) {
                        suggestionsHtml += "<p>" + suggestions[i] + "</p>";
                    }

                    // ����� ǥ���� ��ġ�� HTML �߰�
                    $('#suggestions').html(suggestionsHtml);
                }
            });
        });
    });
</script>

<input type="text" id="searchInput" placeholder="�˻�� �Է��ϼ���">
<div id="suggestions"></div>


</body>
</html>