<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>Create User - Payment Management</title>

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
            margin-bottom: 25px;
        }

        .page-header h1 {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #6b7280;
            font-size: 15px;
        }

        /* Form Card */

        .form-card {
            max-width: 650px;
            background: white;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #374151;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: white;
            font-size: 14px;
            color: #1f2937;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .field-error {
            display: block;
            margin-top: 6px;
            color: #dc2626;
            font-size: 13px;
        }

        .form-hint {
            margin-top: 6px;
            color: #6b7280;
            font-size: 12px;
        }

        /* Buttons */

        .button-container {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-top: 8px;
        }

        .create-btn {
            border: none;
            background: #2563eb;
            color: white;
            padding: 11px 20px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
        }

        .create-btn:hover {
            background: #1d4ed8;
        }

        .cancel-btn {
            display: inline-block;
            background: #f3f4f6;
            color: #374151;
            padding: 11px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
        }

        .cancel-btn:hover {
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

            .form-card {
                max-width: 100%;
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

        <h1>Create User</h1>

        <p>
            Create a new user account for the Payment Management System.
        </p>

    </section>


    <div class="form-card">

        <form action="${pageContext.request.contextPath}/users-page/create"
              method="post">


            <!-- Username -->

            <div class="form-group">

                <label for="username">
                    Username
                </label>

                <input type="text"
                       id="username"
                       name="username"
                       value="${user.username}"
                       required>

                <c:if test="${not empty errors.username}">

                    <span class="field-error">
                        ${errors.username}
                    </span>

                </c:if>

            </div>


            <!-- Full Name -->

            <div class="form-group">

                <label for="fullName">
                    Full Name
                </label>

                <input type="text"
                       id="fullName"
                       name="fullName"
                       value="${user.fullName}"
                       required>

                <c:if test="${not empty errors.fullName}">

                    <span class="field-error">
                        ${errors.fullName}
                    </span>

                </c:if>

            </div>


            <!-- Password -->

            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <input type="password"
                       id="password"
                       name="password"
                       required>

                <p class="form-hint">
                    Enter a secure password for this account.
                </p>

            </div>


            <!-- Role -->

            <div class="form-group">

                <label for="role">
                    Role
                </label>

                <select id="role"
                        name="role"
                        required>

                    <option value="">
                        -- Select Role --
                    </option>

                    <option value="ADMIN">
                        ADMIN
                    </option>

                    <option value="USER">
                        USER
                    </option>

                </select>

            </div>


            <!-- Buttons -->

            <div class="button-container">

                <button class="create-btn"
                        type="submit">

                    Create User

                </button>


                <a class="cancel-btn"
                   href="${pageContext.request.contextPath}/users-page">

                    Cancel

                </a>

            </div>


        </form>

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