<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.*"%>
<%
	//인증분기 
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/goodsList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>

<%
	String empID = request.getParameter("empID");
	String empPW = request.getParameter("empPW");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");
	String active = request.getParameter("active");
	
	System.out.println(empID+"<---empid");
	System.out.println(empPW+"<---emppw");
	System.out.println(empName+"<---name");
	System.out.println(empJob+"<---job");
	System.out.println(hireDate+"<---date");
	System.out.println(active+"<---active");

	int row = EmpDAO.insertEmp(empID,empPW,empName,empJob,hireDate,active);
	
	
	if(row == 1){
		//회원가입 성공
		System.out.println("회원가입 성공");
		response.sendRedirect("/shop/emp/emploginForm.jsp");
	} else {
		//회원가입 실패
		System.out.println("회원가입 실패");
		response.sendRedirect("/shop/emp/addempForm.jsp");
	}



%>