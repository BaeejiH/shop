<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>




<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("logincustomer"));	
%>





<br>



	<br>  
	<span>
	<!-- 개인정보수정 -->
	
		★<%=(String)(loginMember.get("name"))%>★님
		반갑습니다.
	
	</span>


