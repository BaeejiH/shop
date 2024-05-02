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
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">       
    <style>
        body {
            font-family: 'Cinzel', serif;
        }
        .container {
            margin-top: 50px;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .form-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col"></div>
        <div class="col">
            <h1 class="text-center">회원가입</h1>

            <form method="post" action="/shop/customer/checkidAction.jsp">
                <div class="form-group">
                    <label for="checkID">이메일</label>
                    <input type="text" name="checkID" id="checkID" class="form-control" placeholder="이메일을 입력해 주세요">
                    <button type="submit" class="btn btn-info mt-2">중복확인</button>
                    <div>
                        <%
                        String IDcheck = request.getParameter("IDcheck");
                        if ("d".equals(IDcheck)) {
                            out.println("<div class='text-danger'>이미 존재하는 이메일입니다.</div>");
                        } else if ("a".equals(IDcheck)) {
                            out.println("<div class='text-success'>사용 가능한 이메일입니다.</div>");
                        } else {
                            out.println("<div class='text-muted'>이메일을 찾을 수 없습니다.</div>");
                        }
                        %>
                    </div>
                </div>
            </form>

            <form method="post" action="/shop/customer/addcustomerAction.jsp">
                <div class="form-group">
                    <label for="customerID">ID</label>
                    <input type="text" name="customerID" id="customerID" class="form-control">
                </div>
                <div class="form-group">
                    <label for="customerPW">PW</label>
                    <input type="password" name="customerPW" id="customerPW" class="form-control">
                </div>
                <div class="form-group">
                    <label for="Name">이름</label>
                    <input type="text" name="Name" id="Name" class="form-control">
                </div>
                <div class="form-group">
                    <label for="birth">생년월일</label>
                    <input type="date" name="birth" id="birth" class="form-control">
                </div>
                <div class="form-group">
                    <label for="gender">성별</label>
                    <div>
                        <input type="radio" name="gender" id="male" value="남" class="form-check-input">
                        <label for="male" class="form-check-label">남</label>
                    </div>
                    <div>
                        <input type="radio" name="gender" id="female" value="여" class="form-check-input">
                        <label for="female" class="form-check-label">여</label>
                    </div>
                </div>
                <button type="submit" class="btn btn-info">회원가입</button>
            </form>

        </div>
        <div class="col"></div>
    </div>
</div>

</body>
</html>