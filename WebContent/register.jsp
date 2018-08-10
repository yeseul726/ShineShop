<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
    </style>
    <script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script>
    function change(val) {
		if (val == "self") {
			$('#email2').val("");
			$('#email2').removeAttr("readonly");
			$('#email2').attr("style", "width:100px; background:#ffffff;");
		} else {
			$('#email2').val(val);
			$('#email2').attr("readonly", true);
			$('#email2').attr("style", "width:100px; background:#f6f6f6;");
		}
	}
    function idCheck() {
		<%
			String driverName="com.mysql.jdbc.Driver";
		    String url = "jdbc:mysql://localhost:3306/ShineShop";
		    String id = "root";
		    String pwd ="1234";
		    
		    try{
		        //[1] JDBC 드라이버 로드
		        Class.forName(driverName);     
		    }catch(ClassNotFoundException e){
		        out.println("Where is your mysql jdbc driver?");
		        e.printStackTrace();
		        return;
		    }
		    //out.println("mysql jdbc Driver registered!!");
		   
		    //[2]데이타베이스 연결 
		    Connection conn = DriverManager.getConnection(url,id,pwd);
		    //out.println("DB연결성공!!");
		    
		    String sql = "SELECT user_id FROM ss_member";
		    
		    Statement stmt = conn.createStatement();
	
			ResultSet rs = stmt.executeQuery(sql);
			
			%>var cnt = 0;<%
			
			while(rs.next()) {
				%>
				if("<%= rs.getString("user_id") %>" == document.join.user_id.value) {
					cnt++;
				}
				<%
			}
			
			%>
			if(cnt != 0) {
				alert("이미 존재하는 아이디입니다.");
			} else {
				alert("사용 가능한 아이디입니다.");
			}
			<%
		%>
	}
    </script>
</head>

<body>
    <div align="center">
        <h2 style="margin-top: 150px;">회원가입</h2>
        <h1>JOIN SHINE</h1><br>
        <div class="tableType" style="display: inline;">
            <form action="registerProc.jsp" method="post" name="join">
                <fieldset style="width: 90%;">
                    <table>
                        <colgroup>
                            <col width="20%"></col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for>* 이름</th>
							<td><input type="text" name="user_name" required></td>
						</tr>
						<tr>
							<th scope="row"><label for>* 아이디</label></th>
                                <td><input type="text" name="user_id" minlength="6" maxlength="10" required style="margin-right: 10px; ime-mode: disabled;"><button type="button" class="btnType2" onclick="idCheck();">중복확인</button><br>* 영문 최소 6자 ~ 최대 10자 가능
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>* 비밀번호</label></th>
                                <td><input type="password" name="user_pw" minlength="8" maxlength="20" required style="margin-right: 10px;">* 영문 최소 8자 ~ 최대 20자 가능</td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>* 닉네임</label></th>
                                <td><input type="text" name="user_nickname" style="margin-right: 6px;" required></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>* 이메일</label></th>
								<td><input type="text"
									style="width: 100px; ime-mode: disabled;" id="email1"
									name="email1" maxlength="30"> @&nbsp;<input type="text"
									readonly="readonly" class="searchDomain" id="email2"
									name="email2" maxlength="34"> <select title="검색조건"
									style="width: 120px;" id="domain" name="domain"
									onchange="change(this.value)">
										<option value="">선택하세요</option>
										<option value="daum.net">daum.net</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="gmail.com">gmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="naver.com">naver.com</option>
										<option value="self">직접 입력</option>
								</select>
                            </tr>
                            <tr>
                                <th scope="row"><label for>* 주소</label></th>
                                <td><input type="text" name="user_address" style="margin-right: 6px;" required></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>* 휴대폰 번호</label></th>
                                <td><input type="text" title="휴대폰 첫자리" name="user_tel1" maxlength="3" style="width: 100px;" required> -
                                    <input type="text" title="휴대폰 중간자리" name="user_tel2" maxlength="4" style="width: 100px;" required> -
                                    <input type="text" title="휴대폰 끝자리" name="user_tel3" maxlength="4" style="width: 100px;" required></td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
                <br>
                <div style="display: inline;">
                    <button type="reset" class="btnType2" style="margin-right: 15px;">다시입력</button>
                    <button type="submit" class="btnType2" style="background-color: #F4DFD7;">가입하기</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>