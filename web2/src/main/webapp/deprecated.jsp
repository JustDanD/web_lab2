<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1> Тут я тыкаю <s>труп</s> JSP палкой и люблю красивую вёрстку</h1><br/>
<button onclick="window.location.href = '${pageContext.request.contextPath}/controller';">Назад в мир розовых единорогов</button><br/><br/>
<b>Результаты прошлых проверок:</b>
<table border='1px'>
    <tr>
        <th>X</th>
        <th>Y</th>
        <th>R</th>
        <th>Попадание</th>
    </tr>
        <%
    HttpSession ses = request.getSession();
    try {
        ArrayList<String> history = (ArrayList<String>) session.getAttribute("history");
        if (history == null) {
            return;
        }
        for (int i = 0; i < history.size(); i = i + 4) {
            out.println("<tr><td>"+ history.get(i) +"</td><td>"+ history.get(i + 1) +
            "</td><td>"+ history.get(i + 2) +"</td><td>"+ history.get(i + 3) +"</td></tr>");
        }
    } catch (Exception e) {
        out.println("Что-то пошло не по плану...Вероятно, историю похитили или вы ничего не проверяли. А зря!");
    }
%>
</table>
</body>
</html>
