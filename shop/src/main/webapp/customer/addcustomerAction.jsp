<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.*"%>
<%
	//인증분기 
	if(session.getAttribute("logincustomer") != null) {
		response.sendRedirect("/shop/customer/customerList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>

<%
	String customerID = request.getParameter("customerID");
	String customerPW = request.getParameter("customerPW");
	String name = request.getParameter("Name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	
	
	int row = 0;
	row = customerDAO.insertcustomer(customerID, customerPW, name, birth, gender);
	
	if(row == 1){
		//회원가입 성공
		System.out.println("회원가입 성공");
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
	} else {
		//회원가입 실패
		System.out.println("회원가입 실패");
		response.sendRedirect("/shop/customer/addcustomerForm.jsp");
	}



%>