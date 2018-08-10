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
		String modifyPw = request.getParameter("modifyPw");
		String user_nickname = request.getParameter("user_nickname");
		String user_email = request.getParameter("email1") + "@" + request.getParameter("email2");
		String before_user_email = request.getParameter("user_email");
		
		System.out.println(user_email);
		
		if(user_email.equals("@")) {
			user_email = before_user_email;
		}

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

		String sql = "UPDATE ss_member SET user_pw='" + modifyPw + "', user_email='" + user_email + "', user_nickname='" + user_nickname + "' WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
		//UPDATE 테이블명 SET 필드명='변경할값' WHERE 필드명=해당값;

		PreparedStatement ps = conn.prepareStatement(sql);
		
		ps.executeUpdate();
	%>
</body>
</html>
