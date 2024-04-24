<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="shop.DAO.OrdersDAO" %>

<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>

<%
    // 페이지당 행 수와 현재 페이지 번호 설정
    int rowPerPage = 10; // 페이지당 행 수
    int currentPage = 1; // 현재 페이지 번호
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    int startRow = (currentPage - 1) * rowPerPage; // 시작 행 계산

    // 전체 주문 목록 가져오기
    ArrayList<HashMap<String, Object>> ordersList = OrdersDAO.selectOrdersListAll(startRow, rowPerPage);

    // 전체 주문 수 계산
   
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전체 주문 목록</title>
</head>
<body>
    <h1>전체 주문 목록</h1>
    <table border="1">
        <thead>
            <tr>
                <th>주문 번호</th>
                <th>상품 번호</th>
                <th>상품 제목</th>
            </tr>
        </thead>
        <tbody>
            <% 
                for(HashMap<String, Object> order : ordersList) { 
            %>
            
            <tr>
                <td><%= order.get("ordersNo") %></td>
                <td><%= order.get("goodsNo") %></td>
                <td><%= order.get("goodsTitle") %></td>
            </tr>
            
            <%
                } 
            %>
        </tbody>
    </table>

    
</body>
</html>