<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Users - Payment Management</title>
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

        /* Role */
        .role {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .role-admin {
            background: #ede9fe;
            color: #6d28d9;
        }
        .role-user {
            background: #eff6ff;
            color: #1d4ed8;
        }

        /* Status */
        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-active {
            background: #dcfce7;
            color: #166534;
        }
        .status-disabled {
            background: #fee2e2;
            color: #991b1b;
        }

        /* Actions */
        .action-container {
            display: flex;
            gap: 8px;
        }
        .edit-btn,.toggle-btn {
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
        .toggle-btn {
            background: #f3f4f6;
            color: #374151;
        }
        .toggle-btn:hover {
            background: #e5e7eb;
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

            <h1>Users</h1>

            <p>
                View registered users.
            </p>

        </div>


        <c:if test="${role == 'ADMIN'}">
            <a class="create-btn" href="${pageContext.request.contextPath}/users-page/create">
                  + Create User
            </a>
        </c:if>

    </section>

    <!-- Users Table -->
    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Created At</th>
                    <c:if test="${role == 'ADMIN'}">
                        <th>Action</th>
                    </c:if>
                </tr>
            </thead>

            <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>
                        ${user.id}
                    </td>
                    <td>
                        ${user.username}
                    </td>
                    <td>
                        ${user.fullName}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${user.role == 'ADMIN'}">
                                <span class="role role-admin">
                                    ADMIN
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="role role-user">
                                    USER
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${user.enabled}">
                                <span class="status status-active">
                                    ● Active
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="status status-disabled">
                                    ● Disabled
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        ${user.createdAt}
                    </td>
                    <c:if test="${role == 'ADMIN'}">
                        <td>
                            <div class="action-container">
                                <a href="${pageContext.request.contextPath}/users-page/edit/${user.id}">
                                    <button class="edit-btn" type="button">
                                        Edit
                                    </button>
                                </a>
                                <form action="${pageContext.request.contextPath}/users-page/toggle/${user.id}" method="post">
                                    <button class="toggle-btn" type="submit">
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
