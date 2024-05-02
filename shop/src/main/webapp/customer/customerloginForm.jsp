<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>customer Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Cinzel', serif;
        }
        .center-content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-form {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            margin-bottom: 10px;
        }
        .login-form button[type="submit"] {
            margin-top: 10px;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="center-content">
    <div class="login-form">
        <h1 class="text-center">customer Login</h1>
        <form method="post" action="./customerloginAction.jsp">
            <div class="mb-3">
                <input type="text" name="customerID" class="form-control" value="" placeholder="아이디">
            </div>
            <div class="mb-3">
                <input type="password" name="customerPW" class="form-control" value="" placeholder="비밀번호">
            </div>
            <div class="mb-3">
                <button type="submit" class="btn btn-info">로그인</button>
            </div>
            <a href="/shop/customer/addcustomerForm.jsp">회원가입</a>
        </form>   
    </div>
</div>

</body>
</html>