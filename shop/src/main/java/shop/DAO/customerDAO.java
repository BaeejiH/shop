package shop.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;



public class customerDAO {
	//customergoodsList 페이징
	public static ArrayList<HashMap<String, Object>> ppcustomerList(String category, int startRow, int rowPerPage) throws Exception {
	    Class.forName("org.mariadb.jdbc.Driver");
	    PreparedStatement stmt1 = null;
	    ResultSet rs1 = null;
	    Connection conn = DBHelper.getConnection();

	    String sql = "";
	    if (category == null || "null".equals(category)) {
	        sql = "SELECT goods_no goodsNo, category, goods_title title, filename, LEFT(goods_content, 500) content, goods_price price, goods_amount amount FROM goods ORDER BY goods_no DESC LIMIT ?, ?";
	    } else {
	        sql = "SELECT goods_no goodsNo, category, goods_title title, filename, LEFT(goods_content, 500) content, goods_price price, goods_amount amount FROM goods WHERE category = ? ORDER BY goods_no DESC LIMIT ?, ?"; 
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public static String checkIDcustomer(String customerID) 
			throws Exception{
	Class.forName("org.mariadb.jdbc.Driver"); 
    Connection conn = DBHelper.getConnection();
    String IDcheck = ""; //아이디가 사용가능한지 여부를 보여주는 변수 설정.
    
    //customer에서 pw컬럼이 삭제되었기 때문에 쿼리에서 제외.
    String sql1 = "select mail customerID,name,birth,gender from customer where mail = ?"; 
    PreparedStatement stmt1 = null;		
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, customerID);
	
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
	//param : customerID,customerPW
	//customer 테이블과 cpwhistory 테이블과 조인쿼리
	//mail이 같은 값을 두 테이블에서 공통으로 가져온 후 were절과 order by로 정렬.
	//가장 최신으로 변경한 비밀번호 항목을 가져옴 --> createDate로 인해서.
	
	public static HashMap<String, Object>customerLogin(String customerID,String customerPW)
				throws Exception{
		HashMap<String, Object>resultMap = null;

		String sql1 = "SELECT b.customerID,b.name, b.birth,b.gender,b.customerPW\r\n"
				+ "FROM(\r\n"
				+ "	SELECT c.mail AS customerID,c.name,c.birth,c.gender,cph.pw customerPW,cph.create_date AS createDate\r\n"
				+ "	FROM customer c\r\n"
				+ "	INNER JOIN cpwhistory cph \r\n"
				+ "	ON c.mail = cph.mail\r\n"
				+ "	WHERE c.mail = ?\r\n"
				+ "	ORDER BY cph.create_date desc\r\n"
				+ "	LIMIT 1\r\n"
				+ ")AS b\r\n"
				+ "WHERE b.customerPW = ?";
		
		System.out.println(sql1+"SQL1");	
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt1 = null;		
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, customerID);
		stmt1.setString(2, customerPW);
		
		System.out.println(stmt1+"<--stmt1");
		
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
	//param: customerID,  customerPW, name,  birth, gender
	// 반정규화로 나누어진 테이블을 같이 insert 해준다.( customer + cpwhistory)
	public static int insertcustomer(String customerID, String customerPW, String name, String birth, String gender) 
					throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
       
        
		String sql1 = "INSERT INTO customer (mail, name, birth, gender) VALUES (?, ?, ?, ?)";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
        System.out.println(sql1+"<-----SQL1");
        
        stmt1.setString(1, customerID);
        stmt1.setString(2, name);
        stmt1.setString(3, birth);
        stmt1.setString(4, gender);
        System.out.println(stmt1+"<------stmt1");
        
        
        
        String sql2 = "INSERT INTO cpwhistory (mail, pw, create_date) VALUES (?, ?, NOW())";
	    PreparedStatement stmt2 = conn.prepareStatement(sql2);
	    System.out.println(sql2+"<------SQL2");
	    stmt2.setString(1, customerID);
	    stmt2.setString(2, customerPW);
	    System.out.println(stmt2+"<------stmt2");
        
         
        
        row = stmt1.executeUpdate();
        row = stmt2.executeUpdate();
            
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