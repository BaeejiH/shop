<%@page import="javax.lang.model.util.Elements.Origin"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%@page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "shop.DAO.*"%>   
    
    
    
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
		return;
	}
	request.getParameter("UTF-8");	

	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));

	String category = request.getParameter("category");
	String empId = (String)(loginEmp.get("empId"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	int	goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	
	Part part = request.getPart("goodsImg");
    String originalName = part.getSubmittedFileName();
    // 원본이름에서 확장자만 분리
    int dotIdx = originalName.lastIndexOf(".");
    String ext = originalName.substring(dotIdx); // .png
    
    UUID uuid = UUID.randomUUID();
    String filename = uuid.toString().replace("-", "");
    filename = filename + ext;
%>

<!-- 
	//DAO로 바꾸면서 없어지는 페이지에서 사라지는 쿼리
	//db연결 , 쿼리문 , 매개변수 변환 , 파일 업로드 분기문 모두 DAO로 이동
	//DAO에서 filename이 null인지에 따라 분기문으로 다시 작성

	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	
	String sql = "insert into goods (category, emp_id, goods_title,filename, goods_content, goods_price, goods_amount) values (?, ?, ?, ?, ?, ?, ?)";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	stmt.setString(2, empId);
	stmt.setString(3, goodsTitle);
	stmt.setString(4, filename);
	stmt.setString(5, goodsContent);
	stmt.setInt(6, goodsPrice);
	stmt.setInt(7, goodsAmount);
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();	
	
	if(row == 1) { // insert 성공하면 파일업로드
    	// part -> 1)is -> 2)os -> 3)빈파일
		// 1)
    	InputStream is = part.getInputStream();
    	// 3)+ 2)
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); // 빈파일
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file
		is.transferTo(os);
		
		os.close();
		is.close();
    }
    
    파일 삭제 API
    File df = new File(filePath, rs.getString("filename"));
    df.delete()
    
   
 -->
	

<!-- Controller Layer -->
	

<%
	int row = 0;
	row = GoodsDAO.insertGoods(filename,category,empId,goodsTitle,goodsContent,goodsPrice,goodsAmount);
	



    if(row == 1){
        response.sendRedirect("/shop/emp/goodsList.jsp");
    } else {
    	String errMsg = URLEncoder.encode("작성에 실패했습니다. 확인 후 다시 입력하세요.", "utf-8");
    	response.sendRedirect("/shop/emp/addGoodsForm.jsp?errMsg=" + errMsg);
        return;
    }
%>





