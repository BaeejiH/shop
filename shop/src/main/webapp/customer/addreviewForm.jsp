<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%>
 
 <%
 	int ordersNo = Integer.parseInt(request.getParameter("orders_no"));
 	System.out.println(ordersNo+"<---orders_no");
 %>   

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



	<h1>리뷰작성</h1>
	<form action="addreviewAction.jsp" method="post">
	    <input type="hidden" name="ordersNo" value="<%= ordersNo %>">
	    
	    <div>
        별점
        <select name="score" id="score">
            <option value="1">★</option>
            <option value="2">★★</option>
            <option value="3">★★★</option>
            <option value="4">★★★★</option>
            <option value="5">★★★★★</option>
        </select>
    </div>

		<div>
			<textarea name="content"></textarea>
		</div>

		<button type="submit">리뷰 작성</button>
	</form>
	
	

</body>
</html>