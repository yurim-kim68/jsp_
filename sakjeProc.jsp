<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

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
		String sql = "delete from product where productCode = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,productCode);
		result = pstmt.executeUpdate();  //0(삭제 안 됨),1(1개가 삭제 됨)
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
	
	if(result > 0) {
		response.sendRedirect("list.jsp");
	}else {
		response.sendRedirect("sakje.jsp?productCode=" + productCode);
	}
%>
