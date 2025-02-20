<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.* , java.util.Date" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
        <script>
            function home(){
				window.open("prototype.jsp", "_self");
			}
			function checkStep(){
				var star = document.getElementById("starpoint");
				var review = document.getElementById("review");

				if(star.value == "" | star.value == " "){
					alert("별점을 입력해주세요");
					star.focus();
					return false;
				}
				else if(star.value < 1 | star.value > 5){
					alert("별점은 1~5점으로 입력해주세요");
					star.value="";
					star.focus();
					return false;
				}
				else if(review.value == "" | review.value == " "){
					alert("리뷰를 적어주세요");
					return false;
				}
				return true;
			}
        </script>
		<style>
			header {
                text-align : center;
                font-size : 30px;
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
		</style>
	</head>
	<body>
		<%request.setCharacterEncoding("UTF-8");%>
		<%
			String u_id = (String) session.getAttribute("UID");
			String u_name = (String) session.getAttribute("UName");
			String r_name =  request.getParameter("res_name");
			String r_phone = request.getParameter("res_phone");
			
			session.setAttribute("res_name",r_name);
			session.setAttribute("res_phone",r_phone);

		%>
		<header>
			<h2>레스토랑 리뷰 작성 페이지입니다.</h2> 
		</header>
		<hr>
		<h3><%=r_name%></h3>
		<hr>
        <form method="get" action="add_reviewData.jsp">
            <label for="starpoint">별점:</label>
            <input type="text" placeholder="1~5점 사이의 별점을 입력해주세요" name="starpoint" maxlength="1" id="starpoint"><br>
            <label for="review">리뷰</label>
            <textarea cols="40" rows="5" maxlength="200" placeholder="200자 이내로 리뷰를 입력해주세요" name="review" id="review"></textarea>
            <br>
            <button type="submit" onclick="return checkStep()">리뷰 작성</button><button type="button" onclick="home()">홈으로</button>
        </form>
	</body>
</html>