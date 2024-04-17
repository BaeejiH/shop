package shop.DAO;

import java.sql.Connection;

import java.sql.*;
import java.util.*;


public class GoodsDAO {
	public static ArrayList<HashMap<String,Object>> selectGoodsList (int startRow , int rowPerpage)
				throws Exception{
		ArrayList<HashMap<String,Object>> list =
				new ArrayList<HashMap<String,Object>> ();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select *"
				+"from goods"
				+"order by create_date desc"
				+"limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,startRow);
		stmt.setInt(2,rowPerpage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("goodsNo", rs.getString("goodsNo"));
			m.put("category", rs.getString("category"));
			
			
			list.add(m);
		}
		
		
		conn.close();
		
		return list;
	}
	
	// 상품 주문or취소시 수정할 수량
		// /customer/addOrdersAction.jsp or dropOrdersAction.jsp......
		// param : int(상품번호), int(변경할 수량 + or - )
		public static int updateGoodsAmount(int goodsNo, int amount) 
											throws Exception {
			int row = 0;
			
			String sql = "update goods"
					+ " set goods_amount = ?, update_date = sysdate"
					+ " where goods_no = ?";
			
			return row;
			
		}
		
		// 상품 상세보기
		// /customer/goodsOne.jsp
		// param : int(goods_no)
		// return : Goods -> HashMap
		public static HashMap<String, Object> selectGoodsOne(int goodsNo)
													throws Exception {
			HashMap<String, Object> map = null;
			
			String sql = "select *"
					+ " from goods"
					+ " where gooods_no = ?";
			
			return map;
		}
		
		
		// 고객 로그인 후 상품목록 페이지
		// /customer/goodsList.jsp
		// param : void
		// return : Goods(일부 속성)의 배열 -> ArrayList<HashMap<String, Object>>
		public static ArrayList<HashMap<String, Object>> selectGoodsList(
				String category, int startRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			
			// Connection
			Connection conn = DBHelper.getConnection();
			String sql = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			if(category != null || category.equals("")) {
				sql = "select"
						+ " goods_no goodsNo,"
						+ " category,"
						+ " goods_title goodsTitle"
						+ " goods_price goodsPrice"
						+ " from goods"
						+ " where category = ?"
						+ " order by goods_no desc"
						+ " offset ? rows fetch next ? rows only";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, category);
				stmt.setInt(2, startRow);
				stmt.setInt(3, rowPerPage);
			} else {
				sql = "select"
						+ " goods_no goodsNo,"
						+ " category,"
						+ " goods_title goodsTitle"
						+ " goods_price goodsPrice"
						+ " from goods"
						+ " order by goods_no desc"
						+ " offset ? rows fetch next ? rows only";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, startRow);
				stmt.setInt(2, rowPerPage);
			}
			rs = stmt.executeQuery();
			
			// 자원반납
			return list;
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
