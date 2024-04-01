<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	//인증분기 :세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>

<%
	String empId = request.getParameter("empID");
	String emppw = request.getParameter("emppw");
	
	String sql1 = "select emp_id empId from emp where active='ON' and emp_id =? and emp_pw = password(?)";
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, empId);
	stmt1.setString(2, emppw);
	
	System.out.println(stmt1+"<--stmt");
	
	
	rs1 = stmt1.executeQuery();
	
	if(rs1.next()){//성공시 리스트로
		System.out.println("로그인성공");
		session.setAttribute("loginEmp", rs1.getString("empID"));
		response.sendRedirect("./empList.jsp");
	} else {// 실패시 로그인폼으로
		System.out.println("로그인실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
		response.sendRedirect("./emploginForm.jsp?errMsg="+errMsg);
	}
	
%>


emploginAction.jsp






