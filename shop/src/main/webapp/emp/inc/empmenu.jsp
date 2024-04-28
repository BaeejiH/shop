<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>




<%
	

	
	//로그인 멤버와 empId 디버깅
	HashMap<String, Object> loginMember = (HashMap<String, Object>) session.getAttribute("loginEmp");
	if (loginMember == null) {
	    System.out.println("loginMember 객체가 null입니다.");
	} else {
	    System.out.println("loginMember 객체: " + loginMember);
	    System.out.println("empid: " + loginMember.get("empid"));
	}


%>





<br>


<div>
	<a href="/shop/emp/empList.jsp"style="color:gray">사원관리</a> |
	
	
<a href="/shop/emp/categoryList.jsp"style="color:gray">카테고리관리</a>|
	
	
	<a href="/shop/emp/goodsList.jsp"style="color:gray">상품관리</a>|
	
	<a href="./addgoodsForm.jsp"style="color:gray">상품등록</a>|
	
	<a href="./orderList.jsp"style="color:gray">전체주문내역확인</a>
	
</div>	
	<br>  
	<span>
	<!-- 개인정보수정 -->
		<a href="/shop/emp/empOne.jsp?empid=<%=(String)(loginMember.get("empid"))%>" style="color:black">
		★<%=(String)(loginMember.get("emp_name"))%>★님
		</a> 반갑습니다
	</span>


