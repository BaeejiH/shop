package shop.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.*;

public class ReviewDAO {
	//해당 상품에 대한 후기를 조회
	//타입 : ArrayList
	//param:goodsNo
	 public static ArrayList<HashMap<String, Object>> getReviewgoods(int goodsNo) throws Exception {
	        ArrayList<HashMap<String, Object>> reviewList = new ArrayList<>();
	        
	        Connection conn = null;
	        PreparedStatement stmt1 = null;
	        ResultSet rs = null;
	        
	        conn = DBHelper.getConnection();
	        //서브 쿼리를 사용한 SQL문
	        //-> 주로 where절/from절/Having절에서 사용.
	        //orders_no 테이블에서 goods_no가 특정번호와 일치하는 주문번호를 선택한다.	
	        // 주문번호를 사용하여 comment에서 주문번호와 일치하는 리뷰 선택.
	        String sql = "SELECT * FROM comment WHERE orders_no IN (SELECT orders_no FROM orders WHERE goods_no = ?)";
	        System.out.println(sql+"<-----sql");
	        stmt1 = conn.prepareStatement(sql);
	        stmt1.setInt(1, goodsNo);
	        System.out.println("param: goodsNo"+goodsNo);
	        rs = stmt1.executeQuery();
	        
	       
	        
	        while (rs.next()) {
	            HashMap<String, Object> review = new HashMap<>();
	            review.put("score", rs.getInt("score"));
	            review.put("content", rs.getString("content"));
	         
	            
	            reviewList.add(review);
	        }
	        
	        conn.close();
	        
	        return reviewList;
	    }
		
	
	
	
	
	
	
	
	
	
		//리뷰 추가
		//타입 : void
		//param : orderNo, score,content	
		 public static void addReview(int ordersNo, int score, String content) throws Exception {
		        Connection conn = null;
		        PreparedStatement stmt1 = null;
		        
		        conn = DBHelper.getConnection();
		        String sql = "INSERT INTO `comment` (orders_no, score, content) VALUES (?, ?, ?)";
		        stmt1 = conn.prepareStatement(sql);
		        stmt1.setInt(1, ordersNo);
		        stmt1.setInt(2, score);
		        stmt1.setString(3, content);
		        
		        stmt1.executeUpdate();
		        
		        
		        
		        conn.close();
		    }
}
