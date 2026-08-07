<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
</head>
<body>
<h1>Edit User</h1>

<c:if test="${not empty successMessage}">
    <p style="color:green">${successMessage}</p>
</c:if>

<form action="${pageContext.request.contextPath}/users-page/edit/${user.id}" method="post">
    <label>Username:</label>
    <input type="text" name="username" value="${user.username}" required>
    <br><br>

    <label>Full Name:</label>
    <input type="text" name="fullName" value="${user.fullName}" required>
    <br><br>

    <label>Password:</label>
    <input type="password" name="password" placeholder="Enter new password">
    <br><br>

    <label>Role:</label>
    <select name="role">

        <option value="ADMIN" <c:if test="${user.role == 'ADMIN'}">selected</c:if>>
            ADMIN
        </option>

        <option value="USER" <c:if test="${user.role == 'USER'}">selected</c:if>>
            USER
        </option>
    </select>

    <c:if test="${not empty error}">
        <p style="color:red">${error}</p>
    </c:if>

    <br><br>

    <button type="submit">Update User</button>

</form>

<br>

<a href="${pageContext.request.contextPath}/users-page">
    <button type="button">Cancel</button>
</a>

</body>
</html>