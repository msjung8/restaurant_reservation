<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>logIn.jsp 파일</title>
	</head>
	<body>
        <%
            request.setCharacterEncoding("UTF-8");
            String id = request.getParameter("id");
            String pass = request.getParameter("pass");
            int count = 0;
            String flag = "true";
            String isUser = "false";
            Connection con = null;
            Statement stmt = null;
            Statement stmt2 = null;
            try {
                InitialContext ctx = new InitialContext();
                DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
                con = ds.getConnection();
                stmt = con.createStatement();
                stmt2 = con.createStatement();

                ResultSet result = stmt.executeQuery("select * from idInfoTable WHERE id='"+id+
                    "' and pass='"+pass+"';");
                while(result.next()){
                	session.setAttribute("UID",id);
                	session.setAttribute("UName", result.getString("name"));
                    out.print("name="+result.getString("name"));
                    count++;
                }

                ResultSet result2 = stmt2.executeQuery("select * from userTable WHERE id='"+id+"';");
                while(result2.next()){
                    isUser = "true";
                }
                if(count == 0){
                    flag = "false";
                }
                out.println("flag="+flag+"isUser="+isUser+"EOP");
            } catch(Exception e){
                out.println("데이터베이스 조회에 문제가 있음<hg>");
                out.println(e.toString());
                e.printStackTrace();
            } finally {
                if(stmt != null)
                    stmt.close();
                if(stmt2 != null)
                    stmt2.close();
                if(con != null)
                    con.close();
            }
        %>
	</body>
</html>