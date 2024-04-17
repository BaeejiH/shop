<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "shop.DAO.*"%>
<%
	//empList에서 OFF를 눌렀을 때 on으로 바뀌게 하는 페이지

	String active = request.getParameter("active");
	String empId = request.getParameter("empId");
	System.out.println(active+"<-----active");
	System.out.println(empId+"<-----empId");
	
	int row = EmpDAO.updateEMP(empId, active);
	
	
	 if (row == 1) {
	        System.out.println("active 변경 완료");
	        response.sendRedirect("/shop/emp/empList.jsp");
	    } else {
	        System.out.println("active  변경 실패");
	        response.sendRedirect("/shop/emp/empList.jsp");
	    }
	
	
	
	
%>