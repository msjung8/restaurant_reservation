<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
					
	String res_name = request.getParameter("res_name");
    String u_id = request.getParameter("user_id");
    String res_phone = request.getParameter("res_phone");
    String date = request.getParameter("date");
    String time = request.getParameter("time");

	Connection con = null;
	Statement stmt = null;
					
	int cnt2=0;
	try{
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		stmt = con.createStatement();
						
		stmt.execute("DELETE from restaurant_reserve_db where res_name='"
                    +res_name+"' and user_id='"+u_id+"' and res_phone='"+res_phone+"' and res_date='"+date+"' and res_time='"+time+"';");
						
	} catch(Exception e){
		e.printStackTrace();
		if(stmt != null)
			stmt.close();
		if(con != null)
			con.close();
	} finally{
		if(stmt != null)
			stmt.close();
		if(con != null)
			con.close();
	}
%>
<html>
    <head>
        <title>삭제 결과</title>
        <style>
			header {
                text-align : center;
                font-size : 40px;
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
			span {
				color : red;
			}
			label.wrong{
				color: red;
			}
			label.right{
				color : skyblue;
			}
			button, input.button{
				width : 120px;
				height : 30px;
				font-size : 13px;
				margin-top : 10px;
				font-weight : bold;
				background-color : #FFD700;
				cursor : pointer;
			}
			label {
				font-size : 17px;
				font-weight : bold;
			}
			input.block {
				background-color : lightgray;
			}
		</style>
        <script>
            function home(){
                window.open("prototype.jsp", "_self");
            }
        </script>
    </head>
    <body>
		<header>
			<h3>삭제 결과 페이지</h3>
		</header>
        <p>삭제되었습니다.</p>
        <button type="button" onclick="home()">홈으로</button>
    </body>
</html>

