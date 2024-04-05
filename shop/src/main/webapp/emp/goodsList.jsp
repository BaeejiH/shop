<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>

<!-- controller layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>

<%
	String category = request.getParameter("category");

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 4;
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
	
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select category,count(*) cnt from goods group by category order by category asc";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1. executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList0 = new ArrayList<HashMap<String, Object>>();
	

	while(rs1.next()){
	
		HashMap<String, Object> m0 = new HashMap<String, Object>();
		m0.put("category", rs1.getString("category"));
		m0.put("cnt", rs1.getInt("cnt"));
		categoryList0.add(m0);
	}
	
	//디버깅
	System.out.println("categoryList");
	
	
	String sql2= "select goods_no no, category, goods_title title, filename,left(goods_content,500)content, goods_price price, goods_amount amount FROM goods WHERE category = ? ORDER BY goods_no DESC limit ?,?;";
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,category);
	stmt2.setInt(2,startRow);
	stmt2.setInt(3,rowPerPage);
	rs2 = stmt2.executeQuery(); 
	
	
	
	//String imagePath = rs2.getString("filename");
	
	
	ArrayList<HashMap<String, Object>> categoryList1 = new ArrayList<HashMap<String, Object>>();
	while(rs2.next()){
		
		String imagePath = rs2.getString("filename"); 
		HashMap<String, Object> m1 = new HashMap<String, Object>();	
		m1.put("no", rs2.getInt("no"));
		m1.put("category", rs2.getString("category"));
		m1.put("title", rs2.getString("title"));
		m1.put("content", rs2.getString("content"));
		m1.put("price", rs2.getInt("price"));
		m1.put("amount", rs2.getInt("amount"));
		m1.put("imagePath", imagePath); 
		
		categoryList1.add(m1);
	}
	
	
	
	String sql3="SELECT goods_no no, category, goods_title title, filename,left(goods_content,500)content, goods_price price, goods_amount amount,(SELECT COUNT(*) FROM goods) AS cnt FROM goods ORDER BY goods_no DESC;";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery(); 
	
	ArrayList<HashMap<String, Object>> categoryList2
	= new ArrayList<HashMap<String, Object>>();
	
	while(rs3.next()){
		String imagePath = rs3.getString("filename");
		HashMap<String, Object> m2 = new HashMap<String, Object>();
		m2.put("no", rs3.getInt("no"));
		m2.put("category", rs3.getString("category"));
		m2.put("title", rs3.getString("title"));
		m2.put("content", rs3.getString("content"));
		m2.put("price", rs3.getInt("price"));
		m2.put("amount", rs3.getInt("amount"));
		m2.put("imagePath", imagePath); 
		categoryList2.add(m2);
	}
	
		
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
		
<style>
.content_wrap{
  width: 200px;
  height: fit-content;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-column-gap: 5px;
  grid-row-gap: 5px;
}
</style>		
		
		
		
		
	</head>
<body>

<!-- 메인 메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empmenu.jsp"></jsp:include>
	</div>	
	
<!-- 상품등록 -->
	<div>
		<a href="./addgoodsForm.jsp">상품등록</a>
	</div>


	<!-- 서브 메뉴 카테고리별 상품리스트 -->
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m0 : categoryList0) {
		%>
		<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m0.get("category"))%>&totalRow=<%=(Integer)(m0.get("cnt"))%>">
					<%=(String)(m0.get("category"))%>
					(<%=(Integer)(m0.get("cnt"))%>)
				</a>
				
		<%
			}
		%>				
	
	</div>
		
	<div>
	<ul class="pagination justify-content-center">


			<%
			if (currentPage > 1) {
			%>
			
			<li class="page-item"><a class="page-link"href="./goodsList.jsp?currentPage=<%=currentPage - 1%>&category=<%=category %>&totalRow=<%=totalRow%>">previous</a></li>				
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
			
			<li class="page-item"><a class="page-link"href="./goodsList.jsp?currentPage=<%=currentPage + 1%>&category=<%=category %>&totalRow=<%=totalRow%>">next</a></li>
							
			<%
			}else{
			%>	
				<li class="page-item"><a class="page-link">next</a></li>
							
			<%
			}
			%>
			
		</ul>
	</div>
	
	<%
		if(category == null){ //카테고리의 값이  null일때 
			for(HashMap m2: categoryList2){
		
	%>

	<div class="container text-center border border-dark">
		<div class="row row-cols-3">	
			<div class="col">
				번호:<%=(Integer) (m2.get("no"))%></div>
			<div class="col">
				카테고리:<%=(String) (m2.get("category"))%></div>
			<div class="col">
				제목:<%=(String) (m2.get("title"))%></div>
			<div class="col image-box">
				이미지:<img src="<%=request.getContextPath()%>/upload/<%=(String) (m2.get("imagePath"))%>" class="image-thumbnail"></div>
			<div class="col">
				내용:<%=(String) (m2.get("content"))%></div>
			<div class="col">
				가격:<%=(Integer) (m2.get("price"))%></div>
			<div class="col">
				수량:<%=(Integer) (m2.get("amount"))%></div>				
		</div>

	</div>

	<%
		}
	}else{ //카테고리의 값이 null이 아닐때
		for(HashMap m1: categoryList1){
	%>
	
			<div>
				<img src="<%=request.getContextPath()%>/upload/<%=(String) (m1.get("imagePath"))%>"></div>
				
			<div >
			<div >
				번호 :
				<%=(Integer) (m1.get("no"))%></div>
			<div>
				카테고리 :
				<%=(String) (m1.get("category"))%></div>
			<div>
				제목 :
				<%=(String) (m1.get("title"))%></div>
			<div>
				내용 :
				<%=(String) (m1.get("content"))%></div>
			<div>
				가격 :
				<%=(Integer) (m1.get("price"))%></div>
			<div>
				수량 :
				<%=(Integer) (m1.get("amount"))%></div>
			</div>	
			

			
				

	<%
		}
	}
	%>
	
	
	
	<%
	
	
	
	%>
	

	



</body>
</html>