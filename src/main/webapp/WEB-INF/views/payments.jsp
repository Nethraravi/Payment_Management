<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>
</head>
<body>

    <h1>Payment Management</h1>

    <a href="${pageContext.request.contextPath}/logout">
    <button type="button">Logout</button>
    </a>
    <br><br>

    <c:if test="${not empty successMessage}">
        <p style="color: green;">
            ${successMessage}
        </p>
    </c:if>

    <a href="${pageContext.request.contextPath}/payments-page/create">
        <button type="button">Create Payment</button>
    </a>

    <br><br>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Amount</th>
                <th>Payment Method</th>
                <th>Status</th>
                <th>Payment Date</th>
                <th>Receipt</th>
                <c:if test="${role == 'ADMIN'}">
                    <th>Action</th>
                </c:if>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="payment" items="${payments}">
                <tr>
                    <td>${payment.id}</td>
                    <td>${payment.amount}</td>
                    <td>${payment.paymentMethod}</td>
                    <td>${payment.status}</td>
                    <td>${payment.paymentDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty payment.receiptPath}">
                                <a href="${pageContext.request.contextPath}/payments-page/receipt/${payment.id}" target="_blank">
                                    View Receipt
                                </a>
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <c:if test="${role == 'ADMIN'}">
                        <td>
                            <form action="${pageContext.request.contextPath}/payments-page/edit/${payment.id}" method="get" style="display:inline;">
                                <button type="submit">EDIT</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/payments-page/delete/${payment.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this payment?');">
                                <button type="submit">DELETE</button>
                            </form>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>

        </tbody>
    </table>

</body>
</html>