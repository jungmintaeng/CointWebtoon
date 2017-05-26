<%--
        �ȵ���̵忡�� json�Ľ��Ҷ� <html>���� �±׺κе� ���� ������� �ٶ���
         contentType�� application/json���� �ٲ��־� �Ľ� ������ �ذ��߽��ϴ�.

        jsp �ּ� ���� : http://localhost:8080/Likes.jsp?id=679519&ep_id=71
--%>

<%@ page contentType="application/json;charset=EUC-KR" language="java" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*" %><%@ page import="importClasses.DBAuthentication"%><%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
    Connection connection = null;
    ResultSet resultSet = null;
    PreparedStatement statement = null;
  try {
    JSONObject jsonObject = new JSONObject();
    JSONArray jsonArray = new JSONArray();
    Class.forName(DBAuthentication.driverName);
    connection = DriverManager.getConnection(DBAuthentication.url, DBAuthentication.id, DBAuthentication.password);
    if(connection != null) {

      String id = request.getParameter("id");
      String ep_id = request.getParameter("ep_id");

     String sql = "SELECT  * FROM IMAGE WHERE Id_I=? AND Ep_id=? ORDER BY Image_id ASC";
     statement = connection.prepareStatement(sql);

     statement.setString(1,id);
     statement.setString(2,ep_id);

     resultSet = statement.executeQuery();

      int i=0;
      while(resultSet.next()){
        JSONObject object = new JSONObject();   //JSON������ ���� ��ü

        object.put("id",resultSet.getString("Id_I"));
        object.put("ep_id",resultSet.getString("Ep_id"));
        object.put("image_id",resultSet.getString("Image_id"));
        object.put("image_url",resultSet.getString("Image_url"));

        jsonArray.add(i,object);
        jsonObject.put("result",jsonArray); // JSON�� ���� ����

        i++;
      }
      out.println(jsonObject);
      out.flush();
      System.out.println("[Image Page] ID : " + id  + " Episode ID : " + ep_id +  " Connection successful"+ "  "  + new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss").format(new Date()).toString());
    }
  }catch (SQLException ex){
    System.out.println("SQL Exception "+ex);
  }catch (Exception ex) {
    System.out.println("Exception " + ex);
  }finally{
        if (resultSet != null) try {resultSet.close();} catch (SQLException e) {}
        if (statement != null) try {statement.close();} catch (SQLException e) {}
        if (connection != null) try {connection.close();} catch (SQLException e) {}
  }
%>