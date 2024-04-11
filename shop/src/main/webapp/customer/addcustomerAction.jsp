<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
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
	String Name = request.getParameter("Name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	String sql1 ="INSERT into customer (mail, pw, name, birth, gender) VALUES (?, PASSWORD(?),?,?,?)";
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;		
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, customerID);
	stmt1.setString(2, customerPW);
	stmt1.setString(3, Name);
	stmt1.setString(4, birth);
	stmt1.setString(5, gender);
	
	System.out.println(stmt1+"<--stmt");
	ResultSet rs1 = null;
	
	
	int row = 0;
	row = stmt1.executeUpdate();
	
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