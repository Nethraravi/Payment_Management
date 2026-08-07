<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login</h1>

<C:if test="${not empty error}">
    <p style="color:red;">
        ${error}
    </p>
</C:if>

<form action = "${pageContext.request.contextPath}/login" method="post">
    <label>Username:</label>
    <input type="text" name="username" required>
    <br><br>
    <label>Password:</label>
    <input type="password" name="password" required>
    <br><br>
    <button type="submit">Login</button>
</form>
</body>
</html>