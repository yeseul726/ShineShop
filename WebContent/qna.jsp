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
        tr {
            border-top: 1px solid #C99B89;
            border-bottom: 1px solid #C99B89;
        }

        tr:nth-child(2n+1) {
            background-color: #F4DFD7;
        }

        td {
            text-align: center;
            padding: 10px;
        }

        th {
            padding: 10px;
        }

        table {
            border-collapse: collapse;
        }
    </style>
</head>
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
	
	Statement stmt = conn.createStatement();

	String sql = "SELECT * FROM ss_qna order by qid desc";

	ResultSet rs = stmt.executeQuery(sql);
//out.println("DB연결성공!!");
%>
<body>
    <div align="center" style="margin-top: 150px;">
        <h1>Q&A</h1><br><br>
        <table width="600px">
            <tr>
                <th>글번호</th>
                <th>내용</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            <%
            while(rs.next()) {
            	%>
            	<tr>
	                <td><%= rs.getInt("qid") %></td>
	                <td><a href="qnaView.jsp?qid=<%= rs.getInt("qid") %>"><%= rs.getString("title") %></a></td>
	                <td><%= rs.getString("writer") %></td>
	                <td><%= rs.getString("write_date") %></td>
            	</tr>
            	<%
            }
            %>
        </table>
        <br><br><br>
        <%
        if(application.getAttribute("user_id") != null) {
        	%><a class="btnType2" href="writeQNA.jsp">문의하기</a><%
        }
        %>
    </div>
</body>
</html>