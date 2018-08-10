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
	
	String item_id = request.getParameter("item_id");
	int buyNum = Integer.parseInt(request.getParameter("buyNum"));
	String type = request.getParameter("type");
	
	sql = "SELECT item_price FROM ss_item WHERE item_id='" + item_id + "'";
	
	Statement stmt2 = conn.createStatement();
	ResultSet price_rs = stmt2.executeQuery(sql);
	price_rs.next();
	int item_price = price_rs.getInt("item_price");
	int total_price = item_price * buyNum;
	int delivery = 0;
	if(total_price >= 30000) {
		delivery = 0;
	} else {
		delivery = 2500;
	}
	
%>
<form action="buyProc.jsp" method="post">
    <div align="center" style="display: block; margin: 0 auto; margin-top: 50px;">
        <h1>주문하기</h1><br><br>
        <!-- <hr>
        <div>
            <h2>할인정보</h2>
            <hr>
            <div style="float: left; margin-left: 100px;">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <th>쿠폰할인</th>
                        <td>
                            <input type="text" value="0" readonly="readonly">
                            <a href="#">쿠폰조회</a> (보유 쿠폰 1장)
                        </td>
                    </tr>
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
		<div align="center" style="margin-top: 50px;">
        <h1>상품내역</h1><br><br>
        <table width="700px">
            <tr>
            	<th>분류</th>
                <th>상품코드</th>
                <th>가격</th>
                <th>개수</th>
            </tr>
            <tr>
            	<td><%= type %></td>
            	<td><%= item_id %></td>
            	<td><%= price_rs.getInt("item_price") %></td>
            	<td><%= buyNum %></td>
            </tr>
        </table>
        <div style="margin-top: 30px; width: 600px; text-align: right;"><span>결제금액 : <%= total_price %>원</span><br>
            <span>배송비 : <%= delivery %>원</span><br><span>총 결제금액 : <%= total_price + delivery %>원</span></div>
            <input type="hidden" name="total_price" value="<%= total_price + delivery %>">
        <br><br><br>
    </div>

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
        <input type="hidden" name="item_id" value="<%= item_id %>">
        <button type="submit" class="btnType2">결제하기</button>
    </div>
</form>
</body>
</html>