<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String searchField = request.getParameter("searchField");
	String searchData = request.getParameter("searchData");

	if (searchField == null || searchField.trim().equals("")) {
		searchField = "";
	}
	if (searchData == null || searchData.trim().equals("")) {
		searchData = "";
	}
	if (searchField.equals("") || searchData.equals("")) {
		searchField = "";
		searchData = "";
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String dbDrv = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521/xe";
	String dbUsr = "hr";
	String dbPwd = "1234";
	
	int result = 0;
	ArrayList<String> list = new ArrayList<>();
	
	try {
		Class.forName(dbDrv);
		conn = DriverManager.getConnection(dbUrl, dbUsr, dbPwd);
		//System.out.println("-- 디비 접속 성공 --");
		//-----------------------------------------------------
		String sql = "";
		
		if (searchField.equals("") || searchData.equals("")) {
			sql = "select * from product order by productCode desc";	
		} else {
			sql = "select * from product ";
			
			if(searchField.equals("분류")) {
				sql += "where productCategory like ? ";
			} else if (searchField.equals("이름")) {
				sql += "where productName like ? ";
			} else if (searchField.equals("제조사")) {
				sql += "where vendor like ? ";
			}
			
			sql += "order by productCode desc";
		}
		System.out.println("sql : " +sql);
		
		pstmt = conn.prepareStatement(sql);
		
		if (searchField.equals("") || searchData.equals("")) {
			
		} else {
			
			if(searchField.equals("분류")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if (searchField.equals("이름")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if (searchField.equals("제조사")) {
				pstmt.setString(1, '%' + searchData + '%');
			}

		}
		
		rs = pstmt.executeQuery();
		while (rs.next()) {
			int productCode = rs.getInt("productCode");
			String productCategory = rs.getString("productCategory");
			String productName = rs.getString("productName");
			int productPrice = rs.getInt("productPrice");
			int productSale = rs.getInt("productSale");
			String markerDate = rs.getString("markerDate");
			String vendor = rs.getString("vendor");
			String regiDate = rs.getString("regiDate");
			
			String msg = "";
			msg += productCode;
			msg += "|" + productCategory;
			msg += "|" + productName;
			msg += "|" + productPrice;
			msg += "|" + productSale;
			msg += "|" + markerDate;
			msg += "|" + vendor;
			msg += "|" + regiDate;
			
			list.add(msg);
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

<h2>상품목록</h2>

<% if (searchField.equals("") || searchData.equals("")) { %>
	전체목록 : <%=list.size() %>건.
<% } else { %>
	검색어 "<%=searchData %>"로 검색된 목록 : <%=list.size() %>건
<% } %>

<table border="1">
	<tr>
		<td>순번</td>
		<td>상품분류</td>
		<td>상품이름</td>
		<td>상품가격</td>
		<td>할인률</td>
		<td>제조일자</td>
		<td>제조사</td>
		<td>등록일</td>
	</tr>
	
	<%
		for (int i=0; i<list.size(); i++) {
			String str = list.get(i);
			String[] imsiArray = str.split("[|]");
			
			int productCode = Integer.parseInt(imsiArray[0]);
			String productCategory = imsiArray[1];
			String productName = imsiArray[2];
			int productPrice = Integer.parseInt(imsiArray[3]);
			int productSale = Integer.parseInt(imsiArray[4]);
			String markerDate = imsiArray[5];
			String vendor = imsiArray[6];
			String regiDate = imsiArray[7];
			
			markerDate = markerDate.substring(0, 10);
			regiDate = regiDate.substring(0, 10);
	%>
	<tr>
		<td><%=list.size() - i %></td>
		<td><%=productCategory %> (<%=productCode %>)</td>
		<td><a href="#" onClick="move('<%=productCode%>');"><%=productName %></a></td>
		<td><%=productPrice %></td>
		<td><%=productSale %></td>
		<td><%=markerDate %></td>
		<td><%=vendor %></td>
		<td><%=regiDate %></td>
	</tr>
	<%
		}
	%>
</table>

<div style="margin-top: 20px;">
	<form name="searchForm" method="post" action="list.jsp"></form>

<%  if (searchField.equals("이름")) { %>
	<input type="radio" name="searchField" value="분류"> 분류 &nbsp;
	<input type="radio" name="searchField" value="이름" checked> 이름 &nbsp;
	<input type="radio" name="searchField" value="제조사"> 제조사 &nbsp;
<% } else if (searchField.equals("제조사")) { %>
	<input type="radio" name="searchField" value="분류"> 분류 &nbsp;
	<input type="radio" name="searchField" value="이름"> 이름 &nbsp;
	<input type="radio" name="searchField" value="제조사" checked> 제조사 &nbsp;
<% } else { %>
	<input type="radio" name="searchField" value="분류" checked> 분류 &nbsp;
	<input type="radio" name="searchField" value="이름"> 이름 &nbsp;
	<input type="radio" name="searchField" value="제조사"> 제조사 &nbsp;
<% } %>

	&nbsp;
	<input type="text" name="searchData" value="<%=searchData%>">
	&nbsp;&nbsp;
	<button type="submit">검색하기</button>
	</form>
</div>

<hr style="margin: 10px 0px 10px 0px;">
|
<a href="list.jsp">전체목록</a>
|
<a href="chuga.jsp">상품등록</a>
|

<script>
	function move(value1) {
		location.href = "view.jsp?productCode=" + value1;
	}
</script>
</body>
</html>
