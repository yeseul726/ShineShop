<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LOGIN</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>

<body>
    <div align="center">
        <h2 style="margin-top: 150px;">로그인</h2>
        <h1>LOGIN SHINE</h1><br>
        <div class="tableType" style="display: inline;">
            <form action="loginProc.jsp" method="post">
                <table>
                    <tbody>
                        <tr>
                            <td><input type="text" name="user_id" required></td>
                            <td rowspan="2"><input type="submit" style="background-color: #F4DFD7;" value="LOGIN" class="btnType"></td>
                        </tr>
                        <tr>
                            <td><input type="password" name="user_pw" required></td>
                        </tr>
                        <tr>
                            <td><a href="register.jsp" class="login" target="a">회원가입 </a>
                                <a href="findAcount.jsp" class="login" target="a">ID</a>/<a href="findAcountPW.jsp" class="login" target="a">PW 찾기</a></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</body>
</html>