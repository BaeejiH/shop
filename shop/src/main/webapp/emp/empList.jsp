<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	//인증분기 :세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>
<% 
 // 출력 리스트 모듈
   int currentPage = 1;
   if(request.getParameter("currentPage") != null) {
      currentPage = Integer.parseInt(request.getParameter("currentPage"));
   }
   
   int rowPerPage = 10;
   /*
   if(request.getParameter("rowPerPage") != null) {
      rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
   }
   */
   
   int startRow = (currentPage-1)*rowPerPage; // 1-0, 2-10, 3-20, 4-30,....
   
   String searchWord = ""; //null은 절대 들어갈 수 없음
   if(request.getParameter("searchWord") != null) {
      searchWord = request.getParameter("searchWord");
   }
%>

<%
	String sql1="select emp_id empId, emp_name empName, emp_job empJob,  hire_date hireDate, active from emp order by active asc, hire_date desc";
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
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
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
   }


</style>		
		
		
		
	</head>
<body class="cinzel">
	<h1>EMP List</h1>
		<table class="table table-dark table-striped">
			<tr>
				<td>empName</td>
				<td>empJop</td>
				<td>hireDate</td>
				<td>active</td>
			</tr>
						 
               <%//자바 열고
               while (rs1.next()) {
               %><!-- 자바 닫고 -->
               <tr>
                  
                  <td><%=rs1.getString("empName")%></td>
                  <td><%=rs1.getString("empJob")%></td>
                  <td><%=rs1.getString("hireDate")%></td><!-- jsp페이지에서 보여지는 자바코드 -->
                  <td><%=rs1.getString("active")%></td>
               </tr>
               <%
               }
               %>
					
		</table>

</body>
</html>