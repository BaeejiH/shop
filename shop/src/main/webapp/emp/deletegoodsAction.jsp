<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.*"%>


<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>


<%
	
	int goodsNo = Integer.parseInt(request.getParameter("no"));
	

	 int row = GoodsDAO.deleteGoods(goodsNo);
	   	   
	   if(row == 1){ 
	      response.sendRedirect("/shop/emp/goodsList.jsp");
	      System.out.println("삭제성공");
	   }else{
	      response.sendRedirect("");
	      System.out.println("삭제실패");
	   }
	
%>