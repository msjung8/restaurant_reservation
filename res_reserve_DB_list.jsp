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
            String res_name = (String) session.getAttribute("UName");

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

                String res_phone="";

                int count=0;
						
				ResultSet result = stmt.executeQuery("select phone from restaurant_db where id='"+u_id+"';");
				while(result.next()){
                    count+=1;
                    res_phone = result.getString(1);
                }
				
				out.print("^");
                if(count>0){

                    con2 = ds.getConnection();
				    stmt2 = con2.createStatement();

                    ResultSet result2 = stmt2.executeQuery("select * from restaurant_reserve_db where res_name='"+res_name+"' and res_phone='"+res_phone+"';");
                    while(result2.next()){
                        String user_id = result2.getString(2);
                        String date = result2.getString(4);
                        String time = result2.getString(5);
                        String popul = result2.getString(6);
                        out.print("res_name="+res_name+"user_id="+user_id+"res_phone="+res_phone+"date="+date+"time="+time+"popul="+popul+"\n");
                    }
                    
				    result2.close();
				    result.close();
                }
				
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