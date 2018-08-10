<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="javafx.application.Application"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	
	String driverName="com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/ShineShop";
    String pid = "root";
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
    Connection conn = DriverManager.getConnection(url,pid,pwd);
    
    Statement stmt = conn.createStatement();
    
    String sql = "SELECT * FROM ss_member";
    
    ResultSet rs = stmt.executeQuery(sql);
    
    String id = "";
    String pw = "";
    
    int cnt = 0;
    
    while(rs.next()) {
    	//out.println(rs.getString(1));
    	id = rs.getString("user_id");
    	pw = rs.getString("user_pw");
    	
    	if(user_id.equals(id)) {
    		if(user_pw.equals(pw)) {
    			application.setAttribute("user_id", user_id);
    			session.setMaxInactiveInterval(60*60);
    			/* out.println("loginProc : " + application.getAttribute("user_id")); */
    			//response.sendRedirect("index.jsp");
    			if(((String)application.getAttribute("user_id")).equals("shineshopadmin")) {
					%><script>alert("관리자입니다.");</script><meta http-equiv="refresh"><%
				}
    			%>
    			<meta http-equiv="refresh">
    			<!-- <meta http-equiv="refresh" content="0;url=main.jsp"> -->
    			<script>location.href="indexProc.jsp";</script>
    			<%
    		}
    		else {
    			cnt = 2;
    			%>
    			<!-- <script>
    				alert("아이디 또는 패스워드가 틀렸습니다.");
    			</script>
    			<meta http-equiv="refresh" content="0;url=login.jsp"> -->
    			<%
    		}
    	}
    	else {
    			cnt = 3;
    			%>
    			<!-- <script>
    				alert("등록되지 않은 사용자입니다.");
    			</script>
    			<meta http-equiv="refresh" content="0;url=login.jsp"> -->
    			<%
    	}
    }
    
    if(cnt == 2) {
    	%>
		<script>
			alert("아이디 또는 패스워드가 틀렸습니다.");
		</script>
		<meta http-equiv="refresh" content="0;url=login.jsp">
		<%
    } else if(cnt == 3) {
    	%>
		<script>
			alert("등록되지 않은 사용자입니다.");
		</script>
		<meta http-equiv="refresh" content="0;url=login.jsp">
		<%
    }
%>
<%-- if(inputid.equals(id)) {
		if(inputpw.equals(pw)) {
			application.setAttribute("userID", id);
			session.setMaxInactiveInterval(60*60);
			out.println("loginProc : " + application.getAttribute("userID"));
			response.sendRedirect("main.jsp");
			%>
			<!-- <meta http-equiv="refresh" content="0;url=main.jsp"> -->
			<script>alert("성공");</script>
			<%
		}
		else {
			%>
			<script>
				alert("아이디 또는 패스워드가 틀렸습니다.");
			</script>
			<meta http-equiv="refresh" content="0;url=login.jsp">
			<%
		}
	}
	else {
			%>
			<script>
				alert("등록되지 않은 사용자입니다.");
			</script>
			<meta http-equiv="refresh" content="0;url=login.jsp">
			<%
	} --%>
</body>
</html>
