<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.* , java.util.Date" %>
	<%
		request.setCharacterEncoding("UTF-8");

		String u_id = (String) session.getAttribute("UID");
		String u_name =(String) session.getAttribute("UName");
		String res_name =  (String) session.getAttribute("res_name");
		String res_phone = (String) session.getAttribute("res_phone");
		
		Connection con = null;
		
		Statement stmt = null;
		Statement stmt2 = null;

		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		
		con = ds.getConnection();
		stmt2 = con.createStatement();
		int count = 0;
		String outText = "";
		
		try{
			ResultSet result2 = stmt2.executeQuery("select avgscore_star_point,menu from restaurant_DB where res_name='"+res_name+"' and phone='"+res_phone+"';");
			result2.next();
			String starpoint = result2.getString(1);
			String menu = result2.getString(2);
        	if(stmt2 != null)
				stmt2.close();

    		stmt = con.createStatement();
			ResultSet result = stmt.executeQuery("select * from restaurant_favor_DB where user_id='"+u_id+
												"' and res_name='"+res_name+
												"' and phone='"+res_phone+"';");
			while(result.next()){
				count+=1;
			}
			if(count == 0){
				stmt.execute("INSERT INTO restaurant_favor_DB VALUES('"+u_id+"','"+res_name+"','"+res_phone+"','"+starpoint+"','"+menu+"');");
				outText = u_name+"님<br>"+"가게명 : "+res_name+"<br>"+"별점 : "+starpoint+"<br>"+"메뉴 : "+menu+"<br>"+"즐겨찾기 등록 되었습니다.<br>";
			}
			else{
				outText = "동일한 즐겨찾기는 이미 등록되었습니다.<br>";
			}
		} catch(Exception e){
            //데이터베이스 삽입 오류시 표시할 페이지 삽입
            out.println("데이터베이스 조회에 문제가 있음<hg>");
            out.println(e.toString());
            e.printStackTrace();
    	} finally {
        	if(stmt != null)
            	stmt.close();
			if(stmt != null)
				stmt2.close();
        	if(con != null)
            	con.close();
    	}
	%>
<!DOCTYPE html>
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
                text-shadow: 4px 4px #a0dab6;
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
				margin-top : 10px;
				background-color : #FFD700;
				cursor : pointer;
			}
			label {
				font-size : 17px;
				font-weight : bold;
			}
			P {
				font-size : 20px;
			}
		</style>
	</head>
	<body>
		<header>
			<h3>즐겨찾기 등록 결과</h3>
		</header>
		<p><%=outText%></P>
		<button type="button" onclick="home()">홈으로</button>
	</body>
</html>