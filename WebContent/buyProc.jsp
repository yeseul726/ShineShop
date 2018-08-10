<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
	
	Statement stmt = conn.createStatement();
	
	sql = "INSERT INTO ss_buy(item_id, total_price, delivery_name, delivery_address, delivery_phonetel, delivery_hometel, delivery_memo, user_id, buy_date) VALUES(?, ?, ?, ?, ?, ?, ?, ?, now())";
	
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setString(1, item_id);
	ps.setString(2, total_price);
	ps.setString(3, delivery_name);
	ps.setString(4, delivery_address);
	ps.setString(5, delivery_phonetel);
	ps.setString(6, delivery_hometel);
	ps.setString(7, delivery_memo);
	ps.setString(8, (String)application.getAttribute("user_id"));
	ps.executeUpdate();

	//sql = "INSERT INTO ss_buy(item_id, total_price, delivery_name, delivery_address, delivery_phonetel, delivery_hometel, delivery_memo) VALUES(?, ?, ?, ?, ?, ?, ?)";

	sql = "SELECT item_buyCnt FROM ss_item WHERE item_id='" + item_id + "'";
	
	//out.println(sql);

	ResultSet cnt_rs = stmt.executeQuery(sql);
	
	cnt_rs.next();
	
	int upCnt = cnt_rs.getInt("item_buyCnt") + 1;
	
	sql = "UPDATE ss_item SET item_buyCnt='" + upCnt + "' WHERE item_id='" + item_id + "'";
	
	//out.println(sql);
	
	ps = conn.prepareStatement(sql);
	
	//String sql = "UPDATE " + tableName + " SET " + recom + "'"
	//UPDATE 테이블명 SET 필드명='변경할값' WHERE 필드명=해당값;
	
	ps.executeUpdate();
	
	%><script>alert("주문이 완료되었습니다."); location.href="indexProc.jsp";</script><%
%>
</body>
</html>
