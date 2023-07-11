<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 로그인 여부
    boolean isLogin = false;
    if(session.getAttribute("loginId") != null) {
        String loginId = (String)session.getAttribute("loginId");
        isLogin = true;
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자기소개</title>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/modal.css">
    <script src="js/main.js"></script>
</head>
<body>
    <main>
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

        <nav>
            <ul>
                <li>
                    <a href="html/stageus.html" class="portfolio"></a>
                </li>
                <li>
                    <a href="boardList.jsp">게시판</a>
                </li>
                <!-- <li>
                    <img src="img/phone_1.png" width="38px"/>
                </li> -->
            </ul>
        </nav>
        <div class="outer-box">
            <div class="inner-box">
                <p class="inner-txt">안녕하세요! 만 1년 차 개발자 유지수입니다.</p>
            </div>
        </div>
    </main>

    <div id="login" class="modal hidden">
        <div class="modal-box">
            <div class="modal-content modal-color">
                <h1 class="modal-color">Login</h1>
                <form action="login.jsp">
                    <input type="text" name="login-id" id="login-id" class="modal-color">
                    <input type="password" name="pw" id="pw" class="modal-color" >
                    <input type="submit" id="login-btn" class="btn login-btn" value="로그인" />
                </form>
            </div>
            <button class="btn exit-btn">닫기</button>
        </div>
    </div>
</body>