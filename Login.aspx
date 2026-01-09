<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IMS | Enterprise Inventory Solutions</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Noto+Sans+Devanagari:wght@700&display=swap" rel="stylesheet">
    <style>
        :root {
            --orange: #ff7e00;
            --light-orange: #ffb84d;
            --deep-orange: #f97316;
            --white: #ffffff;
            --text-main: #333333;
            --text-muted: #666666;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(to right, var(--light-orange) 50%, #fff9f0 50%);
            position: relative;
            overflow: hidden;
        }

        /* Subtle orange particles background */
        body::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at 20% 50%, rgba(255,126,0,0.1) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(255,184,77,0.08) 0%, transparent 50%);
            animation: particleFloat 30s linear infinite;
            z-index: -1;
        }

        @keyframes particleFloat {
            0% { transform: translate(0, 0); }
            50% { transform: translate(60px, -60px); }
            100% { transform: translate(0, 0); }
        }

        /* Master wrapper - split layout */
        .master-wrapper {
            display: flex;
            width: 900px;
            max-width: 95%;
            background: var(--white);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        /* Left orange side with cloud wave */
        .brand-side {
            flex: 1;
            background: linear-gradient(135deg, var(--deep-orange), var(--orange));
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: var(--white);
            position: relative;
            overflow: hidden;
        }

        .brand-side::after {
            content: '';
            position: absolute;
            top: 0;
            right: -100px;
            width: 300px;
            height: 100%;
            background: linear-gradient(to left, rgba(255,255,255,0.9), transparent);
            clip-path: path('M0,0 Q100,200 0,400 Q100,600 0,800 L0,800 L0,0 Z');
            transform: rotate(10deg);
            opacity: 0.4;
        }

        /* Circular logo */
        .logo-circle {
            width: 140px;
            height: 140px;
            margin-bottom: 30px;
            border-radius: 50%;
            overflow: hidden;
            border: 8px solid var(--white);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .logo-circle img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Animated Title */
        .page-title {
            font-family: 'Noto Sans Devanagari', sans-serif;
            font-size: 2.4rem;
            font-weight: 700;
            color: var(--white);
            margin: 0 0 20px;
            position: relative;
            display: inline-block;
            animation: fadeIn 1.5s ease-out, float 6s ease-in-out infinite, glowPulse 4s ease-in-out infinite;
            text-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }

        .page-title::before {
            content: '';
            position: absolute;
            top: 0; left: -100%;
            width: 50%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.7), transparent);
            transform: skewX(-25deg);
            animation: shine 5s infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-12px); }
        }

        @keyframes glowPulse {
            0%, 100% { text-shadow: 0 0 15px rgba(255,255,255,0.5); }
            50% { text-shadow: 0 0 30px rgba(255,255,255,0.8); }
        }

        @keyframes shine {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        /* Right login side */
        .login-side {
            flex: 1.1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: var(--white);
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-header h2 {
            font-size: 1.8rem;
            color: var(--text-main);
            margin: 0;
        }

        .login-header p {
            color: var(--text-muted);
            margin-top: 8px;
        }

        /* Form */
        .form-group {
            margin-bottom: 24px;
            text-align: left;
        }

        label {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 8px;
            display: block;
        }

        .input-wrapper {
            position: relative;
        }

        .input-field {
            width: 100%;
            padding: 16px 18px;
            font-size: 1rem;
            border: 2px solid #fee0c0;
            border-radius: 16px;
            transition: all 0.3s ease;
            outline: none;
        }

        .input-field:focus {
            border-color: var(--orange);
            box-shadow: 0 0 0 4px rgba(255,126,0,0.2);
        }

        .toggle-password {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            font-weight: 600;
        }

        .toggle-password:hover {
            color: var(--orange);
        }

        /* Login button */
        .btn-login {
            width: 100%;
            padding: 18px;
            background: var(--light-orange);
            color: white;
            border: none;
            border-radius: 16px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            position: relative;
            overflow: hidden;
            transition: background 0.3s ease;
        }

        .btn-login:hover {
            background: #ffa133;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -100%;
            width: 50%;
            height: 200%;
            background: linear-gradient(120deg, transparent, rgba(255,255,255,0.5), transparent);
            transform: skewX(-25deg);
            transition: left 0.7s ease;
        }

        .btn-login:hover::before {
            left: 120%;
        }

        .error-container, .footer-note {
            text-align: center;
            margin-top: 20px;
        }

        .error-msg {
            color: #ef4444;
            font-weight: 500;
        }

        .footer-note {
            font-size: 0.8rem;
            color: var(--text-muted);
            border-top: 1px solid #f1f5f9;
            padding-top: 20px;
            margin-top: 40px;
        }

        /* Mobile responsive */
        @media (max-width: 768px) {
            .master-wrapper {
                flex-direction: column;
            }
            .brand-side::after {
                display: none;
            }
            .brand-side, .login-side {
                padding: 40px;
            }
            .page-title {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="master-wrapper">
            <!-- Left Brand Side -->
            <div class="brand-side">
                <div class="logo-circle">
                    <img src="../img/logo.png" alt="Shri Ganesh Logo">
                </div>
                <h1 class="page-title">श्री गणेश इंटरप्रायजेस</h1>
            </div>

            <!-- Right Login Side -->
            <div class="login-side">
                <div class="login-header">
                    <h2>Welcome Back</h2>
                    <p>Enter your credentials to access the system</p>
                </div>

                <div class="form-group">
                    <label for="txtUsername">Staff ID / Username</label>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" placeholder="e.g. WMS-4829" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtPassword">Security Key</label>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Enter password" />
                        <button type="button" class="toggle-password" id="btnToggle" onclick="togglePassword()">SHOW</button>
                    </div>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Log In to System" CssClass="btn-login" OnClick="btnLogin_Click" />

                <div class="error-container">
                    <asp:Label ID="lblMsg" runat="server" CssClass="error-msg" />
                </div>

                <div class="footer-note">
                    &copy; 2026 Enterprise Logistics Solutions. <br />
                    Secure Environment. All activities are logged.
                </div>
            </div>
        </div>
    </form>

    <script>
        function togglePassword() {
            var pwdField = document.getElementById('<%= txtPassword.ClientID %>');
            var btn = document.getElementById('btnToggle');
            if (pwdField.type === "password") {
                pwdField.type = "text";
                btn.innerText = "HIDE";
            } else {
                pwdField.type = "password";
                btn.innerText = "SHOW";
            }
        }
    </script>
</body>
</html>