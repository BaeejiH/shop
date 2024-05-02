<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.DAO.OrdersDAO" %>


<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%>


<%
    // 세션에서 로그인한 사용자 정보 가져오기
    HashMap<String, Object> loginMember = (HashMap<String, Object>) session.getAttribute("logincustomer");
    
    // 로그인한 사용자의 이메일 가져오기
    String customerID = (String) loginMember.get("customerID");
    
    int currentPage = 1;
    int startRow = (currentPage - 1) * 10; // 페이지당 시작 행
    int rowPerPage = 10; // 페이지당 행 수

    // 로그인한 사용자의 주문 목록 가져오기
    ArrayList<HashMap<String, Object>> ordersList = OrdersDAO.selectOrdersByCustomerID(customerID, startRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문내역</title>
    
<style>
	body {
	    font-family: Arial, sans-serif;
	    background-color: #f8f9fa;
	    padding: 20px;
	}
	
	h1 {
	    text-align: center;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	table, th, td {
	    border: 1px solid #ccc;
	}
	
	th, td {
	    padding: 10px;
	    text-align: center;
	}
	
	th {
	    background-color: #f0f0f0;
	}
	
	a {
	    color: #007bff;
	    text-decoration: none;
	}
	
	a:hover {
	    text-decoration: underline;
	}



</style>    
    
    
    
    
</head>
<body>
    <h1>주문내역</h1>
    <table border="1" class="cccc">
        <tr>
            <th>주문번호</th>
            <th>상품번호</th>
            <th>상품명</th>
            <th>주문날짜</th>
            <th>주문상태</th>
            <th></th>	
        </tr>
        <% 
        	for (HashMap<String, Object> order : ordersList) { 
        %>
            <tr>
                <td><%= order.get("orders_no") %></td>
                <td><%= order.get("goods_no") %></td>
                <td><%= order.get("goods_title") %></td>
                <td><%= order.get("create_date") %></td>
                <td><%= order.get("state") %></td>
                <td>
                	<% 
                        // 주문 상태가 "배송완료"인 경우에만 리뷰 작성 페이지로의 링크를 추가
                        if ("배송완료".equals(order.get("state"))) { 
                    %>
                        <a href="/shop/customer/addreviewForm.jsp?orders_no=<%= order.get("orders_no") %>">리뷰 작성</a>
                    <% 
                   		 } 
                    %>              
                </td>
                              
            </tr>
            
                 
        <% 
        	}
        %>
    </table>
</body>
</html>