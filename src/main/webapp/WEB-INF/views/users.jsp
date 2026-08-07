<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
</head>
<body>
<h1>User Management</h1>
<a href="${pageContext.request.contextPath}/users-page/create">
    <button>Create User</button>
</a>
<br><br>
<table border="1" cellpadding="8">
    <thead>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Full Name</th>
        <th>Role</th>
        <th>status</th>
        <th>Created At</th>
        <th>Action</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>${user.fullName}</td>
            <td>${user.role}</td>
            <td>
                <c:choose>
                    <c:when test="${user.enabled}">
                        🟢 Active
                    </c:when>

                    <c:otherwise>
                        🔴 Disabled
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${user.createdAt}</td>
            <td>
                <a href="${pageContext.request.contextPath}/users-page/edit/${user.id}">
                    <button type="button">Edit</button>
                </a>

                <form action="${pageContext.request.contextPath}/users-page/toggle/${user.id}" method="post" style="display:inline;">
                    <button type="submit">
                        <c:choose>
                            <c:when test="${user.enabled}">
                                Disable
                            </c:when>

                            <c:otherwise>
                                Enable
                            </c:otherwise>
                        </c:choose>
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<br>

<a href="${pageContext.request.contextPath}/payments-page">
    <button type="button">Back to Payments</button>
</a>

</body>
</html>