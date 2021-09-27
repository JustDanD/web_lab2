
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1> Тут я тыкаю <s>труп</s> JSP палкой и люблю красивую вёрстку</h1><br/>
<button onclick="window.location.href = '${pageContext.request.contextPath}/controller';">Назад в мир розовых единорогов</button><br/><br/>
<b>Результаты прошлых проверок:</b>

    <c:if test="${sessionScope.get('history').size() > 0}">
        <c:out value="<table border='1px'>
        <tr>
            <th>X</th>
            <th>Y</th>
            <th>R</th>
            <th>Попадание</th>
        </tr>" escapeXml="false"/>
            <c:forEach var="i" begin="0" end="${sessionScope.get('history').size()-4}" step="4">
            <c:out value="<tr><td>${sessionScope.get('history').get(i)}</td>" escapeXml="false"/>
                <c:out value="<td>${sessionScope.get('history').get(i+1)}</td>" escapeXml="false"/>
                <c:out value="<td>${sessionScope.get('history').get(i+2)}</td>" escapeXml="false"/>
                <c:out value="<td>${sessionScope.get('history').get(i+3)}</td></tr>" escapeXml="false"/>
        </c:forEach>
    <c:out value="</table>" escapeXml="false"/>
    </c:if>
</body>
</html>
