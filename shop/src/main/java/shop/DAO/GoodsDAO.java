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
}
