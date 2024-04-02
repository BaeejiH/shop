<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	//empList에서 OFF를 눌렀을 때 on으로 바뀌게 하는 페이지

	String active = request.getParameter("active");
	System.out.println(active+"<-----active");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	//Data truncated for column, 쿼리문에서 active가 데이터 타입이 다르게 나옴. 
	String sql1 = "update emp set active='?'"; 
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, active);
	rs1 = stmt1.executeQuery(); 
	
	if(rs1.equals("OFF")){
		System.out.println("ON으로 변경");
	}else{
		
	}
		
%>