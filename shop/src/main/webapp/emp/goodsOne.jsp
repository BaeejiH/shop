<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>       
<%@ page import = "shop.DAO.GoodsDAO" %>




<%
	int goodsNo = Integer.parseInt(request.getParameter("no"));
	System.out.print(goodsNo+"<---no");

	HashMap<String, Object> selectGoodsOne = GoodsDAO.selectGoodsOne(goodsNo);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodsOne</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>

	<h1 class="text-center">goods details</h1>

	<div class="container text-center">
  <div class="row">
    <div class="col">
     
    </div>
    <div class="col">
 	<table border="1" class="table table-hover">
	<tr>
		<th>No</th>
		<td><%= selectGoodsOne.get("goodsNo") %></td>
	</tr>

	<tr>
		<th>Image</th>
		<td><img src="<%=request.getContextPath()%>/upload/<%=(String) (selectGoodsOne.get("imagePath"))%>" width="200"></td>
	</tr>

	<tr>
		 <th>Category</th>
		<td><%= selectGoodsOne.get("category") %></td>
	</tr>
	<tr>
		 <th>Title</th>
		 <td><%= selectGoodsOne.get("title") %></td>
	</tr>
	<tr>
		  <th>Content</th>
		  <td><%= selectGoodsOne.get("content") %></td>
	</tr>
	
	<tr>
		 <th>Price</th>
		 <td><%= selectGoodsOne.get("price") %></td>
	</tr>
	
	<tr>
		 <th>Amount</th>
		<td><%= selectGoodsOne.get("amount") %></td>
	</tr>
	
		
	
</table>
 	
    </div>
    <div class="col">
    
    </div>
  </div>
</div>
	
	
	
	
	






</body>
</html>