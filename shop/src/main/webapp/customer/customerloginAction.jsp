<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%
	//인증분기 :세션변수 이름 -loginEmp
	if(session.getAttribute("logincustomer") != null) {
		response.sendRedirect("/shop/customer/goodList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>


<%
	String customerId = request.getParameter("customerId"); //id 값을 요청해야하는데 customer 테이블에는 id라는 컬럼이 없음. mail로 대체?
	String customerpw = request.getParameter("customerpw");
	
	String sql1 = "select mail,pw,name,birth,gender from customer where id = ? and pw = ? "; 
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, customerId);
	stmt1.setString(2, customerpw);
	
	System.out.println(stmt1+"<--stmt");
	
	
	rs1 = stmt1.executeQuery();
	
	if(rs1.next()){//성공시 리스트로
		System.out.println("로그인성공");
		HashMap<String, Object> logincustomer = new HashMap<String, Object>();
		logincustomer.put("customerId",rs1.getString("customerId"));

		session.setAttribute("logincoustomer", logincustomer);
		
		//디버깅
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("logincustomer"));
		System.out.println((String)(m.get("customerId")));

		
		
		response.sendRedirect("./customerList.jsp");
	} else {// 실패시 로그인폼으로
		System.out.println("로그인실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
		response.sendRedirect("./customerloginForm.jsp?errMsg="+errMsg);
	}
	
%>
