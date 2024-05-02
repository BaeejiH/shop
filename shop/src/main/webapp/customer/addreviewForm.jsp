<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%>
 
 <%
 	int ordersNo = Integer.parseInt(request.getParameter("orders_no"));
 	System.out.println(ordersNo+"<---orders_no");
 %>   

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
 body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        font-family: 'Noto Sans KR', sans-serif;
    }
    form {
        width: 400px; 
    }

</style>


</head>
<body>



	<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <h1 class="text-center mt-5 mb-4 mr-5">리뷰작성</h1>
            <form action="addreviewAction.jsp" method="post">
                <input type="hidden" name="ordersNo" value="<%= ordersNo %>">
                
                <div class="mb-3">
                    <label for="score" class="form-label">별점</label>
                    <select name="score" id="score" class="form-select">
                        <option value="1">★</option>
                        <option value="2">★★</option>
                        <option value="3">★★★</option>
                        <option value="4">★★★★</option>
                        <option value="5">★★★★★</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">리뷰 내용</label>
                    <textarea name="content" id="content" class="form-control" rows="5"></textarea>
                </div>

                <div class="text-center">
                   <button type="button" class="btn btn-info">리뷰작성</button>
                </div>
            </form>
        </div>
    </div>
</div>


	
	

</body>
</html>