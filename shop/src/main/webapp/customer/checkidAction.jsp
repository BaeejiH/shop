<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.*"%>
<%
	//인증분기 
	if(session.getAttribute("logincustomer") != null) {
		response.sendRedirect("/shop/customer/customergoodsList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>

<%
	String checkID = request.getParameter("checkID");
	String IDcheck = customerDAO.checkIDcustomer(checkID); // 아이디가 사용가능한지 여부를 보여주는 변수 설정.
	
	System.out.println(checkID+"<--checkmail");
	
	
	
	
	response.sendRedirect("/shop/customer/addcustomerForm.jsp?IDcheck="+IDcheck);

%>





