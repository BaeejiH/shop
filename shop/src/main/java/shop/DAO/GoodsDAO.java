package shop.DAO;

import java.sql.Connection;


import java.util.HashMap;

import java.sql.*;
import java.util.*;




public class GoodsDAO {
	//goodsList 페이징
	 public static ArrayList<HashMap<String, Object>> ppgoodsList(String category, int startRow, int rowPerPage) throws Exception {
		
		 Class.forName("org.mariadb.jdbc.Driver");
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		Connection conn = DBHelper.getConnection();
		
        String sql = "";
        if (category == null || "null".equals(category)) {
            sql = "select goods_no no, category, goods_title title, filename, left(goods_content,500) content, goods_price price, goods_amount amount FROM goods ORDER BY goods_no DESC limit ?,?;";
        } else {
            sql = "select goods_no no, category, goods_title title, filename, left(goods_content,500) content, goods_price price, goods_amount amount FROM goods WHERE category = ? ORDER BY goods_no DESC limit ?,?;";
        }

        stmt1 = conn.prepareStatement(sql);

        int iParam = 1;
        if (!(category == null || "null".equals(category))) {
            stmt1.setString(iParam++, category);
        }

        stmt1.setInt(iParam++, startRow);
        stmt1.setInt(iParam++, rowPerPage);

        rs1 = stmt1.executeQuery();

        ArrayList<HashMap<String, Object>> goodsList = new ArrayList<>();
        
        while (rs1.next()) {
            HashMap<String, Object> m = new HashMap<>();
            String imagePath = rs1.getString("filename");
            m.put("no", rs1.getInt("no"));
            m.put("category", rs1.getString("category"));
            m.put("title", rs1.getString("title"));
            m.put("content", rs1.getString("content"));
            m.put("price", rs1.getInt("price"));
            m.put("amount", rs1.getInt("amount"));
            m.put("imagePath", imagePath);
            goodsList.add(m);
        }
	        	        
	       return goodsList; 
	 }

	
	
	//카테코리 그룹별 출력
	public static ArrayList<HashMap<String, Object>> getcategoryList()
				throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "select category,count(*) cnt from goods group by category order by category asc";
		stmt1 = conn.prepareStatement(sql1);
		rs1 = stmt1. executeQuery();
		
		ArrayList<HashMap<String, Object>> grouplist = new ArrayList<HashMap<String, Object>>();

