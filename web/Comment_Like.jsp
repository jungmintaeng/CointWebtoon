<%@ page contentType="application/json;charset=EUC-KR" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %><%@ page import="java.sql.SQLException"%><%@ page import="importClasses.DBAuthentication"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
	    Connection connection = null;
	PreparedStatement statement = null;
  try {
    Class.forName(DBAuthentication.driverName);
    connection = DriverManager.getConnection(DBAuthentication.url, DBAuthentication.id, DBAuthentication.password);
    if(connection != null) {

      String id = request.getParameter("comment_id");

      //Connection ��ü�� ����, ���ǹ� ����� ���� statement ��ü ����

      String sql = "UPDATE comment SET Likes_C=Likes_C+1 WHERE Comment_id=?";
	statement = connection.prepareStatement(sql);

      statement.setString(1,id);            //  where���� ������ ����
      statement.executeUpdate();                      //���� ����
      System.out.println("[Comment Like Page] ID : " + id  + " Connection successful"+ "  "  + new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss").format(new Date()).toString());
   }
  }catch (SQLException ex){
    System.out.println("SQL Exception "+ex);
  }catch (Exception ex) {
    System.out.println("Exception " + ex);
  }finally{
	try{	connection.close();}catch(Exception e){}
try{statement.close();}catch(Exception e){}
  }
%>
