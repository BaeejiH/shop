package shop.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class OrdersDAO {
	
	// updatestate.jsp
	// 타입: int
	// param: ordersNo
	// 주문상태를 변경(결제완료 --> 배송완료)
	public static int updatestate(int ordersNo) throws Exception {
		 	int row = 0;
			Connection conn = null;
	        PreparedStatement stmt1 = null;
	       
	        
	        conn = DBHelper.getConnection();
	                       
	        String sql = "UPDATE orders SET state = '배송완료' WHERE orders_no = ?";
	        
	        stmt1 = conn.prepareStatement(sql);
	        stmt1.setInt(1,ordersNo);
	        
	        row = stmt1.executeUpdate();
	        
	        conn.close();
			return row;           
	}
	
	
	
	
	
	// 고객의 자신의 주문을 확인(페이징)
	// WHERE o.mail = ? , 이메일에 세션에 저장된 이메일로 고객 이메일 불러오기
	// 타입 : ArrayList
	// param : customerId, startRow, rowPerPage
	 public static ArrayList<HashMap<String, Object>> selectOrdersByCustomerID(String customerID, int startRow, int rowPerPage) throws Exception {
	        ArrayList<HashMap<String, Object>> ordersList = new ArrayList<>();
	        Connection conn = null;
	        PreparedStatement stmt1 = null;
	        ResultSet rs = null;

	        conn = DBHelper.getConnection();
	        String sql = "SELECT o.orders_no AS ordersNo, o.goods_no AS goodsNo, g.goods_title AS goodsTitle, " +
	                "o.create_date, o.state " +
	                "FROM orders o " +
	                "INNER JOIN goods g ON o.goods_no = g.goods_no " +
	                "WHERE o.mail = ? " +
	                "ORDER BY o.orders_no DESC " +
	                "LIMIT ?, ?";
	        System.out.println("SQL: " + sql);
	        stmt1 = conn.prepareStatement(sql);
	        stmt1.setString(1, customerID);
	        stmt1.setInt(2, startRow);    
	        stmt1.setInt(3, rowPerPage);
	        
	        System.out.println("param: customerID = " + customerID+ ", startRow = " + startRow+",rowPerPage = " + rowPerPage);
	        rs = stmt1.executeQuery();

	        while (rs.next()) {
	            HashMap<String, Object> order = new HashMap<>();
	            order.put("orders_no", rs.getInt("ordersNo")); // 'ordersNo'로 변경
	            order.put("goods_no", rs.getInt("goodsNo"));   // 'goodsNo'로 변경
	            order.put("goods_title", rs.getString("goodsTitle")); // 'goodsTitle'로 변경
	            order.put("create_date", rs.getTimestamp("create_date"));
	            order.put("state", rs.getString("state"));
	            ordersList.add(order);
	        }
	        
	        conn.close();

	        return ordersList;
	    }

	// 주문번호 가져오기
	// 타입 : ArrayList
	// param : oredersNo
	 
	public static ArrayList<HashMap<String, Object>> selectorders(int ordersNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver"); 
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt1 = null;
	
		String sql="select orders_no ordersNo, mail, goods_no goodsNo, total_amount totalAmount, "
				+ "total_price totalPrice, address, state, update_date updateDate, create_date createDate "
				+ "from orders "
				+ "where orders_no = ?";;
		
		stmt1 = conn.prepareStatement(sql);
		stmt1.setInt(1,ordersNo);
			
		ResultSet rs = stmt1.executeQuery();
		
		ArrayList<HashMap<String, Object>> orderslist = new ArrayList<HashMap<String, Object>>();
		while(rs.next()) {
			HashMap<String, Object> orderMap = new HashMap<>();
            orderMap.put("orders_no", rs.getInt("orders_no"));
            orderMap.put("mail", rs.getString("mail"));
            orderMap.put("goods_no", rs.getInt("goods_no"));
            orderMap.put("total_amount", rs.getInt("total_amount"));
            orderMap.put("total_price", rs.getInt("total_price"));
            orderMap.put("address", rs.getString("address"));
            orderMap.put("state", rs.getString("state"));
            orderMap.put("update_date", rs.getTimestamp("update_date"));
            orderMap.put("create_date", rs.getTimestamp("create_date"));
            orderslist.add(orderMap);
		}
		
		conn.close();
		return orderslist;
	}
	
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
	
	// 관리자 전체주문을 확인(페이징)
	// 타입 : ArrayList
	// param : startRow, rowPerPage
	//
	 public static ArrayList<HashMap<String, Object>> selectOrdersListAll(int startRow, int rowPerPage) throws Exception {
	        ArrayList<HashMap<String, Object>> ordersList = new ArrayList<>();
	        Connection conn = null;
	        PreparedStatement stmt1 = null;
	        ResultSet rs = null;

	        conn = DBHelper.getConnection();
	        //orders테이블과 goods테이블을 조인하여 주문번호, 상품번호, 상품 제목 선택.
	        String sql = "SELECT o.orders_no AS ordersNo, o.goods_no AS goodsNo, g.goods_title AS goodsTitle, o.state " +
	                     "FROM orders o " +
	                     "INNER JOIN goods g ON o.goods_no = g.goods_no " +
	                     "ORDER BY o.orders_no DESC " +
	                     "LIMIT ?, ?";
	        System.out.println("SQL: " + sql);
	        
	        stmt1 = conn.prepareStatement(sql);
	        stmt1.setInt(1, startRow);
	        stmt1.setInt(2, rowPerPage);
	        
	        System.out.println("param: startRow = " + startRow + ", rowPerPage = " + rowPerPage); 
	        rs = stmt1.executeQuery();

	        while (rs.next()) {
	        	//ResultSet에서 각행의 주문번호, 상품 번호, 상품 제목을 가져와 HashMap에 저장하고  orderList로 추가함.
	            HashMap<String, Object> order = new HashMap<>();
	            order.put("ordersNo", rs.getInt("ordersNo"));
	            order.put("goodsNo", rs.getInt("goodsNo"));
	            order.put("goodsTitle", rs.getString("goodsTitle"));
	            order.put("state", rs.getString("state"));
	            ordersList.add(order);
	        }
	        
	        conn.close();

	        return ordersList;
	    }
	}
	
	

