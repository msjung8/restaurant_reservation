<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
		<%
			request.setCharacterEncoding("UTF-8");
			
			String u_id = (String) session.getAttribute("UID");
			String u_name =(String) session.getAttribute("UName");
			
			String r_name = (String) session.getAttribute("res_name");
			String r_phone = (String) session.getAttribute("res_phone");

			Connection con = null;
			Connection con2 = null;
			Statement stmt = null;
			Statement stmt2 = null;
			Statement stmt3 = null;
			Statement stmt4 = null;
			PreparedStatement  stmt5 = null;
			int cnt2=0;
			try{
				InitialContext ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
				con = ds.getConnection();
				stmt = con.createStatement();
				//DB에 리뷰 별점 평균 update하기
				stmt2 = con.createStatement();
				stmt3 = con.createStatement();
				stmt4 = con.createStatement();
				
				
				ResultSet result2 = stmt2.executeQuery("select * from restaurant_db;");
				while(result2.next()){
					String rest_name = result2.getString(3);				
					String rest_phone = result2.getString(4);
					float sum_starpoint=0;
					int cnt=0;
					ResultSet result3 = stmt3.executeQuery("select star_point from restaurant_review_db where res_name ='"+rest_name+"' and res_phone ='"+rest_phone+"';");
					while(result3.next()){
						sum_starpoint += Float.parseFloat(result3.getString(1));
						cnt+=1;
					}
					String avg_starpoint = String.valueOf(sum_starpoint /= cnt);
					String sql="UPDATE restaurant_db set avgscore_star_point='"+avg_starpoint+"' where res_name='"+rest_name+"';";

					stmt5 = con.prepareStatement(sql);
					stmt5.executeUpdate();
					stmt5.close();
					//ResultSet result4 = stmt4.executeUpdate("UPDATE restaurant_db set avgscore_star_point='"+avg_starpoint+"' where res_name='"+rest_name+"';");
				}
				//여기까지 수행.
				//DB에서 값 가져오기
				ResultSet result = stmt.executeQuery("select * from restaurant_review_db where res_name='"+r_name+"' and res_phone='"+r_phone+"';");
				
				int count=0;	
				out.print("^");
				while(result.next()){
					count+=1;
					String res_name = result.getString(1);
					String res_phone = result.getString(2);
					String user_id = result.getString(3);
					String user_name = result.getString(4);
					String star_point = result.getString(5);
					String res_review = result.getString(6);
					out.print("res_name="+res_name+"user_name="+user_name+"star_point="+star_point+"res_review="+res_review+"\n");
				}
				result.close();
			} catch(Exception e){
					e.printStackTrace();
			} finally{
				out.print("@");
				if(stmt != null)
					stmt.close();
				if(stmt2 != null)
					stmt2.close();
				if(stmt3 != null)
					stmt3.close();
				if(stmt4 != null)
					stmt4.close();
				if(con != null)
					con.close();
				if(con2 != null)
					con2.close();
			}
		%>
	</body>
</html>