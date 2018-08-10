<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
	
	String sql = "SELECT * FROM ss_member WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
	
	ResultSet rs = stmt.executeQuery(sql);
	
	rs.next();
	
	sql = "SELECT DISTINCT item_id FROM ss_buy WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
	
	Statement stmt2 = conn.createStatement();
	ResultSet item_rs = stmt2.executeQuery(sql);
	ResultSet list_rs = null;
	ResultSet count_rs = null;
	ResultSet tmp_rs = null;
	ResultSet price_rs = null;
	ResultSet a = null;
	
	String sql2 = "SELECT item_id FROM ss_buy WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
	Statement stmt3 = conn.createStatement();
	ResultSet rs2 = stmt3.executeQuery(sql2);
	
	int total = 0;
	
	while(rs2.next()) {
		sql = "SELECT * FROM ss_buy WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
		Statement tmp_stmt = conn.createStatement();
		tmp_rs = tmp_stmt.executeQuery(sql);
		tmp_rs.next();
		
		sql = "SELECT item_price FROM ss_item WHERE item_id='" + tmp_rs.getString("item_id") + "'";
		Statement price_stmt = conn.createStatement();
		price_rs = price_stmt.executeQuery(sql);
		price_rs.next();
		total += price_rs.getInt("item_price");
	}
%>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
    <style>
    	.buyList tr {
            border-top: 1px solid #C99B89;
            border-bottom: 1px solid #C99B89;
        }

        .buyList tr:nth-child(2n+1) {
            background-color: #ffe1f0;
            background-color: #F4DFD7;
        }

        .buyList td {
            text-align: center;
            padding: 10px;
            line-height: 30px;
        }

        .buyList th {
            padding: 10px;
        }

        .buyList table {
            border-collapse: collapse;
        }
    </style>
    <script>
 	   function itemDelete(item_id) {
			location.href="buyCancel.jsp?item_id=" + item_id;
 	   }
    </script>
</head>

<body>
<div style="height: 1500px;">
	<div align="center">
	<h1>MY PAGE</h1>
	</div>
    <div align="center" style="margin-top: 50px;">
        <img src="image/mypageicon.png" alt="" width="100px"><br><br><br>
        <table>
            <tr>
                <td style="width: 100px;">이름 : </td>
                <td><input type="text" value="<%= rs.getString("user_name") %>" disabled></td>
            </tr>
            <tr>
                <td>아이디 : </td>
                <td><input type="text" value="<%= rs.getString("user_id") %>" disabled></td>
            </tr>
            <tr>
                <td>주소 : </td>
                <td><input type="text" value="<%= rs.getString("user_address") %>" disabled size="100"></td>
            </tr>
            <!-- <tr>
                <td>생년월일 : </td>
                <td><input type="date" value="2000.07.26" disabled></td>
            </tr> -->
        </table><br>
        <a class="btnType2" href="modifyAcount.jsp">수정하기</a><a href="outRegister.jsp" class="btnType2">회원탈퇴</a>
    </div>
    <div align="center" style="margin-top: 150px;">
        <h1>주문내역</h1><br><br>
        <table width="700px" class="buyList">
            <tr>
            	<th>분류</th>
                <th>상품코드</th>
                <th>결제금액</th>
                <th>개수</th>
            </tr>
            <%
            	int cnt = 0;
	            while(item_rs.next()) {
	        		sql = "SELECT * FROM ss_item WHERE item_id='" + item_rs.getString("item_id") + "'";
	        		Statement list_stmt = conn.createStatement();
	        		list_rs = list_stmt.executeQuery(sql);
	        		list_rs.next();
	        		
	        		sql = "SELECT COUNT(*) FROM ss_buy WHERE item_id='" + item_rs.getString("item_id") + "' and user_id='" + (String)application.getAttribute("user_id") + "'";
	        		Statement count_stmt = conn.createStatement();
	        		count_rs = count_stmt.executeQuery(sql);
	        		count_rs.next();
	        		
	        		sql = "SELECT COUNT(*) FROM ss_buy WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
	        		Statement a_stmt = conn.createStatement();
	        		a = a_stmt.executeQuery(sql);
	        		a.next();
	        		cnt = a.getInt(1);
	        		%>
	        		<tr>
	        			<td><%= list_rs.getString("item_type") %></td>
		                <td><img width="70" src="image/<%= list_rs.getString("item_type") %>/<%= list_rs.getString("item_id") %>.jpg">&nbsp;&nbsp;&nbsp;<%= list_rs.getString("item_id") %></td>
		                <td><%= list_rs.getInt("item_price") * count_rs.getInt(1) %></td>
		                <td><input type="number" value="<%= count_rs.getInt(1) %>" min="1" style="width: 30px;" id="buyNum" name="buyNum" disabled>
		                <input type="hidden" name="item_id" value="<%= list_rs.getString("item_id") %>">
		                <button class="btnType" style="height: 40px;" onclick="itemDelete('<%= list_rs.getString("item_id") %>');">주문취소</button></td>
		            </tr>
	        		<%
	        	}
            %>
            
            <!-- <tr>
                <td><input type="checkbox" style="float: left;">CLRR17C711PW</td>
                <td>29,900</td>
                <td><input type="number" value="2" min="1" max="5" style="width: 30px;"></td>
            </tr>
            <tr>
                <td><input type="checkbox" style="float: left;">CLRR172002PW</td>
                <td>19,900</td>
                <td><input type="number" value="1" min="1" max="5" style="width: 30px;"></td>
            </tr> -->
        </table>
        <div style="margin-top: 30px; width: 600px; text-align: right;"><span>결제금액 : <%= total %>원</span><br>
        <%
        	int delivery = 0;
        	if(cnt == 0) {
        		delivery = 0;
        	} else {
        		if(total < 30000) {
            		delivery = 2500;
            	} else {
            		delivery = 0;
            	}
        	}
        %>
            <span>배송비 : <%= delivery %>원</span><br><span>총 결제금액 : <%= total + delivery %>원</span></div>
        <br><br><br>
    </div>
    </div>
</body>
</html>