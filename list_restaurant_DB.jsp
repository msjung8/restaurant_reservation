<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String search1 =request.getParameter("tag");
	Connection con = null;
	Statement stmt = null;
	try{
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		con = ds.getConnection();
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select * from restaurant_db where menu like'%"+search1+"%';");
		
		out.print("^");//시작기호
		while(result.next()){
			String res_name = result.getString(3);
			String phone = result.getString(4);
			String addr = result.getString(5);
			String menu = result.getString(6);
			session.setAttribute("resname",res_name);
			session.setAttribute("resnumber",phone);
			
			out.println("res_name="+res_name+"res_phone="+phone+"address="+addr+"menu="+menu);
		}	
		result.close();
	} catch(Exception e){
		e.printStackTrace();
	} finally{
		out.print("@"); //끝내는 기호
		if(stmt != null)
			stmt.close();
		if(con != null)
			con.close();
	}
%>
	