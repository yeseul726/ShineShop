<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@keyframes heart_bounce {
            from,
            to {
                bottom: 150px;
                -webkit-animation-timing-function: ease-out;
            }
            0% {
                bottom: 150px;
            }
            50% {
                bottom: 450px;
                -webkit-animation-timing-function: ease-in;
            }
            100% {
                bottom: 150px;
            }
        }
</style>
</head>
<body>
	<img src="image/banner1.png"
		style="display: block; margin: 0 auto; margin-top: 50px;">
	<br>
	<div align="center">
		<a href="itemList.jsp?kind=necklace"><img
			src="image/sub_banner_necklace.png"
			style="width: 300px; margin: 40px;" alt="necklace menu"></a> <a
			href="itemList.jsp?kind=earring"><img
			src="image/sub_banner_earring.png"
			style="width: 300px; margin: 40px;" alt="earring menu"></a> <a
			href="itemList.jsp?kind=wallet"><img
			src="image/sub_banner_wallet.png" style="width: 300px; margin: 40px;"
			alt="wallet menu"></a>
	</div>
	<h1
		style="text-align: center; font-family: Nanum Gothic; color: #e67171; margin-top: 20px;">BEST
		ITEM</h1>
		<div align="center">
		<%
		request.setCharacterEncoding("utf-8");
		String item_id = request.getParameter("item_id");
		String total_price = request.getParameter("total_price");
		String delivery_name = request.getParameter("delivery_name");
		String delivery_address = request.getParameter("delivery_address");
		String delivery_phonetel = request.getParameter("tel1") + "-" + request.getParameter("tel2") + "-" + request.getParameter("tel3");
		String delivery_hometel = request.getParameter("htel1") + "-" + request.getParameter("htel2") + "-" + request.getParameter("htel3");
		String delivery_memo = request.getParameter("delivery_memo");
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/ShineShop";
		String id = "root";
		String pwd = "1234";

		try {
			//[1] JDBC 드라이버 로드
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			out.println("Where is your mysql jdbc driver?");
			e.printStackTrace();
			return;
		}
		//out.println("mysql jdbc Driver registered!!");

		//[2]데이타베이스 연결 
		Connection conn = DriverManager.getConnection(url, id, pwd);
		
		String sql = "";
		
		sql = "SELECT * FROM ss_item order by item_buyCnt desc";
		
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery(sql);
		
		for(int i = 0; i < 4; i++) {
			rs.next();
			
			%>
			<div style="display: inline-block;">
			<figure
				style="border: 1px solid #aeaeae; padding: 10px; background-color: white; transition: 0.3s; text-align: center;">
				<a href="detailView.jsp?type=<%= rs.getString("item_type") %>&item_id=<%= rs.getString("item_id") %>"
					style="text-decoration: none; color: black;"><img
					src="image/<%= rs.getString("item_image") %>" width="190px" alt="<%= rs.getString("item_id") %>">
					<figcaption><%= rs.getString("item_id") %></a>
				<br><%= rs.getString("item_price") %>원</figcaption>
			</figure>
			</div>
			<%
		}
		%>
	</div>
</body>
</html>
