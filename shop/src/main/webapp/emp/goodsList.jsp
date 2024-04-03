<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%
	//인증분기 :세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}

	//세션이 남아있으면 변경된값이 들어가지 않음.꺼지지 않은 브라우저에 세션이 남아있어 같은 값이 중복됨.  서버 stop후 재실행 or 모든 브라우저 창 닫기.  
%>


<%
	int currentPage = 1;
	if(request.getParameter("currenPage")!= null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	/*
	카테고리가 null이면
	select * from goods
	아니면
	select*from goods where category=?
	*/
	String category = request.getParameter("category");
	
	String sql2= "select*from goods";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery(); 
	
	
	
	String sql3="select*from where category=?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, category);
	rs3 = stmt3.executeQuery(); 
	
	
	//카테고리가 null인 경우 
	if(category.equals(null)){
		
		ArrayList<HashMap<String, Object>> categorylist
		= new ArrayList<HashMap<String, Object>>();
		
		while(rs2.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs2.getString("category"));
			m.put("cnt", rs2.getInt("cnt"));
			categoryList.add(m);
		}
%>	
<%		
	//카테고리가 null이 아닌 경우
	}else {
		
		ArrayList<HashMap<String, Object>> categorylist
		= new ArrayList<HashMap<String, Object>>();
		
		while(rs3.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs3.getString("category"));
			m.put("cnt", rs3.getInt("cnt"));
			categoryList.add(m);
	}
	
%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select category,count(*) cnt from goods group by category order by category asc";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1. executeQuery();
	
	ArrayList<HashMap<String, Object>> list
	= new ArrayList<HashMap<String, Object>>();
	
	while(rs1.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs1.getString("category"));
		m.put("cnt", rs1.getInt("cnt"));
		categoryList.add(m);
	}
	//디버깅
	System.out.println("categoryList");
%>

<!-- Model Layer -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>goodsList</title>
	</head>
<body>

<!-- 메인 메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empmenu.jsp"></jsp:include>
	</div>	
	
<!-- 상품등록 -->
	<div>
		<a href="shop/emp/addgoodsForm.jsp">상품등록</a>
	</div>


	<!-- 서브 메뉴 카테고리별 상품리스트 -->
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
		<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
				</a>
				
		<%
			}
		%>				
	
	</div>



</body>
</html>