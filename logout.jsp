<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
  // 세션 무효화 (로그아웃)
  session.invalidate();
%>

<head>
  <meta charset="UTF-8">
  <title>로그아웃</title>
</head>
<body>
    <script>
        alert("로그아웃되었습니다")
        setTimeout(function(){ window.location.replace('index.jsp') }, 100);
    </script>
</body>