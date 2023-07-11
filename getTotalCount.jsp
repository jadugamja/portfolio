<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>

<%!
    private int getTotalCount() throws Exception {

        // 데이터베이스 연결 정보
        String url = "jdbc:mysql://localhost/web";
        String username = "stageus";
        String password = "1234";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int totalCount = 0;

        try {
            // Connector 파일 불러와서 MariaDB 연결
            Class.forName("com.mysql.jdbc.Driver");
        
            // DB 연결
            conn = DriverManager.getConnection(url, username, password);
    
            String query = "SELECT COUNT(1) FROM board b JOIN `user` u ON u.id = b.user_id WHERE u.del_yn != 1;";

            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } finally {
        // 자원 해제
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
            pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return totalCount;
    }
%>