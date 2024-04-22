package shop.DAO;

import java.sql.Connection;

import java.util.ArrayList;
import java.util.HashMap;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CategoryDAO {

    public static ArrayList<HashMap<String, Object>> getCategoryList() throws Exception {
        ArrayList<HashMap<String, Object>> categoryList = new ArrayList<>();
        String sql1 = "SELECT category, create_date AS createDate FROM category";
        Connection conn = DBHelper.getConnection();
        PreparedStatement stmt1 = conn.prepareStatement(sql1);
        ResultSet rs1 = stmt1.executeQuery();

        while (rs1.next()) {
            HashMap<String, Object> categoryMap = new HashMap<>();
            categoryMap.put("category", rs1.getString("category"));
            categoryMap.put("createDate", rs1.getString("createDate"));
            categoryList.add(categoryMap);
        }

        rs1.close();
        stmt1.close();
        conn.close();

        return categoryList;
    }
}

