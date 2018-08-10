<%@page import="java.sql.PreparedStatement"%>
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
</head>
<body>
	<%
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/ShineShop";
		String pid = "root";
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
		Connection conn = DriverManager.getConnection(url, pid, pwd);
		
		String item_id = request.getParameter("item_id");

		Statement stmt = conn.createStatement();

		String sql = "";
		
		sql = "DELETE FROM ss_buy WHERE user_id='" + (String)application.getAttribute("user_id") + "' and item_id='" + item_id + "'";
		//UPDATE 테이블명 SET 필드명='변경할값' WHERE 필드명=해당값;

		PreparedStatement ps = conn.prepareStatement(sql);
		
		ps.executeUpdate();
		
		%><script>alert("주문이 취소되었습니다."); location.href="mypage.jsp";</script><%
	%>
</body>
</html>
