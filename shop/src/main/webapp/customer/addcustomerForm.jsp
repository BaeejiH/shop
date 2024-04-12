<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//인증분기 
	if(session.getAttribute("logincustomer") != null) {
		response.sendRedirect("/shop/customer/customergoodsList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">		
				
		
	</head>
<body>



	<div class="container text-center">
		<div class="row">
			<div class="col"></div>
			<div class="col">
				<h1 class="text-center">회원가입</h1>



					<form method="post" action="/shop/customer/checkidAction.jsp">
					
					<div>checkId:<input type="text" name="checkID" value="" placeholder="email을 입력해 주세요"><button type="submit">중복확인</button></div>
				
				
					</form>





				<form method="post" action="/shop/customer/addcustomerAction.jsp">
					<table class="table table-dark table-hover">
										
						<tr>
							<td>Id:<input type="text" name="customerID"></td>
						</tr>

						<tr>
							<td>Pw:<input type="password" name="customerPW"></td>
						</tr>

						<tr>
							<td>name:<input type="text" name="Name"></td>
						</tr>

						<tr>
							<td>birth:<input type="date" name="birth"></td>
						</tr>

						<tr>
							<td>gender:<input type="radio" name="gender" value="남">남<input
								type="radio" name="gender" value="여">여
							</td>
						</tr>

						<tr>
							<td><button type="submit">회원가입</button></td>
						</tr>

					</table>
				</form>

			</div>
			<div class="col"></div>
		</div>
	</div>










</body>
</html>