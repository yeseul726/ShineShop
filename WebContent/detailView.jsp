<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="itemview.css">
</head>
<%
	boolean a;
	if (application.getAttribute("user_id") == null) {
		a = true;
	} else {
		a = false;
	}
%>
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
	
	String type = request.getParameter("type");
	String item_id = request.getParameter("item_id");
	
	String sql = "SELECT * FROM ss_item WHERE item_id='" + item_id + "'";
	
	ResultSet rs = stmt.executeQuery(sql);
	
	
	rs.next();
%>
<script>
	function buy(item_id, type) {
		//alert(item_id + " " + document.getElementById("buyNum").value);
		if(<%=a%>) {
			alert('로그인이 필요한 서비스입니다.');
		} else {
			location.href="buy.jsp?item_id=" + item_id + "&buyNum=" + document.getElementById("buyNum").value + "&type=" + type;
		}
	}
</script>
    <div>
    <form action="addCart.jsp" method="post">
        <figure>
            <img src="image/<%= rs.getString("item_image") %>" alt="<%= item_id %>" width="400px">
            <div>
                <figcaption><%= item_id %></figcaption><br>
                <hr><br>
                <pre>판매가        <%= rs.getString("item_price") %>원</pre><br>
                <hr><br>
                <pre>마일리지      <%= rs.getInt("item_mileage") %> 마일</pre>
                <%
                if(rs.getInt("item_price") >= 30000) {
                	%><pre>배송비        무료 (30,000원이상 구매 시 무료)</pre><br><%
                } else {
                	%><pre>배송비        2,500원 (30,000원이상 구매 시 무료)</pre><br><%
                }
                %>
                <hr><br>
                <pre style="display: inline-block;">수량          <%-- <%= rs.getInt("item_remaining") %> --%></pre>
                <input type="number" id="buyNum" name="buyNum" size="5" value="1" min="1" max="<%= rs.getInt("item_remaining") %>"><br><br>
       <input type="hidden" name="item_id" value="<%= item_id %>">
       <input type="hidden" name="kind" value="<%= rs.getString("item_type") %>">
       <button type="submit" class="btnType2" onclick="if(<%=a%>) {alert('로그인이 필요한 서비스입니다.');} else {location.href='addCart.jsp?item_id=<%= item_id %>&kind=<%= rs.getString("item_type") %>'};">장바구니</button>
       <button type="button" onclick="buy('<%= item_id %>', '<%= type %>');" class="btnType2">구매하기</button>
            </div>
        </figure>
        </form>
    </div>
</body>
</html>