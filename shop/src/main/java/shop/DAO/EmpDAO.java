package shop.DAO;


import java.util.HashMap;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.*;

public class EmpDAO {
	
	//empist
	//타입 : ArrayLsit
	//param :
	public static ArrayList<HashMap<String, Object>> empList(int startRow,int rowPerPage) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
		Connection conn = DBHelper.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery(); 
		// JDBC API 종속된 자료구조 모델 ResultSet  -> 기본 API 자료구조(ArrayList)로 변경
		
		ArrayList<HashMap<String, Object>> list
			= new ArrayList<HashMap<String, Object>>();	
		
		// ResultSet -> ArrayList<HashMap<String, Object>>
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("empId", rs.getString("empId"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("active", rs.getString("active"));
			list.add(m);	}
		// JDBC API 사용이 끝났다면 DB자원들을 반납
		
		return list;
	}
	
	
	
	
	
	//empOne.jsp
	//param : empId, empName, empJob,hiredate,active
	// goodList에서 이름을 눌렀을때 정보 상세보기
	public static HashMap<String, Object> empOnelist(String empID) throws Exception{
		HashMap<String, Object>Empdetalis = new HashMap<>();
			
		String sql1 = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active "
				+ "from emp "
				+ "where emp_id = ?";
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1,empID);
				
		ResultSet rs1 = stmt1.executeQuery(); 
		
		//출력 페이지의 while문 대체 
		if (rs1.next()) {
			Empdetalis.put("empId", rs1.getString("empId"));
			Empdetalis.put("empName", rs1.getString("empName"));
			Empdetalis.put("empJob", rs1.getString("empJob"));
			Empdetalis.put("hireDate", rs1.getDate("hireDate"));
			Empdetalis.put("active", rs1.getString("active"));
        }
        
		return Empdetalis;
		
	}
	
	
	

	
	//checkidempAction.jsp
	//회원가입시 id 중복확인 기능
	//param: checkid, IDcheck,emp_id
	
	public static String checkID(String empid) 
				throws Exception{
		Class.forName("org.mariadb.jdbc.Driver"); 
        Connection conn = DBHelper.getConnection();
        String IDcheck = ""; //아이디가 사용가능한지 여부를 보여주는 변수 설정.
        
        String sql1 = "select emp_id,emp_name,hire_date,active from emp where emp_id = ?"; 
        PreparedStatement stmt1 = null;		
    	stmt1 = conn.prepareStatement(sql1);
    	stmt1.setString(1, empid);
    	
    	ResultSet rs1 = stmt1.executeQuery();	
    	
    	
    	//emp_id가 데이터베이스에 있을 대 이메일이 중복되는지 판단하기 위한 분기문
    	 if (rs1.next()) { //중복된 이메일이 있음을 나타냄.
 	        IDcheck ="d";
 	    } else {//아니라면 사용 가능한 이메일이 있음을 나타냄.
 	    	IDcheck ="a";
 	    }    
    	
    	 
    	// IDcheck을 반환하는 이유는 값이 있는 emp_id가  db에 존재하는 여부를 나타내기 때문에.
    	return IDcheck;
	}
	
		
	//modifyemp 
	// empList의 ON/OFF 값 변경 
	// param :empID, active
		
	public static int updateEMP(String empId,String active) 
		throws Exception{
		 int row = 0;

	        Class.forName("org.mariadb.jdbc.Driver"); 
	        Connection conn = DBHelper.getConnection();
	        
	       
	        // active의 상태 설정하기
	        String nactive = active.equals("ON") ? "OFF" : "ON";
	        
	        // active 값을 변경하는 쿼리
	        String sql = "UPDATE emp SET active = ? WHERE emp_id = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, nactive);
	        stmt.setString(2, empId);
	        
	        // 업데이트 실행
	        row = stmt.executeUpdate();
	        
	        // 자원 해제
	        stmt.close();
	        conn.close();
	        
	        return row;
	                    
	        }
	
	public static int insertEmp(String empID,String empPW,String empName,String empJob,String hireDate, String active)
		throws Exception{
		int row =0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		
		
		//회원가입
		String sql1 ="INSERT into emp (emp_id, emp_name,emp_job, hire_date,active) VALUES (?,?,?,?,?)";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1,empID);
		stmt1.setString(2,empName);
		stmt1.setString(3,empJob);
		stmt1.setString(4,hireDate);
		stmt1.setString(5,active);
		
		System.out.println(stmt1+"<------stmt");
		
		 // pwhistory에 비밀번호 기록 삽입
		//반정규화로 인해 emp테이블에 pw가 없기 때문에  따로 insert 해줘야함.
	    String Sql2 = "INSERT INTO pwhistory (emp_id, emp_pw, create_date) VALUES (?, ?, NOW())";
	    PreparedStatement stmt2 = conn.prepareStatement(Sql2);
	    stmt2.setString(1, empID);
	    stmt2.setString(2, empPW);
	    
	    System.out.println(stmt2+"<------stmt2");

	    row = stmt1.executeUpdate(); // emp 테이블에 삽입
	    row = stmt2.executeUpdate(); // pwhistory 테이블에 삽입

	    conn.close(); // 연결 닫기
	    
	    return row;
	}
	
	
	//emploginAction.jsp
	//비빌번호 변경시 가장 최근에 변경된 비밀번호만 로그인 가능.
	//반정규화를 통해서 중복속성 걸러내기	
	// 타입: HashMap
	// param : empID, empPW
	public static HashMap<String, Object>empLogin(String empID,String empPW)
						throws Exception{
		HashMap<String, Object>resultMap = null;

		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "SELECT t.emp_id AS empid, t.emp_name AS empName, t.grade AS grade, t.emp_pw AS pw\r\n"
				+ "FROM (\r\n"
				+ "    SELECT e.emp_id, e.emp_name, e.grade, ph.emp_pw, ph.create_date\r\n"
				+ "    FROM emp e\r\n"
				+ "    INNER JOIN pwhistory ph ON e.emp_id = ph.emp_id\r\n"
				+ "    WHERE e.emp_id = ?\r\n"
				+ "    ORDER BY ph.create_date DESC\r\n"
				+ "    LIMIT 1\r\n"
				+ ") AS t\r\n"
				+ "WHERE t.emp_pw = ?";
		System.out.println("SQL: " + sql1);
				
		
		
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, empID);
		stmt1.setString(2, empPW);
		
		
		
		rs1 = stmt1.executeQuery();
		
		
		if(rs1.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empid", rs1.getString("empid"));
			resultMap.put("emp_name", rs1.getString("empName"));	
			resultMap.put("grade", rs1.getInt("grade"));	
		}
		
			
		conn.close();
		return resultMap;
	}
		
}




	
	





