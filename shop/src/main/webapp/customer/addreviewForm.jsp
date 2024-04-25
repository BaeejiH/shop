<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%>
 
    

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



	<h1>리뷰작성</h1>
	<form action="./addreviewAction.jsp" method="post">

		
		<div>상품리뷰:<input type="hidden" name=review value=""id=rr></div>
		<div><textarea rows="15" cols="50"id=rr></textarea></div>
		
		<div>
			<select>
				<option>★</option>
				<option>★★</option>
				<option>★★★</option>
				<option>★★★★</option>
				<option>★★★★</option>
			</select>
		</div>
		
		<button type="submit">리뷰작성</button>
	</form>
	
	

</body>
</html>