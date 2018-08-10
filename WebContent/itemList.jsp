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
    <title>NECKLACE</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
    <style>
        div {
            margin: 25px;
        }

        figure {
            border: 1px solid #aeaeae;
            padding: 10px;
            background-color: white;
            transition: 0.3s;
        }

        figure:hover {
            opacity: 0.7;
        }
    </style>
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
	
	String sql = "SELECT * FROM ss_item";
	
	ResultSet rs = stmt.executeQuery(sql);
	
	String kind = request.getParameter("kind");
%>
    <div align="center">
        <h1 style="display: inline-block;"><%= kind %></h1><br><br>
        <%
        while(rs.next()) {
        	if((rs.getString("item_type")).equals(kind)) {
        %>
        <div style="display: inline-block;">
            <figure>
                <a href="detailView.jsp?type=<%= kind %>&item_id=<%= rs.getString("item_id") %>"><img src="image/<%= rs.getString("item_image") %>" width="190px" alt="<%= rs.getString("item_id") %>.jpg">
                <figcaption><%= rs.getString("item_id") %></a><br><%= rs.getString("item_price") %></figcaption>
            </figure>
        </div>
        <%
        	}
        }
        %>
    </div>
    <!--<figure>
       <img src="image/necklace1.jpg" alt="CLNR18378MPP">
       <figcaption>CLNR18378MPP</figcaption><br><hr><br>
       <pre>판매가        29,000원</pre><br><hr><br>
       <pre>마일리지      290 마일</pre>
       <pre>배송비        2,500원 (30,000원이상 구매 시 무료)</pre><br><hr><br>
       <pre>수량          </pre>
       <select name="buyNum" id="buyNum">
           <option value="1">1</option>
           <option value="2">2</option>
           <option value="3">3</option>
           <option value="4">4</option>
           <option value="5">5</option>
           <option value="num">5 +</option>
       </select><button class="btnType2">장바구니</button><button class="btnType2">구매하기</button>
   </figure><br><hr style="border: 1px dotted #cccccc;"><br>
   <figure>
       <img src="image/necklace2.jpg" alt="CLNR18473MPW">
       <figcaption>CLNR18473MPW</figcaption><br><hr><br>
       <pre>판매가        <s>19,000원</s><strong><em> <font color="red">품절</font></em></strong></pre><br><hr><br>
       <pre>마일리지      190 마일</pre>
       <pre>배송비        2,500원 (30,000원이상 구매 시 무료)</pre><br><hr><br>
       <pre>수량          </pre>
       <select name="buyNum2" id="buyNum2">
           <option value="1">1</option>
           <option value="2">2</option>
           <option value="3">3</option>
           <option value="4">4</option>
           <option value="5">5</option>
           <option value="num">5 +</option>
       </select><button class="btnType2">장바구니</button><button class="btnType2">구매하기</button>
   </figure>-->
</body>
</html>
