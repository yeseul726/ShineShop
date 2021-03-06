<%@page import="java.io.File"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Connection"%>
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
		request.setCharacterEncoding("utf-8");
		String savePath = request.getServletContext().getRealPath("") + "/image";
		int sizeLimit = 1024*1024*100; //30mb로 크기 제한
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		String item_id = multi.getParameter("item_id");
		String fileName = multi.getFilesystemName("item_image");
		System.out.println(fileName);
		String item_type = multi.getParameter("item_type");
		String photoFullPath = savePath + "/" + fileName;
		
		File oldFile = new File(savePath + fileName);
	    File newFile = new File(savePath + item_id); 
	    
	    oldFile.renameTo(newFile);
		
		String item_price = multi.getParameter("item_price");
		String item_mileage = multi.getParameter("item_mileage");
		String item_remaining = multi.getParameter("item_remaining");
	
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
		//out.println("DB연결성공!!");

		String sql = "INSERT INTO ss_item(item_id, item_type, item_price, item_mileage, item_remaining, item_image) VALUES(?, ?, ?, ?, ?, ?)";

		PreparedStatement ps = conn.prepareStatement(sql);

		ps.setString(1, item_id);
		ps.setString(2, item_type);
		ps.setString(3, item_price);
		ps.setString(4, item_mileage);
		ps.setString(5, item_remaining);
		ps.setString(6, fileName);
		ps.executeUpdate();
		
		%><script>alert("상품이 업로드되었습니다.");</script><meta http-equiv="refresh" content="0;url=itemUploadList.jsp"><%
	%>
</body>
</html>
