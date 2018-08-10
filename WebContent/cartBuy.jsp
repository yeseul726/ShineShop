<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
	
	String sql = "SELECT DISTINCT item_id FROM ss_cart WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
			
	ResultSet item_rs = stmt.executeQuery(sql);
	ResultSet list_rs = null;
	ResultSet count_rs = null;
	ResultSet tmp_rs = null;
	ResultSet price_rs = null;
	ResultSet a = null;
	
	String sql2 = "SELECT item_id FROM ss_cart WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
	Statement stmt2 = conn.createStatement();
	ResultSet rs = stmt2.executeQuery(sql2);
	
	int total = 0;
	
	while(rs.next()) {
		sql = "SELECT * FROM ss_cart WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
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
        th {
            width: 200px;
            text-align: left;
        }

        td {
            text-align: left;
            height: 45px;
        }

        hr {
            margin: 7px;
            width: 1200px;
        }

        div {
            display: inline-block;
        }
        
    </style>
</head>

<body>
    <form action="cartBuyProc.jsp" method="post">
    <div align="center" style="display: block; margin: 0 auto; height: 1500px;">
	    <div align="center" style="margin-top: 50px;">
        <h1>CART</h1><br><br>
        <table width="700px">
            <tr>
            	<th>분류</th>
                <th>상품코드</th>
                <th>가격</th>
                <th>개수</th>
            </tr>
            <%
            	int cnt = 0;
	            while(item_rs.next()) {
	        		sql = "SELECT * FROM ss_item WHERE item_id='" + item_rs.getString("item_id") + "'";
	        		Statement list_stmt = conn.createStatement();
	        		list_rs = list_stmt.executeQuery(sql);
	        		list_rs.next();
	        		
	        		sql = "SELECT COUNT(*) FROM ss_cart WHERE item_id='" + item_rs.getString("item_id") + "' and user_id='" + (String)application.getAttribute("user_id") + "'";
	        		Statement count_stmt = conn.createStatement();
	        		count_rs = count_stmt.executeQuery(sql);
	        		count_rs.next();
	        		
	        		sql = "SELECT COUNT(*) FROM ss_cart WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
	        		Statement a_stmt = conn.createStatement();
	        		a = a_stmt.executeQuery(sql);
	        		a.next();
	        		cnt = a.getInt(1);
	        		%>
	        		<tr>
	        			<td><%= list_rs.getString("item_type") %></td>
		                <td><img width="70" src="image/<%= list_rs.getString("item_image") %>">&nbsp;&nbsp;&nbsp;<%= list_rs.getString("item_id") %></td>
		                <td><%= list_rs.getInt("item_price") * count_rs.getInt(1) %></td>
		                <td><input type="number" value="<%= count_rs.getInt(1) %>" min="1" style="width: 30px;" id="buyNum" name="buyNum">
		                <input type="hidden" name="item_id" value="<%= list_rs.getString("item_id") %>"></td>
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
            <input type="hidden" name="total_price" value="<%= total + delivery %>">
        <br><br><br>
    </div>
    <%
		sql = "SELECT * FROM ss_member WHERE user_id='" + (String)application.getAttribute("user_id") + "'";
		
		rs = stmt.executeQuery(sql);
		
		rs.next();
    %>
        <h1>주문하기</h1><br><br>
        <!-- <hr>
        <div>
            <h2>할인정보</h2>
            <hr>
            <div style="float: left; margin-left: 100px;">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <th>마일리지 사용</th>
                        <td>
                            <input type="text" value="0"> 원
                            <input type="checkbox"><span>모두사용 (마일리지 : 0 마일) </span>
                            <span> 직원 할인 이벤트사용시 추가 마일리지 사용은 불가합니다.</span>
                        </td>
                    </tr>
                    <tr>
                        <th>적립혜택(마일리지)</th>
                        <td><span>0 마일</span></td>
                    </tr>
                </table>
            </div>
        </div> -->

        <hr>

        <div>
            <h2>주문자 정보<a href="#"></a></h2>
            <hr>
            <div style="float: left; margin-left: 100px;">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <th>주문자 명</th>
                        <td><span><%= rs.getString("user_name") %></span></td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>
                            <%= rs.getString("user_address") %>
                        </td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>
                            <span><%= rs.getString("user_tel") %></span>
                            <span></span>
                        </td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>
                            <span><%= rs.getString("user_email") %></span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <hr>

        <div>
            <h2>배송 정보</h2>
            <hr>
            <div style="float: left; margin-left: 100px;">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <th>받으시는 분 *</th>
                        <td><input type="text" name="delivery_name" required></td>
                    </tr>
                    <tr>
                        <th>주소 *</th>
                        <td colspan="2">
                            <input type="text" name="delivery_address" required>
                        </td>
                    </tr>
                    <tr>
                        <th>휴대폰번호 *</th>
                        <td>
                            <select style="margin-left: 1px;" name="tel1" required>
                            <option value="010">010</option>
                            <option value="011">011</option>
                        </select> -
                            <input type="text" maxlength="4" name="tel2" required/> -
                            <input type="text" maxlength="4" name="tel3" required/>
                        </td>
                    </tr>
                    <tr>
                        <th>전화번호 *</th>
                        <td>
                            <select style="margin-left: 1px;" name="htel1" required>
                            <option value="02">02</option>
                            <option value="031">031</option>
                            <option value="032">032</option>
                        </select> -
                            <input maxlength="4" name="htel2" required/> -
                            <input maxlength="4" name="htel3" required/>
                        </td>
                    </tr>
                    <tr>
                        <th>배송 메모</th>
                        <td colspan="3"><textarea cols="30" rows="5" name="delivery_memo" required></textarea></td>
                    </tr>
                </table>
            </div>
        </div><br><br>
        <button type="submit" class="btnType2">결제하기</button>
    </div>
    </form>
</body>
</html>