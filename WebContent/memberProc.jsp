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
<link rel="stylesheet" href="css/bootstrap.css">
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
%>
<script>
	function check(user_id) {
		if (confirm("삭제하시겠습니까?") == true) { //확인
			location.href="memberDelete.jsp?user_id=" + user_id;
			<%-- <%
			String sql = "DELETE FROM trb_member WHERE user_id='" + %>user_id<% + "'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			%> --%>
			
		} else { //취소
			return;
		}
	}
</script>
<style>
.btnType {
	background-color: #ffffff;
	padding-left: 15px;
	padding-right: 15px;
	font-size: 13px;
	color: #303030;
	border: 1px solid #aeaeae;
	height: 30px;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		Statement stmt = conn.createStatement();

		String sql = "SELECT * FROM ss_member";

		ResultSet rs = stmt.executeQuery(sql);
	%>
	<form action="memberDelete.jsp" method="post" name=memberDelete">
	<div align="center">
		<h1 style="margin-top: 50px;">회원 관리</h1>
		<table class="table table-hover" style="width: 75%; margin-top: 50px;">
			<tr>
				<th>이름</th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이메일</th>
				<th>가입날짜</th>
				<th>비고</th>
			</tr>
			<%
				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString("user_name")%></td>
				<td><%=rs.getString("user_id")%></td>
				<td><%=rs.getString("user_pw")%></td>
				<td><%=rs.getString("user_email")%></td>
				<td><%=rs.getString("user_regdate")%></td>
				<td><%-- <button class="btnType" onclick="check(<%= rs.getString("user_id") %>);">삭제</button> --%>
				<a href="memberDelete.jsp?user_id=<%= rs.getString("user_id") %>" class="btnType">삭제</a></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
	</form>
	<%
		
	%>
</body>
</html>
