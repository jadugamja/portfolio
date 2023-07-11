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

%>