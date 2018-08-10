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
    <style>
        @import url('https://fonts.googleapis.com/css?family=Lobster|Nanum+Gothic');
        fieldset {
            width: 680px;
            height: 490px;
        }

        .button {
            border-bottom: 1px solid #695c5c;
            border-left: 0px;
            border-right: 0px;
            border-top: 0px;
            outline: none;
            font-family: "나눔고딕";
            font-size: 12pt;
            padding: 3px;
            background-color: transparent;
        }

        input {
            border-bottom: 1px solid #695c5c;
            border-left: 0px;
            border-right: 0px;
            border-top: 0px;
            outline: none;
            background-color: transparent;
        }

        .t {
            font-family: "Nanum Gothic";
            color: #808080;
        }

        .txt01 {
            font-family: 'Nanum Gothic', sans-serif;
            font-weight: bold;
            color: #303030;
        }

        textarea {
            outline: none;
            overflow: auto;
            resize: vertical;
        }

        .fieldset {
            border: 1px solid #9F7E69;
            padding: 30px;
            width: 50%;
        }

        h1 {
            font-family: 'Nanum Gothic', sans-serif;
        }

        div {
            margin-top: 50px;
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
	
	String sql = "SELECT * FROM ss_qna WHERE qid='" + request.getParameter("qid") + "'";
	
	ResultSet rs = stmt.executeQuery(sql);
	
	rs.next();
%>
<body>
    <div align="center">
        <h1>WRITE QNA</h1>
        <form action="qnaModifyProc.jsp" method="post">
            <div align="center" class="fieldset">
                <table>
                    <tr height="20"></tr>
                    <tr>
                        <td width="80" align="left"><span class="txt01">title</span></td>
                        <td align="left"><input type="text" size="45" value="<%= rs.getString("title") %>" name="title" required></td>
                    </tr>
                    <tr height="25"></tr>
                    <tr>
                        <td width="80" align="left" valign="top"><span class="txt01">content</span></td>
                        <td align="left"><textarea placeholder="내용 입력" rows="12" cols="57" name="content" required><%= rs.getString("content") %></textarea></td>
                    </tr>
                </table>
                <div align="center">
                	<input type="hidden" name="qid" value="<%= rs.getInt("qid") %>">
                    <input type="submit" class="button" value="write">
                    <input type="reset" class="button" value="reset" style="margin-bottom: 30px;">
                    <a class="button" href="qna.jsp" style="text-decoration: none; color: black;">list</a>
                </div>
            </div>
        </form><br>
    </div>
    <br>
</body>
</html>