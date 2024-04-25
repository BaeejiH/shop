<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.*" %> 
 
 
 <%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>
 
 
 <%
 	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
 	
 	System.out.println(ordersNo + "<--ordersNo");
 	
 	String sql = "UPDATE orders SET state = '배송완료' WHERE orders_no = ?";
 	
 	
 	int row = OrdersDAO.updatestate(ordersNo);
 	
 	
 	if(row == 1){
 		System.out.println("수정성공");
 		response.sendRedirect("/shop/emp/orderList.jsp");
 	}else {
 		System.out.println("수정실패");
 		response.sendRedirect("/shop/emp/updatestate.jsp");
 	}
 	
 %>
 
 
    
    
