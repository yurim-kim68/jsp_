<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	String productCode_ = request.getParameter("productCode");
	
	if(productCode_== null || productCode_.trim().equals("")) {
		out.println("<script>");
		out.println("alert('정상적인 접속이 아닙니다.');");
		out.println("location.href = 'list.jsp';");
		out.println("</script>");
		return;
	}
	
	int productCode = Integer.parseInt(productCode_);
	
	String productCategory = "";
	String productName = "";
	int productPrice = 0;
	int productSale = 0;
	String markerDate = "";
	String vendor = "";
	String regiDate = "";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String dbDrv = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521/xe";
	String dbUsr = "hr";
	String dbPwd = "1234";

	try {
		Class.forName(dbDrv);
		conn = DriverManager.getConnection(dbUrl, dbUsr, dbPwd);
		//System.out.println("-- 디비 접속 성공 --");
		//-----------------------------------------------------
		String sql = "select * from product where productCode = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, productCode);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			productCategory = rs.getString("productCategory");
			productName = rs.getString("productName");
			productPrice = rs.getInt("productPrice");
			productSale = rs.getInt("productSale");
			markerDate = rs.getString("markerDate");
			vendor = rs.getString("vendor");
			regiDate = rs.getString("regiDate");
			
			markerDate = markerDate.substring(0, 10);
			regiDate = regiDate.substring(0, 10);
		}
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<h2>상품상세보기</h2>

<table border="1">
	<tr>
		<td>상품코드</td>
		<td><%=productCode  %></td>
	</tr>
	<tr>
		<td>상품분류</td>
		<td><%=productCategory  %></td>
	</tr>
	<tr>
		<td>상품이름</td>
		<td><%=productName  %></td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td><%=productPrice  %></td>
	</tr>
	<tr>
		<td>할인률</td>
		<td><%=productSale  %></td>
	</tr>
	<tr>
		<td>이미지</td>
		<td>-</td>
	</tr>
	<tr>
		<td>제조일자</td>
		<td><%=markerDate  %></td>
	</tr>
	<tr>
		<td>제조사</td>
		<td><%=vendor  %></td>
	</tr>
		<tr>
		<td>등록일</td>
		<td><%=regiDate  %></td>
	</tr>
</table>

<hr style="margin: 10px 0px 10px 0px;">
|
<a href="list.jsp">상품목록</a>
|
<a href="chuga.jsp">상품등록</a>
|
<a href="sujung.jsp?productCode=<%=productCode%>">상품수정</a>
|
<a href="sakje.jsp?productCode=<%=productCode%>">상품삭제</a>
|

</body>
</html>
