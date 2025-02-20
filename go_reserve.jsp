<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.* , java.util.Date" %>
	<%
		request.setCharacterEncoding("UTF-8");

		String u_id = (String) session.getAttribute("UID");
		String u_name =(String) session.getAttribute("UName");
		String res_name =  (String) session.getAttribute("res_name");
		String res_phone = (String) session.getAttribute("res_phone");
		String date =  request.getParameter("date");
		String time = request.getParameter("time");
		String popul = request.getParameter("popul");

		Date d1 = new Date();
		d1.getYear();
		d1.getMonth();
		d1.getDate();

		Connection con = null;
		Statement stmt = null;

		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		stmt = con.createStatement();

		int count = 0;
		String outText = "";

		try{
			ResultSet result = stmt.executeQuery("select * from restaurant_reserve_DB where res_name='"+res_name+
												"' and res_phone='"+res_phone+"' and user_id='"+u_id+
												"' and res_date='"+date+"' and res_time='"+time+"';");
			while(result.next()){
				count+=1;
			}
			if(count == 0){
				stmt.execute("INSERT INTO restaurant_reserve_DB VALUES('"+res_name+
													"', '"+u_id+"', '"+res_phone+"', '"+date+"', '"+time+
													"', '"+popul+"');");
				outText = u_name+"님<br>"+"예약날자 : "+date+"<br>"+"예약시간 : "+time+"<br>"+"가게명 : "+res_name+"<br>예약 되었습니다.<br>";
			}
			else{
				outText = "동일한 시간, 동일한 레스토랑에 이미 예약을 진행하셨습니다.<br>";
			}
		} catch(Exception e){
            //데이터베이스 삽입 오류시 표시할 페이지 삽입
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
		<meta charset="UTF-8">
		<script>
			function home(){
				window.open("prototype.jsp", "_self");
			}
		</script>
		<style>
			header {
                text-align : center;
                font-size : 40px;
                text-shadow: 5px 5px #a0dab6;
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
			p {
				font-size : 17px;
			}
		</style>
	</head>
	<body>
		<header>
			<h3>예약 결과</h3>
		</header>
		<p><%=outText%></p>
		<button type="button" onclick="home()">홈으로</button>
	</body>
</html>