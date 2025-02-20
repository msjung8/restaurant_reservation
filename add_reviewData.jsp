<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.* , java.util.Date" %>
	<%
		request.setCharacterEncoding("UTF-8");

		String u_id = (String) session.getAttribute("UID");
		String u_name =(String) session.getAttribute("UName");
		String res_name =  (String) session.getAttribute("res_name");
		String res_phone = (String) session.getAttribute("res_phone");
		String starpoint =  request.getParameter("starpoint");
		String res_review = request.getParameter("review");

		Connection con = null;
		Statement stmt = null;

		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		stmt = con.createStatement();

		int count = 0;
		String outText = "";

		try{
			ResultSet result = stmt.executeQuery("select * from restaurant_review_DB where res_name='"+res_name+
												"' and res_phone='"+res_phone+"' and user_id='"+u_id+
												"' and star_point='"+starpoint+"' and res_review='"+res_review+"';");
			while(result.next()){
				count+=1;
			}
			if(count == 0){
				stmt.execute("INSERT INTO restaurant_review_DB VALUES('"+res_name+"','"+res_phone+"','"+u_id+"','"+u_name+"','"+starpoint+"','"+res_review+"');");
				outText = u_name+"님<br>"+"가게명 : "+res_name+"<br>"+"별점 : "+starpoint+"<br>"+"리뷰 : "+res_review+"<br>등록 되었습니다.<br>";
			}
			else{
				outText = "동일한 별점, 동일한 리뷰로 이미 등록했습니다.<br>";
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
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
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
			p {
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
			<h3>리뷰 등록 결과</h3>
		</header>
		<p><%=outText%></p>
		<button type="button" onclick="home()">홈으로</button>
	</body>
</html>