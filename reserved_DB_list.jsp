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

			Connection con = null;
			Connection con2 = null;
			Statement stmt = null;
			Statement stmt2 = null;
					
			int cnt2=0;
			try{
				InitialContext ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
				con = ds.getConnection();
				stmt = con.createStatement();
						
				ResultSet result = stmt.executeQuery("select * from restaurant_reserve_db where user_id='"+u_id+"';");
						
				int count=0;	
				out.print("^");
				while(result.next()){
					count+=1;
					String res_name = result.getString(1);
					String user_id = result.getString(2);
					String res_phone = result.getString(3);
					String date = result.getString(4);
					String time = result.getString(5);
					String popul = result.getString(6);
							
					//
					con2 = ds.getConnection();
					stmt2 = con2.createStatement();
							
					ResultSet result2 = stmt2.executeQuery("select address from restaurant_db where res_name='"+res_name+"' and phone='"+res_phone+"';");
					result2.next();
					String addr = result2.getString(1);

					//
					out.print("res_name="+res_name+"user_id="+user_id+"res_phone="+res_phone+"date="+date+"time="+time+"popul="+popul+"address="+addr+"\n");
					result2.close();
				}
				result.close();
				
			} catch(Exception e){
				e.printStackTrace();
				if(stmt != null)
					stmt.close();
				if(stmt2 != null)
					stmt2.close();
				if(con != null)
					con.close();
				if(con2 != null)
					con2.close();
			} finally{
				out.print("@");
				if(stmt != null)
					stmt.close();
				if(stmt2 != null)
					stmt2.close();
				if(con != null)
					con.close();
				if(con2 != null)
					con2.close();
			}
		%>
	</body>
</html>