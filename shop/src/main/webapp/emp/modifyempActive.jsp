<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	//empList에서 OFF를 눌렀을 때 on으로 바뀌게 하는 페이지

	String active = request.getParameter("active");
	String empId = request.getParameter("empId");
	System.out.println(active+"<-----active");
	System.out.println(empId+"<-----empId");
	
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt1 = null;
	Connection conn = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		
	String sql1 = "update emp set active= 'ON' where emp_id= ?"; 
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, empId);
	
	System.out.println(stmt1);

	//값이 OFF로 넘어왔을 때 ON으로 변경
	if(active.equals("OFF")){
		int row1 = stmt1.executeUpdate();
		if(row1 == 1){
			System.out.println("ON변경 완료");
			response.sendRedirect("/shop/emp/empList.jsp");
			return;
		}
	}
	
	String sql2 = "update emp set active= 'OFF' where emp_id= ?"; 
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, empId);
	
	System.out.println(stmt2);
	//값이 ON로 넘어왔을 때 OFF으로 변경
	if(active.equals("ON")){
		int row2 = stmt2. executeUpdate();
		if(row2 == 1){
			System.out.println("OFF변경 완료");
			response.sendRedirect("/shop/emp/empList.jsp");
		}
	}
	
%>