<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%
    // 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 데이터베이스 연결 정보
    String url = "jdbc:mysql://localhost/web";
    String username = "stageus";
    String password = "1234";

    Connection conn = null;
    ResultSet rs = null;
    PreparedStatement query = null;

    // 값 받기
    String idValue = request.getParameter("login-id");
    String pwValue = request.getParameter("pw");

    int isLogin = 0;
    try {

        // Connector 파일 불러와서 MariaDB 연결
        Class.forName("com.mysql.jdbc.Driver");
    
        // DB 연결
        conn = DriverManager.getConnection(url, username, password);
        
        // 쿼리
        String sql = "SELECT u.name name FROM `user` u WHERE u.id = ? AND u.pw = ?;";

        query = conn.prepareStatement(sql);
        query.setString(1, idValue);
        query.setString(2, pwValue);
    
        // 쿼리 전송 및 결과 받기
        rs = query.executeQuery();
        
        if(rs.next()){
            String name = rs.getString("name");
            session.setAttribute("loginId", idValue);
            session.setAttribute("name", name);
%>
    <script>
        location.href = "index.jsp"
    </script>
<%            
        } else {
%>
    <script>
        alert("아이디나 비밀번호를 확인하세요!")
        history.go(-1);
    </script>
<%            
        }

    } catch (SQLException e) {
        e.getMessage();
    } finally {
        if(rs != null)
           rs.close();
        if(query != null)
           query.close();
        if(conn != null)
           conn.close();
    }

%>

</body>