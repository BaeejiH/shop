<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>

<%
	//인증분기 
	if(session.getAttribute("logincustomer") != null) {
		response.sendRedirect("/shop/customer/customergoodsList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>

<%
	String checkID = request.getParameter("checkID");
	
	System.out.println(checkID+"<--checkmail");
	
	String sql1 ="select mail customerID,pw customerPW,name,birth,gender from customer where mail = ?"; 
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;		
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, checkID);
	System.out.println(stmt1+"<--stmt");
	ResultSet rs1 = null;
	rs1 = stmt1.executeQuery();	
	
	
	 if (rs1.next()) { 
	        System.out.println("이미 존재하는 이메일 입니다");
	    } else {
	        System.out.println("사용 가능한 이메일 입니다");
	    }    
	
%>





