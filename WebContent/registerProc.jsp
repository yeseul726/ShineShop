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
		String user_name = request.getParameter("user_name");
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String user_email = request.getParameter("email1") + "@" + request.getParameter("email2");
		String user_nickname = request.getParameter("user_nickname");
		String user_tel = request.getParameter("user_tel1") + "-" + request.getParameter("user_tel2") + "-" + request.getParameter("user_tel3");
		String user_address = request.getParameter("user_address");

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

		sql = "INSERT INTO ss_member(user_name, user_id, user_pw, user_nickname, user_email, user_tel, user_address) VALUES(?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement ps = conn.prepareStatement(sql);

		ps.setString(1, user_name);
		ps.setString(2, user_id);
		ps.setString(3, user_pw);
		ps.setString(4, user_nickname);
		ps.setString(5, user_email);
		ps.setString(6, user_tel);
		ps.setString(7, user_address);
		ps.executeUpdate();
		
		%><script>alert("<%= user_name %>(<%= user_id %>)님 환영합니다!\n새로운 아이디는 '<%= user_id %>'입니다.");</script><%
	%>
</body>
</html>
