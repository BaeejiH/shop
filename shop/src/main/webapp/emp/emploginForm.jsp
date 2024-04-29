	<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인증분기 :세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}


	//세션이 남아있으면 변경된값이 들어가지 않음.꺼지지 않은 브라우저에 세션이 남아있어 같은 값이 중복됨.  서버 stop후 재실행 or 모든 브라우저 창 닫기.  

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .cinzel {
            font-family: "Cinzel", serif;
            font-weight: 400;
            font-style: normal;
        }
        .eeee {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
    </style>
</head>
<body class="cinzel">
<div class="eeee">
    <div>
        <h1>EMP Login</h1>
        <form method="post" action="./emploginAction.jsp">
            <table>
                <tr>
                    <th>Id:</th>
                    <td><input type="text" name="empID" class="form-control" value="" placeholder="아이디"></td>
                </tr>
                <tr>
                    <th>Pw:</th>
                    <td><input type="password" name="emppw" class="form-control" value="" placeholder="비밀번호"></td>
                </tr>
            </table>
            <br>
            <button type="submit" class="btn btn-dark">로그인</button>
            <button class="btn btn-primary" type="button" disabled>
                <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                Loading...
            </button>
            <a href="/shop/emp/addempForm.jsp">회원가입</a>
        </form>
    </div>
</div>
</body>
</html>