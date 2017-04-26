<%@ page import="importClasses.EpisodeParse" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page contentType="text/html;charset=EUC-KR" language="java" %>
<html>
<head>
    <title>$Episode Webtoon Parsing$</title>
</head>
<body>
<%!
    private String certification = "TEAM_COINT";
%>
<%
    try{
        if(!request.getHeader("certification").equals(certification)){
            out.println("������ �����ϴ�.");
        }else {
            EpisodeParse parseInstance = new EpisodeParse();

            if(parseInstance.updateEpisodes(request.getParameter("update")))
                out.print("�� " + parseInstance.updateCount() + "���� SQL�� ������Ʈ �Ϸ�");
            else
                out.print("ERR OCCURRED");
        }
    }catch (Exception e){
        out.print("ERR OCCURRED, ������ ���ų� ���� ���� �� ������ �߻��߽��ϴ�.");
        e.printStackTrace();
    }
%>
</body>
</html>