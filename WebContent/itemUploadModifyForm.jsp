<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.btnType {
	background-color: #ffffff;
	padding-left: 15px;
	padding-right: 15px;
	font-size: 13px;
	color: #303030;
	border: 1px solid #aeaeae;
	height: 30px;
	margin-top: 20px;
}

fieldset {
	width: 70%;
	height: 490px;
}

.button {
	border-bottom: 1px solid #695c5c;
	border-left: 0px;
	border-right: 0px;
	border-top: 0px;
	outline: none;
	background-color: #ffffff;
	font-family: "나눔고딕";
	font-size: 12pt;
	padding: 3px;
}

input {
	border-bottom: 1px solid #695c5c;
	border-left: 0px;
	border-right: 0px;
	border-top: 0px;
	outline: none;
}

textarea {
	outline: none;
	overflow: auto;
	resize: vertical;
}

.fieldset {
	border: 1px solid #9F7E69;
	padding: 30px;
	width: 70%;
}
</style>
<script>
	/* function check() {
		if (document.review.title.value != "" && document.review.comment.value) {
			alert("작성 완료!");
			location = 'review.jsp';
		} else {
			alert("제목과 내용을 입력해주세요.");
			document.review.title.focus();
		}
	} */
</script>
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
	
	Statement stmt = conn.createStatement();
	
	String item_id = request.getParameter("item_id");
	
	String sql = "SELECT * FROM ss_item WHERE item_id='" + item_id + "'";
	
	ResultSet rs = stmt.executeQuery(sql);
	
	rs.next();
%>
<div align="center">
		<h1>상품 업로드</h1>
		<div align="center" class="fieldset">
			<form action="itemUploadModifyProc.jsp" method="post"  enctype="multipart/form-data" name="itemUpload">
				<input type="hidden" name="item_id" value="<%= rs.getString("item_id") %>">
				<table>
					<tr height="20"></tr>
					<tr>
						<td width="120" align="left"><span class="txt01">상품 고유번호</span></td>
						<td align="left"><input type="text" value="<%= rs.getString("item_id") %>" disabled></td>
					</tr>
					<tr height="20"></tr>
					<tr>
						<td width="120" align="left"><span class="txt01">분류</span></td>
						<td align="left"><select name="item_type">
						<%
							String[] item_type = {"ring", "earring", "watch", "wallet", "necklace"};
							String[] item_type_kor = {"반지", "귀걸이", "시계", "지갑", "목걸이"};
							for(int i = 0; i < 5; i++) {
								if(item_type[i].equals(rs.getString("item_type"))) {
									%><option value="<%= item_type[i] %>" selected><%= item_type_kor[i] %></option><%
								} else {
									%><option value="<%= item_type[i] %>"><%= item_type_kor[i] %></option><%
								}
							}
						%>
						</select></td>
					</tr>
					<tr height="20"></tr>
					<tr>
						<td width="120" align="left" valign="top"><span class="txt01">상품 가격</span></td>
						<td align="left"><input type="number" min="0" name="item_price" value="<%= rs.getString("item_price") %>" required>원</td>
					</tr>
					<tr height="20">
						<td width="120" align="left"><span class="txt01">마일리지</span></td>
						<td align="left"><input type="number" name="item_mileage" value="<%= rs.getString("item_mileage") %>" min="0" required></td>
					</tr>
					<tr height="20">
						<td width="120" align="left"><span class="txt01">수량</span></td>
						<td align="left"><input type="number" name="item_remaining" value="<%= rs.getString("item_remaining") %>" min="1" required></td>
					</tr>
					<tr height="30">
						<td width="120" align="left"><span class="txt01">상품 이미지</span></td>
						<td align="left"><input type="file" value="<%= rs.getString("item_image") %>" name="item_image" min="1">
						</td>
					</tr>
					<tr height="30">
						<td width="120" align="left"><span class="txt01">현재 이미지</span></td>
						<td align="left"><img src="image/<%= rs.getString("item_image") %>" style="display: inline-block; border: 1px solid black;" width="200px"></td>
					</tr>
				</table>
				<div align="center">
					<input type="submit" class="btnType" name="sub" value="write"> <input type="reset" class="btnType"
						name="sub" value="reset" style="margin-bottom: 30px;">
					<button type="button" onclick="location.href='itemUploadList.jsp'" class="btnType">list</button>
				</div>
			</form>
		</div>
		<!-- </form> -->
		<br>
	</div>
	<br>
</body>
</html>
