<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa, #e4e9f2);
            color: #1f2937;
        }

        header {
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 60px;
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
        }

        .hero {
            min-height: calc(100vh - 70px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 50px;
        }

        .hero-content {
            max-width: 1100px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 70px;
        }

        .text-section {
            flex: 1;
        }

        .text-section h1 {
            font-size: 52px;
            line-height: 1.1;
            margin-bottom: 25px;
        }

        .text-section p {
            font-size: 19px;
            line-height: 1.7;
            color: #6b7280;
            margin-bottom: 35px;
            max-width: 550px;
        }

        .signin-btn {
            display: inline-block;
            padding: 14px 32px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            transition: 0.2s;
        }

        .signin-btn:hover {
            background: #1d4ed8;
        }

        .visual-section {
            flex: 1;
            display: flex;
            justify-content: center;
        }

        .card {
            width: 380px;
            padding: 35px;
            background: white;
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
        }

        .card h2 {
            margin-bottom: 25px;
        }

        .payment-row {
            display: flex;
            justify-content: space-between;
            padding: 17px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .payment-row:last-child {
            border-bottom: none;
        }

        .success {
            color: #16a34a;
            font-weight: bold;
        }

        .pending {
            color: #d97706;
            font-weight: bold;
        }

        .failed {
            color: #dc2626;
            font-weight: bold;
        }

        @media (max-width: 800px) {

            header {
                padding: 0 25px;
            }

            .hero {
                padding: 40px 25px;
            }

            .hero-content {
                flex-direction: column;
                text-align: center;
            }

            .text-section p {
                margin-left: auto;
                margin-right: auto;
            }

            .card {
                width: 100%;
                max-width: 380px;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="logo">
        Payment Management
    </div>
</header>

<section class="hero">

    <div class="hero-content">

        <div class="text-section">

            <h1>
                Manage your payments
                with confidence.
            </h1>

            <p>
                A simple and secure platform to manage payments,
                monitor transaction status, and keep everything
                organized in one place.
            </p>

            <a class="signin-btn"
               href="${pageContext.request.contextPath}/login">
                Sign In
            </a>

        </div>

        <div class="visual-section">

            <div class="card">

                <h2>Payment Overview</h2>

                <div class="payment-row">
                    <span>Payment #1042</span>
                    <span class="success">SUCCESS</span>
                </div>

                <div class="payment-row">
                    <span>Payment #1043</span>
                    <span class="pending">PENDING</span>
                </div>

                <div class="payment-row">
                    <span>Payment #1044</span>
                    <span class="failed">FAILED</span>
                </div>

            </div>

        </div>

    </div>

</section>

</body>
</html>

