<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Payment</title>
</head>
<body>
<h1>Edit Payment</h1>

<form method="post" action="${pageContext.request.contextPath}/payments-page/edit/${payment.id}" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${payment.id}">
    <label>Amount:</label>
    <input type="text" name="amount" value="${payment.amount}">
    <br><br>
    <label>Payment Method:</label>
    <select name="paymentMethod">
        <option value="CARD" ${payment.paymentMethod == 'CARD' ? 'selected' : ''}>
            CARD
        </option>

        <option value="NET_BANKING" ${payment.paymentMethod == 'NET_BANKING' ? 'selected' : ''}>
            NET BANKING
        </option>

        <option value="UPI" ${payment.paymentMethod == 'UPI' ? 'selected' : ''}>
             UPI
        </option>

        <option value="CASH" ${payment.paymentMethod == 'CASH' ? 'selected' : ''}>
            CASH
        </option>

    </select>
    <br><br>
    <label>Status:</label>
    <select name="status">
        <option value="PENDING" ${payment.status == 'PENDING' ? 'selected' : ''}>
            Pending
        </option>

        <option value="SUCCESS" ${payment.status == 'SUCCESS' ? 'selected' : ''}>
            Success
        </option>

        <option value="FAILED" ${payment.status == 'FAILED' ? 'selected' : ''}>
            Failed
        </option>
    </select>
    <label>Receipt:</label>
    <input type="file" name="receipt">
    <br><br>
    <button type="submit">
        Update Payment
    </button>
</form>
<br>
<a href="${pageContext.request.contextPath}/payments-page">
    Cancel
</a>

</body>
</html>