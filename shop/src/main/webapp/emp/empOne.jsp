<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>


<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/emploginForm.jsp");
		return;
	}
%>

<%
	String empId = request.getParameter("empId");
	System.out.println(empId+"<-----empid");
	
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	String sql1 = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp where emp_id = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1,empId);
			
	rs1 = stmt1.executeQuery(); 
	
	ArrayList<HashMap<String, Object>> empOnelist
	= new ArrayList<HashMap<String, Object>>();


while(rs1.next()) {
	HashMap<String, Object> m = new HashMap<String, Object>();
	m.put("empId", rs1.getString("empId"));
	m.put("empName", rs1.getString("empName"));
	m.put("empJob", rs1.getString("empJob"));
	m.put("hireDate", rs1.getString("hireDate"));
	m.put("active", rs1.getString("active"));
	empOnelist.add(m);	}

	

%>



<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empOne</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 		
		
		
		
	</head>
<body>

</body>

<%
	// goodList에서 이름을 눌렀을때 정보 상세보기
	//필요항목
	//emp_id
	//grade (아직 미정)
	//emp_pw
	//emp_name
	//emp_job
	//날짜??
			
	// 요청 받아야 하는 값	
	//String emp_id = request.get.parameter("emp_id");
	//Int garde = request.get.parameter("grade");
	//String emp_pw = request.get.parameter("emp_pw");
	//String emp_name = request.get.parameter("emp_name");
	//String emp_job = request.get.parameter("emp_job");
%>

	<h1 class="text-center">Emp details</h1>











<div class="container text-center">
  <div class="row">
    <div class="col">
     
    </div>
    <div class="col">
 	<table border="1" class="table table-hover">
	<tr>
		<td>emp_id:</td>
		<td><%= empOnelist.get(0).get("empId") %></td>
	</tr>

	<tr>
		<td>emp_name:</td>
		<td><%= empOnelist.get(0).get("empName") %></td>
	</tr>

	<tr>
		<td>emp_job:</td>
		<td><%= empOnelist.get(0).get("empJob") %></td>
	</tr>
	<tr>
		<td>hireDate:</td>
		<td><%= empOnelist.get(0).get("hireDate") %></td>
	</tr>
	<tr>
		<td>active:</td>
		<td><%= empOnelist.get(0).get("active") %></td>
	</tr>
</table>
 	
    </div>
    <div class="col">
    
    </div>
  </div>
</div>










</html>