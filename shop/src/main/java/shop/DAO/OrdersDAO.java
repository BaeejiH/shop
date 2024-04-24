package shop.DAO;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class OrdersDAO {
	//addorderAction.jsp
	//상품 주문하기 기능
	//param: mail, goodsNo,totalAmount,totalPrice, address
	//orders_no를 안넣는 이유는 기본값을 auto로 해서 자동적으로 생성시키기 위해.
	public static int insertorders(String mail, int goodsNo, int totalAmount, int totalPrice, String address) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver"); 
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		String sql= "INSERT INTO orders (mail, goods_no, total_amount, total_price, address, state) VALUES (?, ?, ?, ?, ?, ?)";
		stmt1 = conn.prepareStatement(sql);
        stmt1.setString(1, mail);
        stmt1.setInt(2, goodsNo);
        stmt1.setInt(3, totalAmount);
        stmt1.setInt(4, totalPrice);
        stmt1.setString(5, address);
        stmt1.setString(6, "결제완료"); 
		
        row = stmt1.executeUpdate();
		
		
		return row;
	}
	
	
	
	
	
	// 고객의 자신의 주문을 확인(페이징)
		public static ArrayList<HashMap<String, Object>> selectOrdersListByCustomer(
				String mail, int startRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list 
					= new ArrayList<HashMap<String, Object>>();
			
			String sql = "select o.orders_no ordersNo,"
					+ "			 o.goods_no goodsNo, g.goods_title goodsTitle"
					+ " from orders o inner join goods g"
					+ " on o.goods_no = g.goods_no"
					+ " where o.mail = ?"
					+ " order by o.orders_no desc"
					+ " offset ? rows fetch next ? rows only";
			
			return list;
		}
		
		// 관리자 전체주문을 확인(페이징)
		public static ArrayList<HashMap<String, Object>> selectOrdersListAll(
				int startRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list 
					= new ArrayList<HashMap<String, Object>>();
			String sql = "select o.orders_no ordersNo,"
					+ "			 o.goods_no goodsNo, g.goods_title goodsTitle"
					+ " from orders o inner join goods g"
					+ " on o.goods_no = g.goods_no"
					+ " order by o.orders_no desc"
					+ " offset ? rows fetch next ? rows only";
			
			return list;
		}
	}
	

