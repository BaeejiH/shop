<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.DAO.OrdersDAO" %>
<%@ page import="shop.DAO.GoodsDAO" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
    
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%> 
    
    
    
 <%
     int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
 	int price = Integer.parseInt(request.getParameter("goodsprice"));
     int amount = Integer.parseInt(request.getParameter("amount"));
     String address = request.getParameter("address");
     String mail = request.getParameter("mail");
    
     
     System.out.println(goodsNo + "<------goodsNo");
     System.out.println(price + "<------goodsprice");
     System.out.println(amount + "<------amount");
     System.out.println(address + "<------address");
     System.out.println(mail + "<------mail");
     
     int row = GoodsDAO.updateGoodsamount(goodsNo, amount);
     System.out.println(row+"<----GoodsDAO.updateGoodsamount");
     //상품수량이 업데이트 된다면 주문을 한다. 아니라면 상품 업데이트 실패
 	if(row == 1){
 		//상품 수량 수정 성공
 		System.out.println("상품 수량 수정 성공");
 		row = OrdersDAO.insertorders(mail, goodsNo, amount, price, address);
 		//주문신청 내역을 추가할때 orders 테이블의 번호 값을 받지못해서 orders 테이블의 번호 기본값을 Auto로 설정. 주문신청하면 알아서 주문번호 생성되도록.
 		if(row == 1){
 			//입력 성공
 			System.out.println("입력 성공");
 			response.sendRedirect("/shop/customer/ordersList.jsp");
 			return;
 		} else {
 			//입력 실패
 			System.out.println("입력 실패");
 		}
 	} else {
 		//상품 수량 수정 실패
 		System.out.println("상품 수량 수정 실패");
 	}
 	response.sendRedirect("/shop/customer/customergoodsOne.jsp?goodsNo=" + goodsNo);
     
     
     
     
 %>   
