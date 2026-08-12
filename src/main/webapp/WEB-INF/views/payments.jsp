<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>

    <title>Payments - Payment Management</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: #f5f7fa;
            color: #1f2937;
        }

        /* Header */

        header {
            height: 70px;
            background: white;
            display: flex;
            align-items: center;
            padding: 0 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            position: relative;
            z-index: 10;
        }

        .menu-btn {
            border: none;
            background: none;
            font-size: 28px;
            cursor: pointer;
            margin-right: 20px;
            color: #374151;
        }

        .logo {
            font-size: 21px;
            font-weight: bold;
        }

        /* Side Menu */

        .side-menu {
            position: fixed;
            top: 70px;
            left: -260px;
            width: 260px;
            height: calc(100vh - 70px);
            background: white;
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.08);
            transition: left 0.25s ease;
            padding: 25px 0;
            z-index: 1000;
        }

        .side-menu.open {
            left: 0;
        }

        .side-menu a {
            display: block;
            padding: 15px 30px;
            color: #374151;
            text-decoration: none;
            font-size: 16px;
        }

        .side-menu a:hover {
            background: #f3f4f6;
            color: #2563eb;
        }

        .side-menu .logout {
            margin-top: 15px;
            border-top: 1px solid #e5e7eb;
            padding-top: 15px;
            color: #dc2626;
        }

        /* Main */

        .container {
            padding: 40px 50px;
            margin-left: 0;
            transition: margin-left 0.25s ease;
        }

        .container.menu-open {
            margin-left: 260px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #6b7280;
            font-size: 15px;
        }

        /* Create button */

        .create-btn {
            background: #2563eb;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
        }

        .create-btn:hover {
            background: #1d4ed8;
        }

        /* Success message */

        .success-message {
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        /* Table */

        .table-card {
            background: white;
            border-radius: 14px;
            padding: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 16px;
            background: #f9fafb;
            color: #6b7280;
            font-size: 13px;
            text-transform: uppercase;
        }

        td {
            padding: 16px;
            border-top: 1px solid #e5e7eb;
            font-size: 14px;
        }

        tbody tr:hover {
            background: #f9fafb;
        }

        /* Status */

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-success {
            background: #dcfce7;
            color: #166534;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-failed {
            background: #fee2e2;
            color: #991b1b;
        }

        /* Receipt */

        .receipt-link {
            color: #2563eb;
            text-decoration: none;
            font-weight: 500;
        }

        .receipt-link:hover {
            text-decoration: underline;
        }

        /* Actions */

        .action-container {
            display: flex;
            gap: 8px;
        }

        .edit-btn,
        .delete-btn {
            border: none;
            padding: 7px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
        }

        .edit-btn {
            background: #eff6ff;
            color: #1d4ed8;
        }

        .edit-btn:hover {
            background: #dbeafe;
        }

        .delete-btn {
            background: #fef2f2;
            color: #dc2626;
        }

        .delete-btn:hover {
            background: #fee2e2;
        }

        /* Responsive */

        @media (max-width: 800px) {

            .container {
                padding: 30px 20px;
            }

            .container.menu-open {
                margin-left: 0;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

        }

    </style>

</head>

<body>


<header>

    <button class="menu-btn"
            type="button"
            onclick="toggleMenu()">
        ☰
    </button>

    <div class="logo">
        Payment Management
    </div>

</header>


<!-- Hamburger Menu -->

<nav id="sideMenu" class="side-menu">

    <a href="${pageContext.request.contextPath}/payments-page">
        Payments
    </a>

    <a href="${pageContext.request.contextPath}/users-page">
        Users
    </a>

    <a class="logout"
       href="${pageContext.request.contextPath}/logout">
        Logout
    </a>

</nav>


<!-- Main Content -->

<main id="mainContent" class="container">


    <section class="page-header">

        <div>
            <h1>Payments</h1>

            <p>
                Manage and monitor payment transactions.
            </p>
        </div>


        <a class="create-btn"
           href="${pageContext.request.contextPath}/payments-page/create">
            + Create Payment
        </a>

    </section>


    <!-- Success Message -->

    <c:if test="${not empty successMessage}">

        <div class="success-message">
            ${successMessage}
        </div>

    </c:if>


    <!-- Payment Table -->

    <div class="table-card">

        <table>

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

                        <td>
                            ${payment.id}
                        </td>

                        <td>
                            ${payment.amount}
                        </td>

                        <td>
                            ${payment.paymentMethod}
                        </td>


                        <td>

                            <c:choose>

                                <c:when test="${payment.status == 'SUCCESS'}">

                                    <span class="status status-success">
                                        SUCCESS
                                    </span>

                                </c:when>


                                <c:when test="${payment.status == 'PENDING'}">

                                    <span class="status status-pending">
                                        PENDING
                                    </span>

                                </c:when>


                                <c:when test="${payment.status == 'FAILED'}">

                                    <span class="status status-failed">
                                        FAILED
                                    </span>

                                </c:when>

                            </c:choose>

                        </td>


                        <td>
                            ${payment.paymentDate}
                        </td>


                        <td>

                            <c:choose>

                                <c:when test="${not empty payment.receiptPath}">

                                    <a class="receipt-link"
                                       href="${pageContext.request.contextPath}/payments-page/receipt/${payment.id}"
                                       target="_blank">

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

                                <div class="action-container">

                                    <form action="${pageContext.request.contextPath}/payments-page/edit/${payment.id}"
                                          method="get">

                                        <button class="edit-btn"
                                                type="submit">

                                            Edit

                                        </button>

                                    </form>


                                    <form action="${pageContext.request.contextPath}/payments-page/delete/${payment.id}"
                                          method="post"
                                          onsubmit="return confirm('Are you sure you want to delete this payment?');">

                                        <button class="delete-btn"
                                                type="submit">

                                            Delete

                                        </button>

                                    </form>

                                </div>

                            </td>

                        </c:if>

                    </tr>

                </c:forEach>

            </tbody>

        </table>

    </div>

</main>


<script>

    function toggleMenu() {

        const menu = document.getElementById("sideMenu");

        const container = document.getElementById("mainContent");

        menu.classList.toggle("open");

        container.classList.toggle("menu-open");

    }

</script>


</body>
</html>
