<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.DAO.ReviewDAO" %>
<%@ page import="java.util.*" %>    
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%>



<%
    // 폼에서 전송된 데이터 받기
    int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
    int score = Integer.parseInt(request.getParameter("score"));
    String content = request.getParameter("content");
    
    System.out.println(ordersNo+"<---ordersNo");
    System.out.println(score+"<---score");
    System.out.println(content+"<---content");
    
  
   	ReviewDAO.addReview(ordersNo, score, content);
   	
    response.sendRedirect("customergoodsList.jsp");
		   
%>