		while(rs1.next()){
			HashMap<String, Object> m0 = new HashMap<String, Object>();
			m0.put("category", rs1.getString("category"));
			m0.put("cnt", rs1.getInt("cnt"));
			grouplist.add(m0);
			
	}
		return grouplist;
		
	}
		
	// 메소드 첫줄 구성 :  반환타입(ArrayList) + 메소드(getGoodsList) +param(category,currentpage,rowPerpage)
	//반환을 하지 않으려면 static 말고 void를 쓰면됨.
	//public은 누구 접근가능하다는 것.	
	 public GoodsDAO() throws Exception {
	        Connection conn = DBHelper.getConnection();
	    }

	    public ArrayList<HashMap<String, Object>> getGoodsList(String category, int startRow, int rowPerPage) throws Exception {
	        ArrayList<HashMap<String, Object>> categoryList = new ArrayList<>();
	        String sql = (category == null || "null".equals(category)) ?
	                "select goods_no no, category, goods_title title, filename, left(goods_content,500) content, goods_price price, goods_amount amount FROM goods ORDER BY goods_no DESC limit ?,?" :
	                "select goods_no no, category, goods_title title, filename, left(goods_content,500) content, goods_price price, goods_amount amount FROM goods WHERE category = ? ORDER BY goods_no DESC limit ?,?";
	        Connection conn = DBHelper.getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        if (category != null && !"null".equals(category)) {
	            stmt.setString(1, category);
	            stmt.setInt(2, startRow);
	            stmt.setInt(3, rowPerPage);
	        } else {
	            stmt.setInt(1, startRow);
	            stmt.setInt(2, rowPerPage);
	        }
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            HashMap<String, Object> map = new HashMap<>();
	            map.put("no", rs.getInt("no"));
	            map.put("category", rs.getString("category"));
	            map.put("title", rs.getString("title"));
	            map.put("content", rs.getString("content"));
	            map.put("price", rs.getInt("price"));
	            map.put("amount", rs.getInt("amount"));
	            map.put("imagePath", rs.getString("filename"));
	            categoryList.add(map);
	        
	   
	    }
			return categoryList;
}

	    public int getGoodsCount(String category) throws Exception {
	        int count = 0;
	        String sql = "select count(*) cnt From goods" + (category != null && !"null".equals(category) ? " WHERE category = ?" : "");
	        Connection conn = DBHelper.getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        if (category != null && !"null".equals(category)) {
	            stmt.setString(1, category);
	        }
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt("cnt");
	        }
	        return count;
	    }

	    public ArrayList<HashMap<String, Object>> getAllCategories() throws Exception {
	        ArrayList<HashMap<String, Object>> categoryList = new ArrayList<>();
	        String sql = "select category, count(*) cnt from goods group by category order by category asc";
	        Connection conn = DBHelper.getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            HashMap<String, Object> map = new HashMap<>();
	            map.put("category", rs.getString("category"));
	            map.put("cnt", rs.getInt("cnt"));
	            categoryList.add(map);
	        }
	        return categoryList;
	    }

	// deletegoodsACtion
	// 관리자가 상품을 삭제시키능 기능
	// param : goods_No
	// goods의 테이블행을 삭제하고 삭제된 행의 수를 반환
	// 반환 값은 delete문의 실행결과에 해당되는 삭제된 행의 수
	public static int deleteGoods(int goodsNo) throws Exception {

		int row = 0;
		String sql1 = "DELETE FROM goods WHERE goods_no=?";
		PreparedStatement stmt1 = null;
		Connection con = null;
		con = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		stmt1 = con.prepareStatement(sql1);
		stmt1.setInt(1, goodsNo);

		row = stmt1.executeUpdate();

		return row;
	}

	// addgoodsAction
	// 상품 추가 페이지
	// param : filename, category, empId, goodsTitle,
	// goodsContent,goodsPrice,goodsAmount
	// filename이 null일때 나머지 정보들 추가 null이 아니면 전체 추가
	public static int insertGoods(String filename, String category, String empId, String goodsTitle,
			String goodsContent, int goodsPrice, int goodsAmount) throws Exception {

		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt1 = null;
		if (filename == null) {
			String sql1 = "insert into goods (category, emp_id, goods_title, goods_content, goods_price, goods_amount) values (?, ?, ?, ?, ?, ?)";
			stmt1 = conn.prepareStatement(sql1);
			stmt1.setString(1, category);
			stmt1.setString(2, empId);
			stmt1.setString(3, goodsTitle);
			stmt1.setString(4, goodsContent);
			stmt1.setInt(5, goodsPrice);
			stmt1.setInt(6, goodsAmount);
			System.out.println(stmt1);
		} else {
			String sql1 = "insert into goods (category, emp_id, goods_title, goods_content, goods_price, goods_amount, file_name) values (?, ?, ?, ?, ?, ?, ?)";
			stmt1 = conn.prepareStatement(sql1);
			stmt1.setString(1, category);
			stmt1.setString(2, empId);
			stmt1.setString(3, goodsTitle);
			stmt1.setString(4, goodsContent);
			stmt1.setInt(5, goodsPrice);
			stmt1.setInt(6, goodsAmount);
			stmt1.setString(7, filename);
			System.out.println(stmt1);
		}

		int row = 0;
		row = stmt1.executeUpdate();

		return row;

	}

	public static ArrayList<HashMap<String, Object>> selectGoodsList(int startRow, int rowPerpage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		String sql = "select *" + "from goods" + "order by create_date desc" + "limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerpage);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
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
	public static int updateGoodsAmount(int goodsNo, int amount) throws Exception {
		int row = 0;

		String sql = "update goods" + " set goods_amount = ?, update_date = sysdate" + " where goods_no = ?";

		return row;

	}

	// 상품 상세보기
		// /customer/goodsOne.jsp
		// param : int(goods_no)
		// return : Goods -> HashMap
		public static HashMap<String, Object> selectGoodsOne(int goods_no) throws Exception {
			
			
			Connection conn = DBHelper.getConnection();
			String sql = "select *" + " from goods" + " where goods_no = ?";
			PreparedStatement stmt1 = conn.prepareStatement(sql);
			stmt1.setInt(1,goods_no);
			ResultSet rs1 = stmt1.executeQuery();
			
			HashMap<String, Object> m = new HashMap<String, Object>();
			if(rs1.next()) {
				
				m.put("goodsNo", rs1.getString("goods_no"));
				m.put("category", rs1.getString("category"));
				m.put("title", rs1.getString("goods_title"));
				m.put("content", rs1.getString("goods_content"));
				m.put("price", rs1.getInt("goods_price"));
				m.put("amount", rs1.getInt("goods_amount"));
				m.put("imagePath", rs1.getString("filename"));
				
				
			}
			
			return m;
		}


	// 고객 로그인 후 상품목록 페이지
	// /customer/goodsList.jsp
	// param : void
	// return : Goods(일부 속성)의 배열 -> ArrayList<HashMap<String, Object>>
	public static 
	    ArrayList<HashMap<String, Object>> // 리넡 타입 
	    selectGoodsList(String category, int startRow, int rowPerPage) // 메소드 명과 파라메타
			throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		// Connection
		Connection conn = DBHelper.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		if (category != null || category.equals("")) {
			sql = "select" + " goods_no goodsNo," + " category," + " goods_title goodsTitle," + " goods_price goodsPrice"
					+ " from goods" + " where category = ?" + " order by goods_no desc"
					+ " offset ? rows fetch next ? rows only";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
		} else {
			sql = "select" + " goods_no goodsNo," + " category," + " goods_title goodsTitle," + " goods_price goodsPrice"
					+ " from goods" + " order by goods_no desc" + " offset ? rows fetch next ? rows only";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}
		rs = stmt.executeQuery();

		// 자원반납
		return list;

	}

}
