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
		<td><%=  selectcustomerGoodsOne .get("goodsNo") %></td>
	</tr>

	<tr>
		<th>Image</th>
		<td><img src="<%=request.getContextPath()%>/upload/<%=(String) ( selectcustomerGoodsOne .get("imagePath"))%>" width="200"></td>
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
	
	<br>	<br>
    
    
    <div>
		<div>상품후기</div>
		<%
			for(HashMap review : reviewList){
		%>
				<div>
					<div>
						<%
							for(int i=0; i<(Integer)(review.get("score")); i=i+1) {
						%>
								&#127775;
						<%
							}
						%>
						
						
						
					</div>
					<div><%=review.get("content") %></div>
				</div>
		<%
			}
		%>
	</div>
    
    
    
    
    
    
    
    
    
    </div>
    <div class="col">
    
    </div>
  </div>
</div>
	
	
	
	






</body>
</html>