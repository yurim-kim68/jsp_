<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<h2>상품등록</h2>
<form name="chugaForm" method="post" action="chugaProc.jsp">
<table border="1">
	<tr>
		<td>상품분류</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name=productCategory>
		</td>
	</tr>
	<tr>
		<td>상품이름</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productName">
		</td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productPrice">
		</td>
	</tr>
	<tr>
		<td>할인률</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="productSale">
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
			<input type="date" name="markerDate">
		</td>
	</tr>
	<tr>
		<td>제조사</td>
		<td style="padding: 5px 5px 5px 5px;">
			<input type="text" name="vendor">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" onClick="chuga();">저장하기</button>
			<button type="button" onClick="move();">목록으로</button>
		</td>
	</tr>
</table>
</form>

<script>
	var f = document.chugaForm;

	function sijak() {
		f.productCategory.focus();
	}
	
	function chuga() {
		if (f.productCategory.value == '') {
			alert('상품분류를 입력하세요.');
			f.productCategory.focus();
			return;
		}
		if (f.productName.value == '') {
			alert('상품이름을 입력하세요.');
			f.productName.focus();
			return;
		}
		if (f.productPrice.value == '') {
			alert('상품가격을 입력하세요.');
			f.productPrice.focus();
			return;
		}
		if (f.productSale.value == '') {
			alert('할인률을 입력하세요.');
			f.productSale.focus();
			return;
		}
		if (f.markerDate.value == '') {
			alert('제조일자를 입력하세요.');
			f.markerDate.focus();
			return;
		}
		if (f.markerDate.value == '') {
			alert('제조사를 입력하세요.');
			f.vendor.focus();
			return;
		}
		if (confirm('등록하시겠습니까?')) {
			f.submit();
		}
	}
	function move() {
		location.href = "list.jsp";
	}
	
	
	sijak();
</script>
</body>
</html>
