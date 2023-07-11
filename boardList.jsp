<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%@ include file="getTotalCount.jsp" %>

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

    // 현재 페이지 번호
    int currentPage = request.getParameter("currentPage") != null ? Integer.parseInt(request.getParameter("currentPage")) : 1;
    // 총 게시글 수
    int totalCount = getTotalCount();
    // 화면에 나타낼 게시글 수
    int pageSize = 10;

    // 화면에 나타낼 인덱스 처리
    int startIdx = (currentPage - 1) * pageSize; // 페이지의 시작 인덱스
    int endIdx = Math.min(startIdx + pageSize, totalCount); // 페이지의 끝 인덱스
  
    // 페이지네이션 처리
    int totalPageCount = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수

    // 페이지 링크를 생성하기 위한 변수 계산
    int pageLinkSize = 10; 
    int startPage = Math.max(currentPage - (pageLinkSize / 2), 1);
    int endPage = Math.min(startPage + pageLinkSize - 1, totalPageCount);

    // 페이지 링크 생성
    StringBuilder pageLinks = new StringBuilder();
    for (int i = startPage; i <= endPage; i++) {
        if (i == currentPage) {
            pageLinks.append("<b>").append(i).append("</b>&nbsp;");
        } else {
            pageLinks.append("<a href=\"?currentPage=").append(i).append("\">").append(i).append("</a>&nbsp;");
        }
    }

    List<Map> currentPageList = new ArrayList<Map>();
    Map<String, Object> map;

    try {

        // Connector 파일 불러와서 MariaDB 연결
        Class.forName("com.mysql.jdbc.Driver");
    
        // DB 연결
        conn = DriverManager.getConnection(url, username, password);
        
        // 전체 목록 조회 쿼리
        String sql = "SELECT ROW_NUMBER() OVER() no, b.id id, b.title title, u.name name, b.reg_date reg_date FROM board b JOIN `user` u ON u.id = b.user_id WHERE u.del_yn != 1 ORDER BY b.id DESC LIMIT ?, ?";

        query = conn.prepareStatement(sql);
        query.setInt(1, startIdx);
        query.setInt(2, endIdx);

        // SQL 전송 및 값 받기
        rs = query.executeQuery();

        while(rs.next()) {
            map = new HashMap<String, Object>();
            String no = rs.getString("no"); 		    // 글 번호
            String id = rs.getString("id"); 		    // 글 아뒤
            String title = rs.getString("title");		// 제목
            String name = rs.getString("name");			// 작성자
            String regDate = rs.getString("reg_date");	// 등록일
    
            map.put("no", no);
            map.put("id", id);
            map.put("title", title);
            map.put("name", name);
            map.put("regDate", regDate);

            currentPageList.add(map);
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
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>등록일</th>
                    </tr>
                </thead>
                <tbody>
            <% for (int i = 0; i < currentPageList.size(); i++) { %>
                    <tr>
                        <td><%= currentPageList.get(i).get("no").toString() %></td>
                        <td>
                            <a href="boardDetail.jsp?id=<%= currentPageList.get(i).get("id").toString() %>">
                                <%= currentPageList.get(i).get("title").toString() %>
                            </a>
                        </td>
                        <td><%= currentPageList.get(i).get("name").toString() %></td>
                        <td><%= currentPageList.get(i).get("regDate").toString().substring(0, 10) %></td>
                    </tr>
            <% } %>
                </tbody>
            </table>
            <a href="html/boardWrite.html" class="write-btn">글쓰기</a>
            <div>
                <%-- 페이지 링크 출력 --%>
                <%= pageLinks.toString() %>
            </div>
        </main>
        <!-- //메인 -->
        <script>

        </script>
</body>
</html>