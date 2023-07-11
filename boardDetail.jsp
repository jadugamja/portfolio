<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 로그인 여부
    boolean isLogin = false;
    if(session.getAttribute("loginId") != null) {
        String name = (String)session.getAttribute("name");
        isLogin = true;
    }

    // 데이터베이스 연결 정보
    String url = "jdbc:mysql://localhost/web";
    String username = "stageus";
    String password = "1234";

    Connection conn = null;
    ResultSet rs = null;
    PreparedStatement query = null;

    // 값 받기
    int idValue = Integer.parseInt(request.getParameter("id"));;
    
    List<Map> list = new ArrayList<Map>();
    Map<String, Object> map;
    
    try {

        // Connector 파일 불러와서 MariaDB 연결
        Class.forName("com.mysql.jdbc.Driver");
    
        // DB 연결
        conn = DriverManager.getConnection(url, username, password);
        
        // 쿼리
        String sql = "SELECT b.id id, b.title title, u.name name, b.content content, b.reg_date reg_date FROM board b JOIN `user` u ON u.id = b.user_id WHERE b.id = ?;";

        query = conn.prepareStatement(sql);
        query.setInt(1, idValue);
    
        // 쿼리 전송 및 결과 받기
        rs = query.executeQuery();
        
        if(rs.next()){
            map = new HashMap<String, Object>();

            String id = rs.getString("id"); 		    // 글 아뒤
            String title = rs.getString("title");		// 제목
            String name = rs.getString("name");			// 작성자
            String content = rs.getString("content");   // 내용
            String regDate = rs.getString("reg_date");	// 등록일
    
            map.put("id", id);
            map.put("title", title);
            map.put("name", name);
            map.put("content", content);
            map.put("regDate", regDate);

            list.add(map);
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/board.css">
    <!-- <script src="../js/join.js"></script> -->
</head>
<body>
    <!-- 헤더 -->
    <header>
        <div class="h-inner">
            <div class="logo">logologo</div>
            <div class="box-2">?????</div>
            <ul class="login-container">
                <li>
                    <button class="login-btn">
                        <span class="h-text">LOGIN</span>
                    </button>
                </li>
                <li>
                    <span>&nbsp;&nbsp;·&nbsp;&nbsp;</span>
                </li>
                <li>
                    <a href="html/join.html" class="">
                        <span class="h-text">JOIN</span>
                    </a>
                </li>
            </ul>
        </div>
    </header>
    <!-- //헤더 -->

    <!-- 메인 -->
    <main>
        <nav>
            <h1 class="main-text">게시판</h1>
        </nav>
        <hr class="main-line" />
        <section>
            <h2><%= list.get(0).get("title").toString() %></h2>
            <div>
                <ul>
                    <li><%= list.get(0).get("name").toString() %></li>
                    <li><%= list.get(0).get("regDate").toString().substring(0, 10) %></li>
                </ul>
            </div>
            <hr />
            <div><%= list.get(0).get("content").toString() %></div>
        </section>
        <a href="boardUpdate.jsp" class="btn">수정</a>
        <a href="boardUpdate.jsp" class="btn">삭제</a>
    </main>
    <!-- //메인 -->
    <script>
    </script>
</body>
</html>