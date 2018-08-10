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

        .t {
            font-family: "나눔고딕";
            color: #808080;
        }

        .txt01 {
            font-family: 'Varela Round', sans-serif;
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
            margin-top: 140px;
            font-family: 'Nanum Gothic';
        }
    </style>
    <script>
	    function deleteCheck(qid) {
			if (confirm("삭제하시겠습니까?") == true){    //확인
				location.href="qnaDelete.jsp?qid=" + qid;
			}else{   //취소
			    return;
			}
		}
    </script>
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
        <h1>VIEW QNA</h1>
        <form action="qnaAnswerProc.jsp" method="post">
            <div align="center" class="fieldset">
                <table>
                    <tr height="20"></tr>
                    <tr>
                        <td width="80" align="left"><span class="txt01">title</span></td>
                        <td align="left"><%= rs.getString("title") %></td>
                    </tr>
                    <tr height="25"></tr>
                    <tr>
                        <td width="80" align="left" valign="top"><span class="txt01">content</span></td>
                        <td align="left"><%= rs.getString("content") %></td>
                    </tr>
                    <tr height="25"></tr>
                    <tr>
                        <td width="80" align="left" valign="top"><span class="txt01">└></span></td>
                        <td align="left" style="">
                        <%
                        if(((String)application.getAttribute("user_id")).equals("shineshopadmin")) {
                        	%><textarea placeholder="답변 입력" rows="12" cols="57" name="answer"><%= rs.getString("answer") %></textarea><%
                        } else {
                        	if(rs.getString("answer") != null) {
                            	%><%= rs.getString("answer") %><%
                            } else {
                            	%><span style="color: gray;">아직 답변이 달리지 않았습니다.</span><%
                            }
                        }
                        
                        %>
                        </td>
                    </tr>
                </table>
                <br><br>
                <div align="center">
                <%
                if(application.getAttribute("user_id") == null) {
					%><a class="button" href="qna.jsp" style="text-decoration: none; color: black;">list</a><%
				} else {
					if(((String)application.getAttribute("user_id")).equals(rs.getString("writer"))) {
						if(rs.getString("answer") == null) {
							%><button type="button" onclick="location.href='qnaModifyForm.jsp?qid=<%= request.getParameter("qid") %>'" class="button">수정</button>
						<button type="button" onclick="deleteCheck('<%= request.getParameter("qid") %>');" class="button">삭제</button><%
						} else {
							%><button type="button" onclick="deleteCheck('<%= request.getParameter("qid") %>');" class="button">삭제</button><%
						}
						%>
						
						<%
						} else {
							%><a class="button" href="qna.jsp" style="text-decoration: none; color: black;">list</a><%
									if(!(((String) application.getAttribute("user_id")).equals(rs.getString("writer"))) && ((String)application.getAttribute("user_id")).equals("shineshopadmin")) {
										%>
										<input type="hidden" name="qid" value="<%= request.getParameter("qid") %>">
										<button type="submit" class="button">작성</button>
										<button type="button" onclick="deleteCheck('<%= request.getParameter("qid") %>');" class="button">삭제</button>
										<a class="button" href="qna.jsp" style="text-decoration: none; color: black;">list</a>
										<%
									} else {
										%><a class="button" href="qna.jsp" style="text-decoration: none; color: black;">list</a><%
									}
						}
						
				}
				
				
				%>
                    
                </div>
            </div>
        </form><br>
    </div>
    <br>
</body>
</html>