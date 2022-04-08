<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<%
	String productCode_ = request.getParameter("productCode");

	if(productCode_== null || productCode_.equals("")) {
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
			
		/* 	markerDate = markerDate.substring(0, 10);
			regiDate = regiDate.substring(0, 10); */
			 
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

<h2>상품수정</h2>

<form name="syjungForm" method="post" action="sujungProc.jsp">
<input type="hidden" name="productCode" value="<%=productCode %>">
<table border="1">
	<tr>
		<td>상품분류</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productCategory" value="<%=productCategory%>">
		</td>
	</tr>
	<tr>
		<td>상품이름</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productName" value="<%=productName%>">
		</td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productPrice" value="<%=productPrice%>">
		</td>
	</tr>
	<tr>
		<td>할인률</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productSale" value="<%=productSale%>">
		</td>
	</tr>
	<tr>
		<td>상품이미지</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productImg">
		</td>
	</tr>
	<tr>
		<td>제조일자</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="date" name="markerDate" value="<%=markerDate%>">
		</td>
	</tr>
	<tr>
		<td>제조사</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="vendor" value="<%=vendor%>">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="submit">수정하기</button>
			<button type="button" onClick="move();">목록으로</button>
		</td>
	</tr>
</table>
</form>

<script>
	function move(1) {
		location.href = "list.jsp";
	}
</script>

</body>
</html>
