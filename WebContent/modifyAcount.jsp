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
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
    <style>
        select {
            height: 37px;
            border-radius: 7px;
            vertical-align: middle;
        }

        td {
            line-height: 50px;
        }
        
        th {
        	text-align: left;
        }

        button {
            height: 37px;
            vertical-align: middle;
        }
    </style>
    <script>
	    function check() {
			if(document.modify.before_pw.value == "<%= user_pw %>") {
				if(document.modify.modifyPw.value == "") {
					alert("변경할 비밀번호를 입력해주세요.");
				} else {
					if (confirm("수정하시겠습니까?") == true){    //확인
						document.modify.submit();
					}else{   //취소
					    return;
					}
				}
			} else {
				alert("비밀번호가 일치하지 않습니다.");
			}
		}
    </script>
</head>

<body>
    <div align="center">
        <h2 style="margin-top: 35px;">회원정보 수정</h2>
        <h1>MODIFY ACOUNT</h1><br>
        <div class="tableType" style="display: inline;">
            <form action="modifyAcountProc.jsp" method="post" name="modify">
                <fieldset style="width: 100%;">
                    <table>
                        <colgroup>
                            <col width="20%"></col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for>이름</th>
							<td><input type="text" name="user_name" disabled value="<%= rs.getString("user_name") %>"></td>
						</tr>
						<tr>
							<th scope="row"><label for>아이디</label></th>
                                <td>
                                <input type="text" name="user_id" minlength="6" maxlength="10" required style="margin-right: 10px; ime-mode: disabled;" disabled value="<%= rs.getString("user_id") %>">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>현재 비밀번호</label></th>
                                <td><input type="password" name="before_pw" minlength="8" maxlength="20" required style="margin-right: 10px;"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>새 비밀번호</label></th>
                                <td><input type="password" name="modifyPw" minlength="8" maxlength="20" required style="margin-right: 10px;">* 영문 최소 8자 ~ 최대 20자 가능</td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>닉네임</label></th>
                                <td><input type="text" name="user_nickname" style="margin-right: 6px;" required value="<%= rs.getString("user_nickname") %>"></td>
                            </tr>
                            <tr>
                            <th scope="row"><label for>현재 이메일</label></th>
                                <td><input type="text" name="user_email" disabled style="margin-right: 6px;" required value="<%= rs.getString("user_email") %>"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>바꿀 이메일</label></th>
                                <td><input type="text" style="width:100px; ime-mode:disabled;" id="email1" name="email1" maxlength="30"> @&nbsp;
                                    <input type="text" readonly="readonly" class="searchDomain" id="email2" name="email2" maxlength="34">
                                    <select title="검색조건" style="width:120px;" id="domain" name="domain">
									<option value="">선택하세요</option>
									<option value="daum.net">daum.net</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="nate.com">nate.com</option>
									<option value="naver.com">naver.com</option>
									<option value="self">직접 입력</option>
                                </select></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for> 휴대폰 번호</label></th>
                                <td><%= rs.getString("user_tel") %></td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
                <div style="display: inline;">
                    <!--<button type="submit" class="btnType2" style="background-color: #ffdfdf;">수정하기</button>-->
                    <button class="btnType2" style="background-color: #F4DFD7;" onclick="check();">수정하기</button>
                </div>
            </form>
        </div>
    </div>
    <br><br>
</body>
</html>