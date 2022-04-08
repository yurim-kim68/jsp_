<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

<%
	request.setCharacterEncoding("UTF-8");

	String productCode_ = request.getParameter("productCode");
	
	if(productCode_== null || productCode_.equals("")) {
		out.println("<script>");
		out.println("alert('정상적인 접속이 아닙니다.');");
		out.println("location.href = 'list.jsp';");
		out.println("</script>");
		return;
	}
	
	int productCode = Integer.parseInt(productCode_);

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
		String sql = "";
		sql += "update product set ";
		sql += "productCategory = ?, ";
		sql += "productName = ?, ";
		sql += "productPrice = ?, ";
		sql += "productSale = ?, ";
		sql += "markerDate = ?, ";
		sql += "vendor = ?, ";
		sql += "where productCode = ?, ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productCategory);
		pstmt.setString(2, productName);
		pstmt.setInt(3, productPrice);
		pstmt.setInt(4, productSale);
		pstmt.setString(5, markerDate);
		pstmt.setString(6, vendor);
		pstmt.setInt(7, productCode);
		result = pstmt.executeUpdate();
		
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
		response.sendRedirect("view.jsp?productCode= " + productCode);
	} else {  //실패..
		response.sendRedirect("sujung.jsp?productCode= " + productCode);
	}
%>
