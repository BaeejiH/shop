<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>

<!-- session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서 -->
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));	
%>

<!-- Model Layer -->
<%

%>
<!-- Controller Layer -->
<%
	//reseponse.sendRedirect("/shop/emp/goodsList.jsp");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
<body>

</body>
</html>