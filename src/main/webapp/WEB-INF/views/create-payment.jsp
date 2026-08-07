<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Payment</title>
</head>
<body>
    <h1>Create Payment</h1>
    <form action="${pageContext.request.contextPath}/payments-page/create" method="post" enctype="multipart/form-data">
        <label>Amount:</label>
        <input type="number" name="amount" step="0.01" required>

        <br>

        <c:if test="${not empty errors.amount}">
            <span style="color:red;">
                ${errors.amount}
            </span>
        </c:if>

        <br><br>
        <label>Payment Method:</label>
        <select name="paymentMethod" required>
            <option value="">-- Select Payment Method --</option>
            <option value="UPI">UPI</option>
            <option value="CARD">CARD</option>
            <option value="NET_BANKING">Net Banking</option>
        </select>
        <c:if test="${not empty errors.paymentMethod}">
             <span style="color:red;">
                  ${errors.paymentMethod}
             </span>
        </c:if>
        <br><br>
        <label>Status:</label>
        <select name="status" required>
            <option value="">-- Select Status --</option>
            <option value="SUCCESS">Success</option>
            <option value="PENDING">Pending</option>
            <option value="FAILED">Failed</option>
        </select>
        <br><br>
        <c:if test="${not empty errors.status}">
            <span style="color:red;">
                 ${errors.status}
            </span>
        </c:if>

        <label>Receipt:</label>
        <input type="file" name="receipt">

        <button type="submit">Create Payment</button>

    </form>

    <br>

    <a href="${pageContext.request.contextPath}/payments-page">
        <button type="button">Back to payments</button>
    </a>

</body>
</html>