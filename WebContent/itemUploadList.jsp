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
	function check(item_id) {
		if (confirm("삭제하시겠습니까?") == true) { //확인
			location.href="itemUploadDeleteProc.jsp?item_id=" + item_id;
			<%-- <%
			String sql = "DELETE FROM trb_member WHERE user_id='" + %>user_id<% + "'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			%> --%>
			
		} else { //취소
			return;
		}
	}
	
	function modifyCheck(item_id) {
		location.href="itemUploadModifyForm.jsp?item_id=" + item_id;
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

		String sql = "SELECT * FROM ss_item";

		ResultSet rs = stmt.executeQuery(sql);
	%>
	<form action="#" method="post" name=itemUploadDelete">
	<div align="center" style="height: 11000px;">
		<h1 style="margin-top: 50px;">상품 관리</h1>
		<button type="button" onclick="location.href='itemUploadForm.jsp';" class="btnType">상품 업로드</button>
		<table class="table table-hover" style="width: 75%; margin-top: 50px;">
			<tr>
				<th>고유번호</th>
				<th>분류</th>
				<th>이미지</th>
				<th>가격</th>
				<th>마일리지</th>
				<th>수량</th>
				<th>판매량</th>
				<th>비고</th>
			</tr>
			<%
				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString("item_id")%></td>
				<td><%=rs.getString("item_type")%></td>
				<td><img width="200" src="image/<%=rs.getString("item_image")%>"></td>
				<td><%=rs.getString("item_price")%></td>
				<td><%=rs.getString("item_mileage")%></td>
				<td><%=rs.getString("item_remaining")%></td>
				<td><%=rs.getString("item_buyCnt")%></td>
				<td><%-- <button class="btnType" onclick="check(<%= rs.getString("user_id") %>);">삭제</button> --%>
				<button type="button" onclick="modifyCheck('<%= rs.getString("item_id") %>');" class="btnType">수정</button>
				<button type="button" onclick="check('<%= rs.getString("item_id") %>');" class="btnType">삭제</button></td>
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
