<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Payment Management</title>

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

        header {
            height: 70px;
            background: white;
            display: flex;
            align-items: center;
            padding: 0 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .menu-btn {
            border: none;
            background: none;
            font-size: 28px;
            cursor: pointer;
            margin-right: 20px;
        }

        .logo {
            font-size: 21px;
            font-weight: bold;
        }

        .container {
            padding: 45px 50px;
            margin-left: 0;
            transition: margin-left 0.25s ease;
        }

        .container.menu-open {
            margin-left: 260px;
        }

        .welcome {
            margin-bottom: 35px;
        }

        .welcome h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .welcome p {
            color: #6b7280;
            font-size: 17px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .stat-card p {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .stat-card h2 {
            font-size: 28px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .panel {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .panel h2 {
            margin-bottom: 18px;
            font-size: 19px;
        }

        .cards {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            width: 260px;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.07);
        }

        .card h2 {
            margin-bottom: 12px;
        }

        .card p {
            color: #6b7280;
            line-height: 1.5;
        }

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
    </style>
</head>

<body>

<header>

    <button class="menu-btn" type="button" onclick="toggleMenu()">
        ☰
    </button>


    <div class="logo">
        Payment Management
    </div>

</header>

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

<main class="container">

    <section class="welcome">

        <h1>
            Welcome back,
            ${sessionScope.loggedInUser.fullName}
        </h1>

        <p>
            Here's an overview of your activity in the
            Payment Management System.
        </p>

    </section>


    <!-- ADMIN DASHBOARD -->

    <c:if test="${sessionScope.role == 'ADMIN'}">

        <section class="stats">

            <div class="stat-card">
                <p>Total Payments</p>
                <h2>${totalPayments}</h2>
            </div>

            <div class="stat-card">
                <p>Successful Payments</p>
                <h2>${successfulPayments}</h2>
            </div>

            <div class="stat-card">
                <p>Pending Payments</p>
                <h2>${pendingPayments}</h2>
            </div>

            <div class="stat-card">
                <p>Failed Payments</p>
                <h2>${failedPayments}</h2>
            </div>

        </section>

        <section class="dashboard-grid">

            <div class="panel">

                <h2>System Overview</h2>

                <div class="activity">
                    <strong>Total Users</strong>
                    <span>${totalUsers}</span>
                </div>

            </div>

            <div class="panel">

                <h2>Quick Actions</h2>

                <a class="quick-action"
                   href="${pageContext.request.contextPath}/payments-page">
                    View Payments
                </a>

                &nbsp;

                <a class="quick-action"
                   href="${pageContext.request.contextPath}/users-page">
                    View Users
                </a>

            </div>

        </section>

    </c:if>


    <!-- USER DASHBOARD -->

    <c:if test="${sessionScope.role == 'USER'}">

        <section class="stats">

            <div class="stat-card">
                <p>My Payments</p>
                <h2>${myPayments}</h2>
            </div>

            <div class="stat-card">
                <p>Successful</p>
                <h2>${mySuccessfulPayments}</h2>
            </div>

            <div class="stat-card">
                <p>Pending</p>
                <h2>${myPendingPayments}</h2>
            </div>

            <div class="stat-card">
                <p>Failed</p>
                <h2>${myFailedPayments}</h2>
            </div>

        </section>

        <section class="dashboard-grid">

            <div class="panel">

                <h2>My Recent Activity</h2>

                <div class="activity">
                    <strong>Payment Activity</strong>
                    <span>View Payments</span>
                </div>

                <div class="activity">
                    <strong>Account Status</strong>
                    <span>Active</span>
                </div>

            </div>

            <div class="panel">

                <h2>Quick Actions</h2>

                <a class="quick-action"
                   href="${pageContext.request.contextPath}/payments-page">
                    View My Payments
                </a>

                &nbsp;

                <a class="quick-action"
                   href="${pageContext.request.contextPath}/users-page">
                    View Users
                </a>

            </div>

        </section>

    </c:if>

</main>

<script>
    function toggleMenu() {
        const menu = document.getElementById("sideMenu");
        const container = document.querySelector(".container");

        menu.classList.toggle("open");
        container.classList.toggle("menu-open");
    }
</script>

</body>
</html>

