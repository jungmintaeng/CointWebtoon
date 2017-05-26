<%--
        안드로이드에서 json파싱할때 <html>같은 태그부분도 같이 따라오는 바람에
         contentType을 application/json으로 바꿔주어 파싱 문제를 해결했습니다.

        jsp 주소 형식 : http://localhost:8080/Likes.jsp?type=episode&id=679519&ep_id=71
                또는         http://localhost:8080/Likes.jsp?type=webton&id=679519
--%>


<%@ page contentType="application/json;charset=EUC-KR" language="java" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*" %><%@ page import="importClasses.DBAuthentication"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
	PreparedStatement statement = null;
	Connection connection = null;
  try {
    JSONObject jsonObject = new JSONObject();
    JSONArray jsonArray = new JSONArray();
    Class.forName(DBAuthentication.driverName);
    connection = DriverManager.getConnection(DBAuthentication.url, DBAuthentication.id, DBAuthentication.password);
    if(connection != null) {

      String type = request.getParameter("type");
      String id = request.getParameter("id");
      String value = request.getParameter("value");
      String ep_id;
      if(type.equals("webtoon")){                              
          String sql = "UPDATE webtoon SET Likes=Likes+1 WHERE Id=?";
	  String sqlMinus = "UPDATE webtoon SET Likes=Likes-1 WHERE Id=?";
	if(value.equals("plus")){
          statement = connection.prepareStatement(sql);
	}else if(value.equals("minus")){
          statement = connection.prepareStatement(sqlMinus);
	}else{
	System.out.println("[Like Page]Failed");
          statement = null;
	return;
	}
          statement.setInt(1,Integer.parseInt(id));
          statement.executeUpdate();
          System.out.println("[Like Page] ID : " + id + " " + value + " Successful");
      }
      else if(type.equals("episode")){                           
          ep_id = request.getParameter("ep_id");
          String sql = "UPDATE EPISODE SET Likes_E=Likes_E+1 WHERE Id_E=? AND Episode_id=?";
	  String sqlMinus = "UPDATE EPISODE SET Likes_E=Likes_E-1 WHERE Id_E=? AND Episode_id=?";
	if(value.equals("plus")){
          statement = connection.prepareStatement(sql);
	}else if(value.equals("minus")){
          statement = connection.prepareStatement(sqlMinus);
	}else{
	  System.out.println("[Like Page]Failed");
          statement = null;
	  return;
	}
          statement.setInt(1,Integer.parseInt(id));
          statement.setInt(2,Integer.parseInt(ep_id));
          statement.executeUpdate();
          System.out.println("[Like Page] ID : " + id + " Episode ID : " + ep_id  + " " + value + " Successful "+ "  "  + new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss").format(new Date()).toString());
      }
   }
  }catch (SQLException ex){
    System.out.println("SQL Exception "+ex);
ex.printStackTrace();
  }catch (Exception ex) {
    System.out.println("Exception " + ex);
	ex.printStackTrace();
  }finally{
try{	connection.close();}catch(Exception e){}
try{statement.close();}catch(Exception e){}

}
%>
