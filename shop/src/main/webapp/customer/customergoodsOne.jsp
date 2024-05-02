<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>       
<%@ page import = "shop.DAO.*" %>


<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%>




<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.print(goodsNo+"<---goodsNo");

	HashMap<String, Object> selectcustomerGoodsOne = GoodsDAO.selectcustomerGoodsOne(goodsNo);
	
	 ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.getReviewgoods(goodsNo);
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodsOne</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        padding-top: 20px;
    }
    .container {
        max-width: 800px;
        margin: auto;
    }
    .table th {
        width: 100px;
        background-color: #f8f9fa;
    }
    .table td {
        vertical-align: middle;
    }
    .product-image {
        max-width: 200px;
        height: auto;
    }
    .review-container {
        border: 3px solid #ccc;
        padding: 10px;
        margin-top: 20px;
    }
    .review-content {
        margin-bottom: 10px;
    }
    .review-rating {
        color: orange;
    }
</style>
</head>
<body>

<h1 class="text-center">Goods Details</h1>

<div class="container">
    <div class="row">
        <div class="col">
        </div>
        <div class="col">
            <table class="table table-hover">
                <tr>
                    <th>No</th>
                    <td><%=  selectcustomerGoodsOne .get("goodsNo") %></td>
                </tr>
                <tr>
                    <th>Image</th>
                    <td><img src="<%=request.getContextPath()%>/upload/<%=(String) ( selectcustomerGoodsOne .get("imagePath"))%>" class="product-image"></td>
                </tr>
                <tr>
                    <th>Category</th>
                    <td><%=selectcustomerGoodsOne.get("category") %></td>
                </tr>
                <tr>
                    <th>Title</th>
                    <td><%= selectcustomerGoodsOne.get("title") %></td>
                </tr>
                <tr>
                    <th>Content</th>
                    <td><%= selectcustomerGoodsOne.get("content") %></td>
                </tr>
                <tr>
                    <th>Price</th>
                    <td><%= selectcustomerGoodsOne.get("price") %></td>
                </tr>
                <tr>
                    <th>Amount</th>
                    <td><%= selectcustomerGoodsOne.get("amount") %></td>
                </tr>
            </table>
            <div><a href="addorder.jsp?goodsNo=<%= selectcustomerGoodsOne.get("goodsNo") %>">주문하기</a></div>

            <div class="review-container">
                <div>★상품후기★</div>
                <% for(HashMap review : reviewList) { %>
                    <div class="review-content">
                        <% for(int i=0; i<(Integer)(review.get("score")); i++) { %>
                            &#127775;
                        <% } %>
                        <span class="review-rating"><%= review.get("content") %></span>
                    </div>
                <% } %>
            </div>
        </div>
        <div class="col">
        </div>
    </div>
</div>

</body>
</html>