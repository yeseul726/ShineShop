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

		String sql = "DELETE from ss_member WHERE user_id='" + (String)application.getAttribute("user_id") + "'";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.executeUpdate();
	%>
	<script>
		alert("그동안 ShineShop을 이용해주셔서 감사합니다.");
		<% application.removeAttribute("user_id"); %>
	</script>
	<meta http-equiv="refresh" content="0;url=indexProc.jsp">
</body>
</html>
