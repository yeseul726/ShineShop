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

<body>
    <div align="center">
        <h1>WRITE QNA</h1>
        <form action="writeQNAProc.jsp" method="post">
            <div align="center" class="fieldset">
                <table>
                    <tr height="20"></tr>
                    <tr>
                        <td width="80" align="left"><span class="txt01">title</span></td>
                        <td align="left"><input type="text" size="45" name="title"></td>
                    </tr>
                    <tr height="25"></tr>
                    <tr>
                        <td width="80" align="left" valign="top"><span class="txt01">content</span></td>
                        <td align="left"><textarea placeholder="내용 입력" rows="12" cols="57" name="content"></textarea></td>
                    </tr>
                </table>
                <div align="center">
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