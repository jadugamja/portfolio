<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 값 받기
    String idValue = request.getParameter("login-id");
    String nameValue = request.getParameter("name");
    String emailValue = request.getParameter("email");
    String pwValue = request.getParameter("pw");
    String telValue = request.getParameter("tel");

    // Connector 파일 불러와서 MariaDB 연결
    Class.forName("com.mysql.jdbc.Driver");

    // DB 연결
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/web", "stageus", "1234");

    // 쿼리 만들기
    String sql = "INSERT INTO user (id, name, email, pw, tel)"
                 + "VALUES (?, ?, ?, ?, ?);";
    
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, nameValue);
    query.setString(3, emailValue);
    query.setString(4, pwValue);
    query.setString(5, telValue);

    // SQL 전송
    query.executeUpdate();
    query.close();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        alert("가입 성공!")
        window.location.replace('index.jsp'); 
    </script>
</head>
<body>
</body>