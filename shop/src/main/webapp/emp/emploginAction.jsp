<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.*"%><!-- 치환 기능 -->
<%
	//인증분기 :세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>

<%
	//1. controller
	String empID = request.getParameter("empID");
	String empPW = request.getParameter("emppw");
	
	
	//  모델 호출하는 코드
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empID, empPW);
	System.out.println(loginEmp+"<--loginEmp");
	
	
	
	
	//1.controller
	if(loginEmp == null){//성공시 리스트로
		System.out.println("로그인실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
		response.sendRedirect("./emploginForm.jsp?errMsg="+errMsg);
	} else {// 실패시 로그인폼으로
	
		System.out.println("로그인성공");	
		session.setAttribute("loginEmp", loginEmp);			
		response.sendRedirect("./empList.jsp");
	}
	
%>
