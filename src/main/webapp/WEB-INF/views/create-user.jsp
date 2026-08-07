<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create User</title>
</head>
<body>
<h1>Create User</h1>
<form action="${pageContext.request.contextPath}/users-page/create" method="post">
    <label>Username:</label>
    <input type="text" name="username" value="${user.username}" required>
    <span style="color:red">${errors.username}</span>
    <br><br>
    <label> Full Name:</label>
    <input type="text" name="fullName" value="${user.fullName}" required>
    <span style="color:red">${errors.fullName}</span>
    <br><br>
    <label>Password:</label>
    <input type="password" name="password" required>
    <br><br>
    <label>Role:</label>
    <select name="role" required>
        <option value="">-- Select Role --</option>
        <option value="ADMIN">ADMIN</option>
        <option value="USER">USER</option>
    </select>
    <br><br>
    <button type="submit">Create User</button>
</form>
<br>
<a href="${pageContext.request.contextPath}/users-page">
    <button type="button">Back to Users</button>
</a>
</body>
</html>