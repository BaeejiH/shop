<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page import = "shop.DAO.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>

<%
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.getCategoryList();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
		
	</head>
<body>

	<ul class="nav">
		<li class="nav-item"><jsp:include page="/emp/inc/empmenu.jsp"></jsp:include></li>


	</ul>

	<div class="container text-center">
		<div class="row">
			<div class="col"></div>
			<div class="col">
				<h1>CategoryList</h1>

				<table border="1" class="table table-hover">
					<tr>
						<td>category</td>
						<td>createDate</td>
					</tr>




			<%
				for(HashMap<String, Object> category : categoryList ) {
			%>
			<tr>
				<td><%= category.get("category") %></td>
	            <td><%= category.get("createDate") %></td>
			</tr>

			<%
				}
			%>
				</table>
			</div>
			<div class="col"></div>
		</div>
	</div>





</body>
</html>