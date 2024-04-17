<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>


<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>


<%
	
	int goodsNo = Integer.parseInt(request.getParameter("no"));
	System.out.println(goodsNo+"goodsnumber");


	
	String sql1 = "DELETE FROM goods WHERE goods_no=?";
	PreparedStatement stmt1 = null;
	Connection con = null;
	con = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt1 = con.prepareStatement(sql1);
	stmt1.setInt(1, goodsNo);
	System.out.println(stmt1);
	
	 int row = stmt1.executeUpdate();
	   
	   
	   System.out.println(row +"<-게시글 row");
	   
	   if(row == 1){ 
	      response.sendRedirect("/shop/emp/goodsList.jsp");
	      System.out.println("삭제성공");
	   }else{
	      response.sendRedirect("");
	      System.out.println("삭제실패");
	   }
	
%>