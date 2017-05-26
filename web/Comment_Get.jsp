<%@ page contentType="application/json;charset=EUC-KR" language="java" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*" %>
<%@ page import="importClasses.DBAuthentication" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
    /* Variables */
    /* For getting data from database */
    Connection conn = null;
    PreparedStatement  pstmt = null;
    ResultSet rs = null;
    String cutNum = null;

    /* For JSON generation */
    int resultCount = 0;
    JSONObject jsonResult = new JSONObject();
    JSONArray jsonArray = new JSONArray();

    try {
        /* Corresponding development environment is required for DB access */
        Class.forName(DBAuthentication.driverName);
        conn = DriverManager.getConnection(DBAuthentication.url , DBAuthentication.id, DBAuthentication.password);

        if(conn != null){
            int id = Integer.parseInt(request.getParameter("id"));
            int ep_id = Integer.parseInt(request.getParameter("ep_id"));
            /* Query statement (Need to modify as needed) */
            String sql = "SELECT * " +
                    "FROM COMMENT " +
                    "WHERE Id_C = " + id + " AND Ep_id=" + ep_id;
            try{
                cutNum = request.getParameter("cutnumber");
            }catch (Exception e){}
            if(cutNum != null){
                sql += " AND Cutnumber="+ cutNum;
            }

            sql += " ORDER BY TIME DESC";
            /* Query request */
            pstmt= conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            /* Create JSON */
            while(rs.next()){
                JSONObject jsonObject = new JSONObject();

                jsonObject.put("Comment_id", rs.getString("Comment_id"));
                jsonObject.put("Id_C", rs.getString("Id_C"));
                jsonObject.put("Ep_id", rs.getString("Ep_id"));
                jsonObject.put("Writer", rs.getString("Writer"));
                jsonObject.put("Nickname", rs.getString("Nickname"));
                jsonObject.put("Content", rs.getString("Content"));
                jsonObject.put("Likes_C", rs.getString("Likes_C"));
                jsonObject.put("Time", rs.getString("Time"));
                jsonObject.put("Cutnumber", rs.getString("Cutnumber"));

                jsonArray.add(resultCount, jsonObject); resultCount++;
            }
            jsonResult.put("list_total_count", resultCount);
            jsonResult.put("result", jsonArray);

            out.println(jsonResult);
            out.flush();
            System.out.println("[COMMENT Page] ID : " + id  + " Connection successful" + "  "  + new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss").format(new Date()).toString());
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Connection failure");
    } finally {
        if (rs != null) try {rs.close();} catch (SQLException e) {}
        if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
        if (conn != null) try {conn.close();} catch (SQLException e) {}
    }
%>