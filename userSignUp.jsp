<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    String name = request.getParameter("name");

    String phone = request.getParameter("phone");
    String address = request.getParameter("address");


    Connection con = null;
    Statement stmt = null;

    try {
        InitialContext ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
        con = ds.getConnection();
        stmt = con.createStatement();

        stmt.execute("INSERT INTO userTable VALUES('"+ id + "', '" +
            pass +"', '" + name + "', '" + phone + "', '" + address + "');");
        stmt.execute("INSERT INTO idInfoTable VALUES('" + id + "', '" + pass + "', '" + name + "');");

    } catch(Exception e){
            //데이터베이스 삽입 오류시 표시할 페이지 삽입
    } finally {
        if(stmt != null)
            stmt.close();
        if(con != null)
            con.close();
    }

%>

<head>
    <title>회원가입 완료</title>
    <script>
        function home(){
            window.open("prototype.jsp", "_self");
        }
    </script>
    <style>
			header {
                text-align : center;
                font-size : 20px;
                text-shadow: 3px 3px skyblue;
            }
            header::first-letter {
                color : #FA8072;
            }
        	body {
                background-color : #F9F3E9;
                width : 800px;
                margin-left : auto;
                margin-right : auto;
            }
            hr {
                border : 1px solid #FA8072;
            }
		</style>
</head>
<body>
    <header>
        <h2>회원 가입 처리 결과</h2>
    </header>
    <hr>
    <%=name%>님, 아이디 : <%=id%>로 회원가입 되었습니다.
    <input type="button" onclick="home()" value="홈으로">
</body>
    