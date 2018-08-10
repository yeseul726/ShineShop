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
	
	String user_pw = rs.getString("user_pw");
%>
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
    <style>
        select {
            height: 37px;
            border-radius: 7px;
        }
    </style>
    <script>
    	function check() {
    		if(document.outRegister.user_pw.value != "<%= user_pw %>") {
    			alert("비밀번호가 일치하지 않습니다.");
    		} else {
    			if (confirm("정말 탈퇴하시겠습니까?") == true){    //확인
    				location.href="outRegisterProc.jsp";
    			}else{   //취소
    			    return;
    			}
    		}
    	}
    </script>
</head>

<body>
    <div align="center">
        <h2 style="margin-top: 150px;">회원탈퇴</h2>
        <h1>LEAVE SHINE</h1><br>
        <div class="tableType" style="display: inline;">
            <form action="outRegisterProc.jsp" method="post" name="outRegister">
                <fieldset style="width: 90%;">
                    <table>
                        <tbody>
                            <colgroup>
                                <col width="30%"></col>
                            </colgroup>
                            <tr>
                                <th scope="row"><label for>이름</th>
							<td><input type="text" value="<%= rs.getString("user_name") %>" required disabled></td>
						</tr>
						<tr>
							<th scope="row"><label for>비밀번호</label></th>
                                <td><input name="user_pw" type="text" style="margin-right: 10px; ime-mode: disabled;" required>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
                <br>
                <div style="display: inline;">
                    <button type="button" class="btnType2" style="margin-right: 15px;" onclick="check();">회원탈퇴</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>