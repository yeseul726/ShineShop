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
	request.setCharacterEncoding("utf-8");
	String item_id = request.getParameter("item_id");
	
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
	
	String sql = "DELETE FROM ss_item WHERE item_id='" + item_id + "'";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.executeUpdate();
	
	sql = "DELETE FROM ss_cart WHERE item_id='" + item_id + "'";
	PreparedStatement ps2 = conn.prepareStatement(sql);
	ps2.executeUpdate();
	
	%><script>alert("삭제되었습니다."); location.href="itemUploadList.jsp";</script><%
%>
</body>
</html>
