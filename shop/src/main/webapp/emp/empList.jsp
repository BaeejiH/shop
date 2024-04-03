<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>


<!-- Controller Layer -->

<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>

<%
	//현재페이지
	//페이징(페이지가 다음 페이지로 넘어가는 것)
	//리스트 
	//처음 페이지랑 마지막 페이지
	//클라이언트가 현재 페이지를 요청
	//한 페이지당 보여지는 페이지 개수 = rowPerpage
	
	// request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = (currentPage-1)*rowPerPage;
	
	//직원 리스트 개수
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement empstmt = null;
	Connection conn = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String empsql = "select count(*) cnt From emp";
	ResultSet emprs = null;
	empstmt = conn.prepareStatement(empsql);
	emprs =empstmt.executeQuery();
	
	int totalRow = 0;
	if(emprs.next()) {
	      totalRow = emprs.getInt("cnt");
	   }
	//마지막 페이지
	int lastPage = totalRow / rowPerPage;
	   if(totalRow % rowPerPage != 0) {
	      lastPage = lastPage + 1;
	   }
	
%>

<!-- Model Layer -->

<%
	// 특수한 형태의 데이터(RDBMS:mariadb) 
	// -> API사용(JDBC API)하여 자료구조(ResultSet) 취득 
	// -> 일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득
	Class.forName("org.mariadb.jdbc.Driver");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	rs = stmt.executeQuery(); 
	// JDBC API 종속된 자료구조 모델 ResultSet  -> 기본 API 자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String, Object>> list
		= new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs.getString("empId"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("active", rs.getString("active"));
		list.add(m);	}
	// JDBC API 사용이 끝났다면 DB자원들을 반납
%>

<!-- View Layer : 모델(ArrayList<HashMap<String, Object>>) 출력 -->
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
	<!-- empmenu.jsp include:주체(서버) vs redirect(주체:클라이언트) -->
	<!--empmenu.jsp include : 주체(서버) vs redirect(주체:클라이언트) -->
		
	<div>
		<jsp:include page="/emp/inc/empmenu.jsp"></jsp:include>
	</div>


	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="col">
				<h1>Emp List</h1>
				<table border="1" class="table table-hover">
					<tr>
						<th>empId</th>
						<th>empName</th>
						<th>empJob</th>
						<th>hireDate</th>
						<th>active</th>
					</tr>
					<%
					for (HashMap<String, Object> m : list) {
					%>
					<tr>
						<td><%=(String) (m.get("empId"))%></td>
						<td><%=(String) (m.get("empName"))%></td>
						<td><%=(String) (m.get("empJob"))%></td>
						<td><%=(String) (m.get("hireDate"))%></td>
						<td>
						<% 
						HashMap<String, Object> sm = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
							if((Integer)(sm.get("grade"))>0) {
						%>	
						<a href='modifyempActive.jsp?empId=<%=(String)(m.get("empId"))%>&active=<%=(String)(m.get("active"))%>'> 
						<%=(String)(m.get("active"))%>
						</a>					
						<!-- 값을 넘겨줄 때 empId의 값을 포함시키지 않고 넘겨서 파라미터에 null이 계속 들어감. 값을 보내는 페이지에서 get방식과 post방식 까먹지 말기. -->					
						<% 
						}
						%>
						</td>
					</tr>
					<%
					}
					%>
				</table>
				<div>
					<a href="/shop/emp/emplogout.jsp">로그아웃</a>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>


	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">

			<%
			if (currentPage > 1) {
			%>
			
			<li class="page-item"><a class="page-link"
				href="./empList.jsp?currentPage=1">처음페이지</a></li>
			<li class="page-item"><a class="page-link"
				href="./empList.jsp?currentPage=<%=currentPage - 1%>">이전페이지</a></li>
				
			<%
			} else {
			%>
			
			<li class="page-item disabled"><a class="page-link"
				href="./empList.jsp?currentPage=1">처음페이지</a></li>
			<li class="page-item disabled"><a class="page-link"
				href="./empList.jsp?currentPage=<%=currentPage - 1%>">이전페이지</a></li>
				
			<%
			}
			if (currentPage < lastPage) {
			%>
			
			<li class="page-item"><a class="page-link"
				href="./empList.jsp?currentPage=<%=currentPage + 1%>">다음페이지</a></li>
			<li class="page-item"><a class="page-link"
				href="./empList.jsp?currentPage=<%=lastPage%>">마지막페이지</a></li>
				
			<%
			}
			%>
		</ul>
	</nav>






</body>
</html>