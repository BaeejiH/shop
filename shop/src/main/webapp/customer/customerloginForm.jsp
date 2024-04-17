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
		<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">   		
<Style>
 .cinzel {
      font-family: "Cinzel", serif;
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
   }


</Style>		
				
	</head>
<body class="cinzel">

	           
  <div class="container">
  <div class="row">
    <div class="col">
      
    </div>
    <div class="col">
      <h1>customer Login</h1>
	<form method=post action="./customerloginAction.jsp">
               <table>
                  <tr>
                     <th>Id:</th>
                     <td><input type="e" name="customerID" class=form-control
                        value="" placeholder="아이디"></td>   <br>
                  </tr> <br>
      
                  <tr>
                  <br>
                     <th>Pw:</th>
                     <td><input type="password" name="customerPW"
                        class=form-control value="" placeholder="비밀번호"></td>
                  </tr>
               </table>
               <br>
               <button type="submit" class="btn btn-dark">로그인</button>
               <button class="btn btn-primary" type="button" disabled>
              <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
              Loading...
            </button>
             <a href="/shop/customer/addcustomerForm.jsp">회원가입</a>
            </form>
    </div>
    <div class="col">
    
   
     
    </div>
  </div>
</div>      
            
            
            
            
            
            

</body>
</html>