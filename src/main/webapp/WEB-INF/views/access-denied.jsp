<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>ACCESS DENIED</title>
</head>
<body>
    <h1>Access Denied</h1>
    <p style="color:red;">${error}</p>
    <a href="${pageContext.request.contextPath}/payments-page">
        <button type="button">Back to Payments</button>
    </a>
</body>
</html>