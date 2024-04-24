<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>




<%
	
	
	//로그인 멤버와 empId 디버깅
	HashMap<String, Object> loginMember = (HashMap<String, Object>) session.getAttribute("logincustomer");
	if (loginMember == null) {
	    System.out.println("loginMember 객체가 null입니다.");
	} else {
	    System.out.println("loginMember 객체: " + loginMember);
	    System.out.println("customerID: " + loginMember.get("customerID"));
	}
	

%>

	<div>
		<a href="/shop/customer/ordersList.jsp"style="color:gray">주문내역 조회</a> |
	
	</div>



<br>



	<br>  
	<span>
	<!-- 개인정보수정 -->
	
		★<%=(String)(loginMember.get("name"))%>★님
		반갑습니다.
	
	</span>


