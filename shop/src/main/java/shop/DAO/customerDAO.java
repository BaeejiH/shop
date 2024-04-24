package shop.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;



public class customerDAO {
	//goodsList 페이징
		 public static ArrayList<HashMap<String, Object>> ppcustomerList(String category, int startRow, int rowPerPage) throws Exception {
			
			 Class.forName("org.mariadb.jdbc.Driver");
			PreparedStatement stmt1 = null;
			ResultSet rs1 = null;
			Connection conn = DBHelper.getConnection();
			
	        String sql = "";
	        if (category == null || "null".equals(category)) {
	            sql = "select goods_no goodsNo, category, goods_title title, filename,left(goods_content,500)content, goods_price price, goods_amount amount FROM goods ORDER BY goods_no DESC limit ?,?;";
	        } else {
	            sql = "select goods_no goodsNo, category, goods_title title, filename,left(goods_content,500)content, goods_price price, goods_amount amount FROM goods WHERE category = ? ORDER BY goods_no DESC limit ?,?;"; 
	        }

	        stmt1 = conn.prepareStatement(sql);

	        int iParam = 1;
	        if (!(category == null || "null".equals(category))) {
	            stmt1.setString(iParam++, category);
	        }

	        stmt1.setInt(iParam++, startRow);
	        stmt1.setInt(iParam++, rowPerPage);

	        rs1 = stmt1.executeQuery();

	        ArrayList<HashMap<String, Object>> customerList = new ArrayList<>();
	        
	        while (rs1.next()) {
	            HashMap<String, Object> m = new HashMap<>();
	            String imagePath = rs1.getString("filename");
	            m.put("goodsNo", rs1.getInt("goodsNo"));
	            m.put("category", rs1.getString("category"));
	            m.put("title", rs1.getString("title"));
	            m.put("content", rs1.getString("content"));
	            m.put("price", rs1.getInt("price"));
	            m.put("amount", rs1.getInt("amount"));
	            m.put("imagePath", imagePath);
	            customerList.add(m);
	        }
		        	        
		       return customerList; 
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public static String checkIDcustomer(String mail) 
			throws Exception{
	Class.forName("org.mariadb.jdbc.Driver"); 
    Connection conn = DBHelper.getConnection();
    String IDcheck = ""; //아이디가 사용가능한지 여부를 보여주는 변수 설정.
    
    String sql1 = "select mail customerID,pw customerPW,name,birth,gender from customer where mail = ?"; 
    PreparedStatement stmt1 = null;		
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, mail);
	
	ResultSet rs1 = stmt1.executeQuery();	
	
	
	//customer_id가 데이터베이스에 있을 대 이메일이 중복되는지 판단하기 위한 분기문
	 if (rs1.next()) { //중복된 이메일이 있음을 나타냄.
	        IDcheck ="d";
	    } else {//아니라면 사용 가능한 이메일이 있음을 나타냄.
	    	IDcheck ="a";
	    }    
	
	 
	// IDcheck을 반환하는 이유는 값이 있는 emp_id가  db에 존재하는 여부를 나타내기 때문에.
	return IDcheck;
}

	
	
	

	
	//customerloginAction
	//타입 : HashMap
	//param : logincustomer
	
	public static HashMap<String, Object>customerLogin(String customerID,String customerPW)
				throws Exception{
		HashMap<String, Object>resultMap = null;

		String sql1 = "select mail customerID,pw customerPW,name,birth,gender from customer where mail = ? and pw = password(?) "; 
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt1 = null;		
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, customerID);
		stmt1.setString(2, customerPW);
		ResultSet rs1 = null;
		rs1 = stmt1.executeQuery();
		
		if(rs1.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("customerID", rs1.getString("customerID"));
			resultMap.put("name", rs1.getString("name"));
			resultMap.put("birth", rs1.getString("birth"));
			resultMap.put("gender", rs1.getString("gender"));
		
		}
		
		return resultMap;
		
	}
	
	
	
	
	//회원가입 
	//타입 : int
	//param: customerID,  customerPW, name,  birth, gender)
	public static int insertcustomer(String customerID, String customerPW, String name, String birth, String gender) 
					throws Exception{
		
		Connection conn = DBHelper.getConnection();
        PreparedStatement stmt = conn.prepareStatement("INSERT INTO customer (mail, pw, name, birth, gender) VALUES (?, PASSWORD(?), ?, ?, ?)");
        stmt.setString(1, customerID);
        stmt.setString(2, customerPW);
        stmt.setString(3, name);
        stmt.setString(4, birth);
        stmt.setString(5, gender);
        
        int row = stmt.executeUpdate();
        
        stmt.close();
        conn.close();
        
        return row;
    }
		
	
	// 디버깅용 메인 메서드
	public static void main(String[] args) throws Exception {
		// 메일 체크 메서드 디버깅
		//System.out.println(CustomerDAO.checkMail("a@goodee.com")); // false
		 
		//System.out.println(CustomerDAO.insertCustomer(
		//		"z@goodee.com","1234","zzz","1999/09/09","여")); // 1
		
		// System.out.println(CustomerDAO.login("a@goodee.com", "1234")); // 성공...
		// System.out.println(CustomerDAO.deleteCustomer("a@goodee.com", "1234")); 
		
		 System.out.println(customerDAO.selectCustomerListByPage(10, 10));
	}
	
	// 관리자 페이지 전체 회원정보(pw제외)
	// 호출 : /admin/customerList.jsp
	// param : void
	// return : Customer배열(리스트) -> ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectCustomerListByPage(
			int startRow, int rowPerPage) throws Exception {
		// currentPage + rowPerPage -> startRow를 구하는 알고리즘 코드구현 액션에서...
		// startRow를 구하는 알고리즘 코드구현을 DAO에 하지 않도록...
		
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select "
				+ "mail,name,birth,gender,update_date updateDate,create_date createDate "
				+ " from customer"
				+ " order by mail"
				+ " offset ? rows fetch next ? rows only";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// JDBC Resulst(자바에서 일반적이지 않은 자료구조) 
		//  -> (자바에서 평이한 자료구조) Collections API 타입 -> List, Set, Map 
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("mail", rs.getString("mail"));
			m.put("name", rs.getString("name"));
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
}