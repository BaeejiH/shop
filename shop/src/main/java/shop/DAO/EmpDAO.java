package shop.DAO;


import java.util.HashMap;
import java.sql.Connection;
import java.sql.*;

import java.sql.*;

import java.sql.*;

public class EmpDAO {
	
	
	//empOne.jsp
	//param : empId, empName, empJob,hiredate,active
	// goodList에서 이름을 눌렀을때 정보 상세보기
	public static HashMap<String, Object>empOnelist(String empID) throws Exception{
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
	
	public static String checkID(String emp_id) 
				throws Exception{
		Class.forName("org.mariadb.jdbc.Driver"); 
        Connection conn = DBHelper.getConnection();
        String IDcheck = ""; //아이디가 사용가능한지 여부를 보여주는 변수 설정.
        
        String sql1 = "select emp_id,emp_pw,emp_name,hire_date,active from emp where emp_id = ?"; 
        PreparedStatement stmt1 = null;		
    	stmt1 = conn.prepareStatement(sql1);
    	stmt1.setString(1, emp_id);
    	
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
		String sql ="INSERT into emp (emp_id, emp_pw, emp_name,emp_job, hire_date,active) VALUES (?, PASSWORD(?),?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,empID);
		stmt.setString(2,empPW);
		stmt.setString(3,empName);
		stmt.setString(4,empJob);
		stmt.setString(5,hireDate);
		stmt.setString(6,active);
		
		System.out.println(stmt+"<------stmt");
			
		row = stmt.executeUpdate();
			
		conn.close();
		return row;
	}
	
	
	//HashMap<String, Object> : null이면 로그인실패, 아니면 성공
	//String empID,String empPW : 로그인폼에서 사용자가 입력한 id/pw
	
	//호출 코드 public static HashMap<String, Object> m = EmpDAO.emplogin("admin", "1234")
	public static HashMap<String, Object>empLogin(String empID,String empPW)
						throws Exception{
		HashMap<String, Object>resultMap = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "select emp_id empID,emp_name empName,grade from emp where active='ON' and emp_id =? and emp_pw = password(?)";
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, empID);
		stmt1.setString(2, empPW);
		
		System.out.println(stmt1+"<--stmt");
		
		
		rs1 = stmt1.executeQuery();
		
		
		if(rs1.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empID", rs1.getString("empID"));
			resultMap.put("empName", rs1.getString("empName"));
			resultMap.put("grade", rs1.getInt("grade"));
		}
		
			
		conn.close();
		return resultMap;
	}
		
}




	
	





