<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

<%
	request.setCharacterEncoding("EUC-KR");

	String productCategory = request.getParameter("productCategory");
	String productName = request.getParameter("productName");
	String productPrice_ = request.getParameter("productPrice");
	String productSale_ = request.getParameter("productSale");
	String productImg = request.getParameter("productImg");
	String markerDate = request.getParameter("markerDate");
	String vendor = request.getParameter("vendor");
	
 	int productPrice = Integer.parseInt(productPrice_);
	int productSale = Integer.parseInt(productSale_); 
	
	productImg = "-";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String dbDrv = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521/xe";
	String dbUsr = "hr";
	String dbPwd = "1234";
	
	int result = 0;
	
	try {
		Class.forName(dbDrv);
		conn = DriverManager.getConnection(dbUrl, dbUsr, dbPwd);
		//System.out.println("-- 디비 접속 성공 --");
		//-----------------------------------------------------
		String sql = "insert into product values (seq_product.nextval, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productCategory);
		pstmt.setString(2, productName);
		pstmt.setInt(3, productPrice);
		pstmt.setInt(4, productSale);
		pstmt.setString(5, productImg);
		pstmt.setString(6, markerDate);
		pstmt.setString(7, vendor);
		result = pstmt.executeUpdate(); //몇 개가 추가되었다.. 0, 1
		//-----------------------------------------------------
	} catch (Exception e) {
		//System.out.println("-- 디비 접속 실패 --");
		//e.printStackTrace();
	} finally {
		try{
			if(rs != null) { rs.close(); }
			if(pstmt != null) { pstmt.close(); }
			if(conn != null) { conn.close(); }
		} catch (Exception e) {
			//e.printStackTrace;
		}

	}
	
	if (result > 0) {  //성공..
		//response.sendRedirect("list.jsp");
%>
	<script>
		alert('상품이 정상적으로 등록되었습니다.');
		location.href = "list.jsp"
	</script>
<%
	} else {  //실패..
		//response.sendRedirect("chuga.jsp");
		out.println("<script>");
		out.println("alert('상품이 정상적으로 등록되었습니다.');");
		out.println("location.href = 'list.jsp';");
		out.println("</script>");
	}
%>
