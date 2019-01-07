<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Result...</title>
</head>
<body>
<%=request.getAttribute("dlist") %>
asdf
	<c:if test="${dlist == null}">
null...</c:if>
	<c:if test="${dlist != null}">
not null...</c:if>
	<c:forEach items="${dlist}" var="d">
		<p>${d}</p>
	</c:forEach>
</body>
</html>