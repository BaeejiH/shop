<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.DAO.*"%>

<%
	//인증분기 
	if(session.getAttribute("logincustomer") != null) {
		response.sendRedirect("/shop/customer/customergoodsList.jsp");
		return; //로그인이 된 상태이기 때문에 null이 아닐시에 List로 이동
	}
%>


<%
	String customerID = request.getParameter("customerID"); //id 값을 요청해야하는데 customer 테이블에는 id라는 컬럼이 없음. mail로 대체? --> mail을 form에서 넘겨주는 customerID로 일치.
	String customerPW = request.getParameter("customerPW");
	
	System.out.println(customerID+"<---id");
	System.out.println(customerPW+"<---pw");
	

	  HashMap<String, Object> logincustomer = customerDAO.customerLogin(customerID, customerPW);

	    if (logincustomer != null) {
	        // 로그인 성공
	        session.setAttribute("logincustomer", logincustomer);
	        response.sendRedirect("./customergoodsList.jsp");
	    } else {
	        // 로그인 실패
	        String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "UTF-8");
	        response.sendRedirect("./customerloginForm.jsp?errMsg=" + errMsg);
	    }
	
	// 로그인창에서 암호화된 비밀번호가 값은 넘어가는데 로그인 실패로 뜨는 현상. 쿼리에서 암호화를 풀었을시 로그인 성공함. 암호화된 비밀번호로 로그인 하는 경우 수정 필요.
	// 회원 가입한 아이디와 비밀번호는 암호화가 되어있어도 로그인 성공.  기존 DB데이터 값의 문제일 가능성 높음.

	
%>
