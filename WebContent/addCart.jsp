<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String item_id = request.getParameter("item_id");
		String kind = request.getParameter("kind");
		int buyNum = Integer.parseInt(request.getParameter("buyNum"));

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
		//out.println("DB연결성공!!");

		String sql = "";

		sql = "INSERT INTO ss_cart(user_id, item_id) VALUES(?, ?)";

		PreparedStatement ps = conn.prepareStatement(sql);

		ps.setString(1, (String)application.getAttribute("user_id"));
		ps.setString(2, item_id);
		
		for(int i = 0; i < buyNum; i++) {
			ps.executeUpdate();
		}

		
		%><script>
		if (confirm("장바구니에 성공적으로 담았습니다. 장바구니로 이동하시겠습니까?") == true){    //확인
			location.href="cart.jsp";
		}else{   //취소
			location.href="detailView.jsp?type=<%= kind %>&item_id=<%= item_id %>";
		}</script><%
	%>
</body>
</html>
