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
        }
        
        th {
        	text-align: left;
        }

        td {
            line-height: 50px;
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
    </script>
</head>

<body>
    <div align="center">
        <h2 style="margin-top: 150px;">PASSWORD 찾기</h2>
        <h1>FIND PW</h1><br>
        <div class="tableType" style="display: inline;">
            <form action="findPWProc.jsp" method="post">
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
                                <td><input type="text" name="user_id" minlength="6" maxlength="10" required style="margin-right: 10px; ime-mode: disabled;">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for>* 이메일</label></th>
                                <td><input type="text"
									style="width: 100px; ime-mode: disabled;" id="email1"
									name="email1" maxlength="30" required> @&nbsp;<input type="text"
									readonly="readonly" class="searchDomain" id="email2"
									name="email2" maxlength="34" required> <select title="검색조건"
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
                        </tbody>
                    </table>
                </fieldset>
                <br>
                <div style="display: inline;">
                    <button type="reset" class="btnType2" style="margin-right: 15px;">다시입력</button>
                    <button type="submit" class="btnType2" style="background-color: #F4DFD7;">비밀번호 찾기</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>