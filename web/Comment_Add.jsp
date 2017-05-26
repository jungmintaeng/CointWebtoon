<%@ page contentType="application/json;charset=EUC-KR" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="importClasses.DBAuthentication" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
    /* Variables */
    /* For getting data from database */
    Connection conn = null;
    PreparedStatement  pstmt = null;

    try {
        int id=Integer.parseInt(request.getParameter("id"));
        int ep_id=Integer.parseInt(request.getParameter("ep_id"));
        String Writer = request.getParameter("writer");
        String nickname = request.getParameter("nickname");
        String content = request.getParameter("content");
        /* Corresponding development environment is required for DB access */
        Class.forName(DBAuthentication.driverName);
        conn = DriverManager.getConnection(DBAuthentication.url , DBAuthentication.id, DBAuthentication.password);
        String insertSQL = "INSERT INTO COMMENT(Id_C, Ep_id, Writer, NickName, Content, Cutnumber) " +
                                    "VALUES(?, ?, ?, ?, ?, ?)";
        if(conn != null){
            pstmt = conn.prepareStatement(insertSQL);
            pstmt.setInt(1, id);
            pstmt.setInt(2, ep_id);
            pstmt.setString(3, Writer);
            pstmt.setString(4, nickname);
            pstmt.setString(5, content);
            try{
                pstmt.setInt(6, Integer.parseInt(request.getParameter("cutnumber")));
            }catch (Exception e){pstmt.setInt(6, -1);}
            pstmt.execute();
            System.out.println("´ñ±Û\n" + content + "\nADD ¿Ï·á   "  + new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss").format(new Date()).toString());
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Connection failure");
    } finally {
        if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
        if (conn != null) try {conn.close();} catch (SQLException e) {}
    }
%>