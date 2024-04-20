package shop.DAO;

import java.sql.Connection;

import java.sql.*;
import java.util.*;

public class GoodsDAO {

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
	public static HashMap<String, Object> selectGoodsOne(int goodsNo) throws Exception {
		HashMap<String, Object> map = null;

		String sql = "select *" + " from goods" + " where gooods_no = ?";

		return map;
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
