<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>

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

    String idValue = (String)session.getAttribute("loginId");
    
    List<Map> list = new ArrayList<Map>();
    Map<String, Object> map;
    
    try {

        // Connector 파일 불러와서 MariaDB 연결
        Class.forName("com.mysql.jdbc.Driver");
    
        // DB 연결
        conn = DriverManager.getConnection(url, username, password);
        
        // 쿼리
        String sql = "SELECT u.id, u.name, u.email, u.tel from `user` u WHERE u.id = ? AND u.del_yn != 1;";

        query = conn.prepareStatement(sql);
        query.setString(1, idValue);
    
        // 쿼리 전송 및 결과 받기
        rs = query.executeQuery();
        
        if(rs.next()){
            map = new HashMap<String, Object>();

            String id = rs.getString("id"); 		    // 사용자 ID
            String name = rs.getString("name");         // 이름
            String email = rs.getString("email");       // 이메일
            String tel = rs.getString("tel");           // 전화번호
    
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

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이 페이지</title>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/modal.css">
    <script src="js/main.js"></script>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <div class="h-inner">
            <div class="logo">
                <a href="#" class="">
                    home
                </a>
            </div>
            <div class="box-2">?????</div>
            <ul class="login-container">
            <%
                if(isLogin) {
            %>
                <li>
                    <button class="logout-btn">
                        <span class="h-text">LOGOUT</span>
                    </button>
                    <button class="profile-btn">
                        <span class="h-text">마이 페이지</span>
                    </button>
                </li>
            <%
                } else {
            %>
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
            <%
                }
            %>
            </ul>
        </div>
    </header>
    <!-- //헤더 -->
    <main>

    </main>
</body>