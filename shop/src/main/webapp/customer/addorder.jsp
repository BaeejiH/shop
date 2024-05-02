<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="shop.DAO.OrdersDAO" %>
<%@ page import="shop.DAO.GoodsDAO" %>

<%
    // 인증분기	 : 세션변수 이름 - loginEmp
    if(session.getAttribute("logincustomer") == null) {
        response.sendRedirect("/shop/customer/customerloginForm.jsp");
        return;
    }
%> 

<%
    // 세션에서 상품 번호 가져오기
    int goodsNo =  Integer.parseInt(request.getParameter("goodsNo"));
    System.out.println(goodsNo+"<---goodsNo : addorder");

    // GoodsDAO를 사용하여 상품 정보 가져오기
    HashMap<String, Object> selectcustomerGoodsOne = GoodsDAO.selectcustomerGoodsOne(goodsNo);

    // 상품 정보가 있는지 확인 후 처리
    // 상품 번호와 가격,수량의 값을 주문서에 그대로 옮기기 위해 세션에 저장 후 사용.
    if (selectcustomerGoodsOne!= null) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        padding: 20px;
    }
    form {
        max-width: 500px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    h1 {
        text-align: center;
    }
    div {
        margin-bottom: 10px;
    }
    label {
        display: block;
        font-weight: bold;
    }
    input[type="text"],
    input[type="email"],
    button[type="submit"] {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    button[type="submit"] {
       
        color: #fff;
        cursor: pointer;
       
    }
    button[type="submit"]:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <h1>상품 주문하기</h1>
    <form action="addorderAction.jsp" method="post">
        
        <!-- 상품 정보 표시+주문 Form -->
        <div>
            <label for="goodsNo">상품 번호:</label>
            <input type="text" id="goodsNo" name="goodsNo" value="<%= selectcustomerGoodsOne.get("goodsNo") %>" readonly>
        </div>
        <div>
            <label for="goodsprice">상품 가격:</label>
            <input type="text" id="goodsprice" name="goodsprice" value="<%= selectcustomerGoodsOne.get("price") %>" readonly>
        </div>
        
         <div>
            <label for="amount">상품 수량:</label>
            <input type="text" id="amount" name="amount" value="" required>
        </div>
        
        <div>
            <label for="mail">이메일:</label>
            <input type="email" id="mail" name="mail" value="" required>
        </div>
        
        <div>
            <label for="address">주소:</label>
            <input type="text" id="address" name="address" required>
        </div>
           
        <div>
            <button type="submit" class="btn btn-info">주문하기</button>
        </div>
        
    </form>
</body>
</html>
<%
    } else {
        out.println("상품 정보가 없습니다.");
    }
%>