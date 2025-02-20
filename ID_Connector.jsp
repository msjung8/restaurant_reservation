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

		int count = 0;
		String outText = "";
		out.print("^");
		try{
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
			con = ds.getConnection();
			stmt = con.createStatement();
			
			ResultSet result = stmt.executeQuery("select * from restaurant_DB where id='"+u_id+"';");
			while(result.next()){ //레스토랑 DB맞으면
				count+=1;
			}
			if(count != 0){
				out.print("res");
			}
			else{
				result = stmt.executeQuery("select * from usertable where id='"+u_id+"';");
				while(result.next()){
					count+=1;
				}
				if(count != 0) {
					out.print("user");
				}
			}
		} catch(Exception e){
            //데이터베이스 삽입 오류시 표시할 페이지 삽입
            out.println("데이터베이스 조회에 문제가 있음<hg>");
            out.println(e.toString());
            e.printStackTrace();
    	} finally {
    		out.print("@");
        	if(stmt != null)
            	stmt.close();
        	if(con != null)
            	con.close();
    	}
	%>