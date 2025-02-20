<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    boolean isUsed = false;

    Connection con = null;
    Statement stmt = null;
    try {
        InitialContext ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
        con = ds.getConnection();
        stmt = con.createStatement();
        ResultSet result = stmt.executeQuery("select * from idInfoTable WHERE id='"+id+
                    "';");
        while(result.next()){
            isUsed = true;
        }
        if(isUsed==true){
            out.println("flag="+isUsed+"EOP");
        }
        else{
            out.println("flag="+isUsed+"EOP");
        }
    } catch(Exception e){
    } finally {
        if(stmt != null)
            stmt.close();
        if(con != null)
            con.close();
    }
%>