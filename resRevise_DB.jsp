<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.* , java.util.Date" %>
	<%
		request.setCharacterEncoding("UTF-8");

		String u_id =  request.getParameter("id");
		String res_name =  request.getParameter("name");
		String res_phone = request.getParameter("phone");
		String new_password = request.getParameter("pass");
		String new_address = request.getParameter("address");
		String new_menu = request.getParameter("menu");
		
		Connection con = null;
		Statement stmt = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		Statement stmt5 = null;
		
		PreparedStatement stmt6 = null;
		
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");

		con = ds.getConnection();
		stmt = con.createStatement();
		
		int count1 = 0;
		int count2 = 0;
		int count3 = 0;
		int count4 = 0;
		int count5 = 0;
		String outText = "아이디: "+u_id+"<br>"+
						"비밀번호: "+new_password+"<br>"+
						"이름: "+res_name+"<br>"+
						"전화번호: "+res_phone+"<br>"+
						"주소: "+new_address+"<br>"+
						"메뉴: "+new_menu+"<br>로 수정하였습니다.";
		try{//1 search query
			ResultSet result = stmt.executeQuery("select * from restaurant_DB where res_name='"+res_name+"' and phone='"+res_phone+"';");
			while(result.next()){
				count1+=1;
				break;
			}
			//4
			con = ds.getConnection();
			stmt4 = con.createStatement();
			result = stmt4.executeQuery("select * from restaurant_favor_DB where res_name='"+res_name+"' and phone='"+res_phone+"';");
			while(result.next()){
				count4+=1;
				break;
			}
			//5
			con = ds.getConnection();
			stmt5 = con.createStatement();
			result = stmt5.executeQuery("select * from idinfotable where id='"+u_id+"' and name='"+res_name+"';");
			while(result.next()){
				count5+=1;
				break;
			}
			//update query 
			if(count1 != 0){//1: restaurant_DB 2:restaurant_reserve_DB 3:restaurant_review_DB, 4:restaurant_favor_DB, 5: idinfotable
				String sql1="UPDATE restaurant_DB set pass='"+new_password+"', address='"+new_address+"', menu='"+new_menu+"' where res_name='"+res_name+"' and phone='"+res_phone+"';";
				stmt6 = con.prepareStatement(sql1);
				stmt6.executeUpdate();
			}
			
			if(count4 != 0){
				String sql4="UPDATE restaurant_favor_DB set menu='"+new_menu+"' where res_name='"+res_name+"' and phone='"+res_phone+"';";
				stmt6 = con.prepareStatement(sql4);
				stmt6.executeUpdate();
			}
			if(count5 != 0){
				String sql5="UPDATE idinfotable set pass='"+new_password+"' where id='"+u_id+"' and name='"+res_name+"';";
				stmt6 = con.prepareStatement(sql5);
				stmt6.executeUpdate();
			}
			
		} catch(Exception e){
            //데이터베이스 삽입 오류시 표시할 페이지 삽입
            out.println("데이터베이스 조회에 문제가 있음<hg>");
            out.println(e.toString());
            e.printStackTrace();
    	} finally {
        	if(stmt != null)
            	stmt.close();
			if(stmt2 != null)
            	stmt2.close();
			if(stmt3 != null)
            	stmt3.close();
			if(stmt4 != null)
            	stmt4.close();
			if(stmt5 != null)
            	stmt5.close();
        	if(con != null)
            	con.close();
    	}
	%>

<html>
	<head>
		<meta charset="utf-8">
		<title>레스토랑 정보 수정 결과</title>
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
			p{
				font-size : 17px;
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
			<h3>레스토랑 정보 수정 결과</h3>
		</header>
		<p><%=outText%></p><br>
		<button type="button" onclick="home()">홈으로</button>
	</body>
</html>