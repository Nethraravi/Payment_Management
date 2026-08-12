<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Sign In - Payment Management</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #f5f7fa, #e4e9f2);
        }

        .login-container {
            width: 900px;
            min-height: 520px;
            display: flex;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.12);
        }

        /* Left section */

        .welcome-section {
            width: 50%;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #2563eb;
            color: white;
        }

        .welcome-section h1 {
            font-size: 38px;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .welcome-section p {
            font-size: 17px;
            line-height: 1.7;
            opacity: 0.9;
        }

        .brand {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 50px;
        }

        /* Right section */

        .login-section {
            width: 50%;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-section h2 {
            font-size: 30px;
            margin-bottom: 10px;
            color: #1f2937;
        }

        .subtitle {
            color: #6b7280;
            margin-bottom: 35px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: bold;
            color: #374151;
        }

        .form-group input {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: 0.2s;
        }

        .form-group input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .signin-btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .signin-btn:hover {
            background: #1d4ed8;
        }

        .error-message {
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 7px;
            background: #fee2e2;
            color: #b91c1c;
            font-size: 14px;
        }

        .back-link {
            margin-top: 25px;
            text-align: center;
        }

        .back-link a {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 800px) {

            body {
                padding: 20px;
            }

            .login-container {
                width: 100%;
                max-width: 500px;
            }

            .welcome-section {
                display: none;
            }

            .login-section {
                width: 100%;
                padding: 45px 35px;
            }
        }
    </style>
</head>

<body>

<div class="login-container">

    <div class="welcome-section">

        <div class="brand">
            Payment Management
        </div>

        <h1>
            Welcome back.
        </h1>

        <p>
            Sign in to securely manage payments,
            monitor transactions, and access your
            management dashboard.
        </p>

    </div>


    <div class="login-section">

        <h2>Sign In</h2>

        <p class="subtitle">
            Enter your credentials to continue.
        </p>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form method="post"
              action="${pageContext.request.contextPath}/login">

            <div class="form-group">

                <label for="username">
                    Username
                </label>

                <input type="text"
                       id="username"
                       name="username"
                       placeholder="Enter your username"
                       required>

            </div>


            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Enter your password"
                       required>

            </div>


            <button type="submit" class="signin-btn">
                Sign In
            </button>

        </form>


        <div class="back-link">
            <a href="${pageContext.request.contextPath}/">
                ← Back to Home
            </a>
        </div>

    </div>

</div>

</body>
</html>
