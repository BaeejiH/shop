<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.customerDAO" %>

<!-- controller layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("logincustomer") == null) {
		response.sendRedirect("/shop/customer/customerloginForm.jsp");
		return;
	}
%>

<%
	
	String category = request.getParameter("category");

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 20;
	int startRow = (currentPage-1)*rowPerPage;
	
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement goodsstmt = null;
	Connection conn = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String goodssql = "select count(*) cnt From goods";
	ResultSet goodsrs = null;
	goodsstmt = conn.prepareStatement(goodssql);
	goodsrs =goodsstmt.executeQuery();
	
	int totalRow = 0;
	if(goodsrs.next()) {
	      totalRow = goodsrs.getInt("cnt");
	   }
	//마지막 페이지
	int lastPage = totalRow / rowPerPage;
	   if(totalRow % rowPerPage != 0) {
	      lastPage = lastPage + 1;
	   }   
	   //전체 페이지를 현재 보이는 페이지로 나눴을때 0이 아니라면 +1을 해준다.
	   // 107페이지라고 가정하면 현재 보이는 페이지 10페이지로 나눴을 때 10 하고 나머지 7. 그럼으로 10페이지 +나머지 한페이지 = 11페이지.
%>	

<!--ㅡmodel layer -->
<% 

	ArrayList<HashMap<String, Object>> getcategoryList = customerDAO.getcategoryList();
	
	
	ArrayList<HashMap<String, Object>> customerLsit 
	= customerDAO.ppcustomerList(category, startRow, rowPerPage);
	

	

	

	
		

%>
	
	<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title>goodsList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">   
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">				
	<link rel="precons.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatinect" href="https://fontc.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">









<style>
.menu {
	border-bottom-width:1px; 
	border-bottom-style:solid;
	border-bottom-color:gray;
	width: auto;
	height: 60px;
}

.foot {
	background-color:#DAD9FF;
	width: auto;
	height: 1300px;
}

.menu-text {
	font-size: 15px;
	color: #888
}

.top-menu {
	width: 300px;
	height: 50px;
}

.ss {
	color: black;
}

.zzz {
	width: 100px;
	height: auto;
}

.na {
    margin-left: 300px;
}

.nb {
    margin-left: 100px;
}

.ccc {
  font-family: "Bagel Fat One", system-ui;
  font-weight: 400;
  font-style: normal;
}



</style>
			
			
			
		</head>
	<body>
	
	
	
	<ul class="nav">
			<li class="nav-item"><jsp:include page="/customer/Cinc/customermenu.jsp"></jsp:include></li>	
		</ul>
		
		<div><a href ="/shop/customer/customerlogout.jsp">로그아웃</a></div>
	
	
	
	  <div class="text-center d-flex align-items-end justify-content-center">

                <div>

                    <div><H2><img src="/shop/upload/logo.png" class="zzz"></H2></div>
                    
          

                </div>

            </div>
	
	
	
	  <div class="text-center d-flex align-items-end justify-content-center">

                <div>

                    <div><H2 class="ccc">애견 용품</H2></div>

                    <div class="ccc">dog</div>

                </div>

            </div>
            
  
            
                   
            

				
		
	<!-- 상품등록 -->
	

	
			
		
		
	

	
		<!-- 서브 메뉴 카테고리별 상품리스트 -->
		
		
		
		 	<nav class="kkk menu d-flex align-items-center mt-3">
			<a href="/shop/customer/customergoodsList.jsp"  class="nb ss nav nav-fill w-100 d-flex">전체</a>
			<%
				for(HashMap m0 : getcategoryList) {
			%>
			<b><a href="/shop/customer/customergoodsList.jsp?category=<%=(String)(m0.get("category"))%>" class="na ss nav nav-fill w-100 d-flex">
						<%=(String)(m0.get("category"))%></b>					
					</a>
					
			<%
				}
			%>				
			
			</nav>
		
		
		<br>		<br>		<br>		<br>		<br>
		
		
	
		<%
				if (category == null) { //카테고리의 값이  null일때 
					int counter = 0;{
		%>

<div class="container">
    <div class="row">
        <% 
            for (HashMap m2 : customerLsit) {
        %>

        
        <div class="col-md-3 mb-4 ">
            <div class="card h-100">
                <img src="<%=request.getContextPath()%>/upload/<%=(String) (m2.get("imagePath"))%>" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">제목: <%=(String) (m2.get("title"))%></h5>
                    <p class="card-text">
                        번호: <%=(Integer) (m2.get("no"))%><br> 
                        카테고리: <%=(String) (m2.get("category"))%><br>
                        가격: <%=(Integer) (m2.get("price"))%>                   
						
			
                    </p>
                </div>
            </div>
        </div>

        <% 
                counter++; // 이미지 카운터를 증가시킨다.
                // 이미지 카운터가 4개 일때 새로운 행을시작한다. 이미지 가로 4개로 5줄. rowperpage 20으로 설정.
                if (counter % 4 == 0) { 
        %>
    </div>
    <div class="row">
        <% 
                }
            } 
        %>
    </div>
</div>

	<%
	}
	%>
				
	<%
					} else { //카테고리의 값이 null이 아닐때
					for (HashMap m1 : customerLsit) {
					%>
		<div class="container text-center">
			<div class="row row-cols-3">
			
			<div class="col image-box">
				<img src="<%=request.getContextPath()%>/upload/<%=(String) (m1.get("imagePath"))%>"></div>
			
			
				<div class="col">
					번호 :
					<%=(Integer) (m1.get("no"))%></div>
				<div class="col">
					카테고리 :
					<%=(String) (m1.get("category"))%></div>
				<div class="col">
					제목 :
					<%=(String) (m1.get("title"))%></div>
				<div class="col">
					내용 :
					<%=(String) (m1.get("content"))%></div>
				<div class="col">
					가격 :
					<%=(Integer) (m1.get("price"))%></div>
				<div class="col">
					수량 :
					<%=(Integer) (m1.get("amount"))%></div>
				</div>
		</div>
	
		<%
			}
		}
		%>
		
		
			
		<div>
		<ul class="pagination justify-content-center">


			<%
			if (currentPage > 1) {
			%>

			<li class="page-item"><a class="page-link"
				href="./customergoodsList.jsp?currentPage=<%=currentPage - 1%>&category=<%=category%>&totalRow=<%=totalRow%>">previous</a></li>
			<%
			} else {
			%>
			<li class="page-item"><a class="page-link">previous</a></li>

			<%
			}
			%>
			<li class="page-item"><a class="page-link"><%=currentPage%></a></li>

			<%
			if (currentPage < lastPage) {
			%>

			<li class="page-item"><a class="page-link"
				href="./customergoodsList.jsp?currentPage=<%=currentPage + 1%>&category=<%=category%>&totalRow=<%=totalRow%>">next</a></li>

			<%
			} else {
			%>
			<li class="page-item"><a class="page-link">next</a></li>

			<%
			}
			%>


		</ul>
		</div>
		

		<nav class="foot">
		<br><br><br><br><br>
			<div class="container text-center">전화번호: 02-xxx-xxxx</div>
			<div class="container text-center">전화번호: 02-xxx-xxxx</div>
			<div class="container text-center">전화번호: 02-xxx-xxxx</div>
			<div class="container text-center">전화번호: 02-xxx-xxxx</div>
			<div class="container text-center">전화번호: 02-xxx-xxxx</div>
			<div class="container text-center">전화번호: 02-xxx-xxxx</div>
			<div class="container text-center">전화번호: 02-xxx-xxxx</div>
		</nav>
		
		
	
	



</body>
</html>