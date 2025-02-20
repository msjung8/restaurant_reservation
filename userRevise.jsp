<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>

<%
        String id = (String) session.getAttribute("UID");
        String pass = "";
        String name = "";
        String phone = "";
        String address = "";
        Connection con = null;
        Statement stmt = null;

        try {
                InitialContext ctx = new InitialContext();
                DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
                con = ds.getConnection();
                stmt = con.createStatement();
                ResultSet result = stmt.executeQuery("select * from userTable WHERE id='"+id+"';");
                while(result.next()){
                        pass = result.getString("pass");
                        name = result.getString("name");
                        phone = result.getString("phone");
                        address = result.getString("address");
                }
            } catch(Exception e){
                out.println("데이터베이스 조회에 문제가 있음<hg>");
                out.println(e.toString());
                e.printStackTrace();
            } finally {
                if(stmt != null)
                    stmt.close();
                if(con != null)
                    con.close();
            }
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>유저 개인정보 수정</title>
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
				width : 100px;
				height : 30px;
				font-size : 13px;
				font-weight : bold;
				background-color : #FFD700;
				cursor : pointer;
			}
			label {
				font-size : 17px;
				font-weight : bold;
			}
                        input.block{
                                background-color : lightgray;
                        }
                </style>
                <script>
                        function home(){
                                window.open("prototype.jsp", "_self");
                        }
                        function checkStep(){
                                var pass = document.getElementById("pass");
                                var name = document.getElementById("name");
                                
                                if(pass.value == "" | pass.value == "" ){
                                        alert("비밀번호를 입력해주세요");
                                        pass.focus();
                                        return false;
                                }
                                else if(name.value == "" | name.value == " "){
                                        alert("이름을 입력해주세요");
                                        name.focus();
                                        return false;
                                }
                                return true;
                        }
                </script>
	</head>
	<body>
                <header>
                        <h2>유저 개인정보 수정 페이지입니다.</h2>
                </header>
		<hr>
                <form method="get" action="userRevise_DB.jsp">
                        <label for="id">아이디<span>*</span>:</label>
                        <input type="text" name="id" value="<%=id%>" readonly class="block"><br>
                        <label for="pass">비밀번호<span>*</span>:</label>
                        <input type="password" name="pass" value="<%=pass%>" maxlength="45" id="pass"><br>
                        <label for="name">이름<span>*</span>:</label>
                        <input type="text" name="name" value="<%=name%>" maxlength="45" id="name"><br>
                        <label for="phone">전화번호:</label>
                        <input type="text" name="phone" value="<%=phone%>" maxlength="45"><br>
                        <label for="address">주소:</label>
                        <textarea cols="30" rows="3" maxlength="200" name="address"><%=address%></textarea><br>
                        <button type="submit" onclick="return checkStep()">수정하기</button><button type="button" onclick="home()">홈으로</button>
                </form>
        <br>
        <h3><span>*</span>표시 항목은 빈칸으로 두지말고 반드시 입력해주세요</h3>
	</body>
</html>