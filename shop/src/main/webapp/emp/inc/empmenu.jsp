<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>




<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));	
%>





<br>


<div>
	<a href="/shop/emp/empList.jsp"style="color:gray">사원관리</a> |
	
	
<a href="/shop/emp/categoryList.jsp"style="color:gray">카테고리관리</a>|
	
	
	<a href="/shop/emp/goodsList.jsp"style="color:gray">상품관리</a>|
	
	<a href="./addgoodsForm.jsp"style="color:gray">상품등록</a>
	
</div>	
	<br>  
	<span>
	<!-- 개인정보수정 -->
		<a href="/shop/emp/empOne.jsp?empId=<%=(String)(loginMember.get("empId"))%>" style="color:black">
		★<%=(String)(loginMember.get("empName"))%>★님
		</a> 반갑습니다
	</span>


