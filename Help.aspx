<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Help.aspx.cs" Inherits="Admin_Help" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Center | Shree Ganesh Enterprises - Warehouse IMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            /* Dark Theme (Default - matching Dashboard) */
            --sidebar-width: 260px;
            --primary: #0f172a;
            --sidebar-bg: #1e293b;
            --accent: #f59e0b;
            --bg: #0f172a;
            --card-bg: #1e293b;
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
            --border: #334155;
            --shadow: rgba(0,0,0,0.3);
        }

        /* Light Theme */
        body.light-theme {
            --primary: #ffffff;
            --sidebar-bg: #f8fafc;
            --accent: #d97706;
            --bg: #f1f5f9;
            --card-bg: #ffffff;
            --text-main: #1e293b;         /* Black text in light mode */
            --text-muted: #64748b;
            --border: #e2e8f0;
            --shadow: rgba(0,0,0,0.08);
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        html, body {
            height: 100%;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: var(--text-main);
            transition: background-color 0.4s ease, color 0.4s ease;
            overflow: hidden;
        }

        /* SIDEBAR */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            background: var(--sidebar-bg);
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            border-right: 1px solid var(--border);
            box-shadow: 4px 0 10px var(--shadow);
            z-index: 100;
        }

        .sidebar-header {
            padding: 30px 20px;
            border-bottom: 1px solid var(--border);
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
        }

        .logo-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            overflow: hidden;
            border: 4px solid var(--accent);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        .logo-circle img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .sidebar-header h2 {
            font-size: 1.35rem;
            font-weight: 700;
            color: var(--accent);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .sidebar-menu {
            padding: 20px 0;
            flex-grow: 1;
            overflow-y: auto;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 14px 25px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            margin: 4px 15px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: var(--accent);
            color: white;
            transform: translateX(8px);
            box-shadow: 0 4px 8px rgba(245,158,11,0.3);
        }

        .sidebar-menu a span {
            margin-left: 15px;
        }

        /* MAIN WRAPPER */
        .main-wrapper {
            margin-left: var(--sidebar-width);
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        /* TOP NAV */
        .top-nav {
            background: var(--card-bg);
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 2px 8px var(--shadow);
            border-bottom: 1px solid var(--border);
            flex-shrink: 0;
        }

        .page-title h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-main);
            margin: 0;
        }

        .top-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .lang-switch {
            display: flex;
            gap: 10px;
        }

        .lang-btn {
            background: transparent;
            color: var(--text-main);
            border: 2px solid var(--accent);
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .lang-btn:hover, .lang-btn.active {
            background: var(--accent);
            color: white;
        }

        .theme-toggle {
            background: transparent;
            border: 2px solid var(--text-muted);
            color: var(--text-main);
            width: 46px;
            height: 46px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            transition: all 0.3s ease;
        }

        .theme-toggle:hover {
            border-color: var(--accent);
            color: var(--accent);
            transform: scale(1.1);
        }

        /* CONTENT */
        .content-body {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
        }

        .help-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 40px;
            border: 1px solid var(--border);
            box-shadow: 0 10px 25px var(--shadow);
            max-width: 1000px;
            margin: 0 auto;
        }

        .help-card h1 {
            font-size: 2.2rem;
            color: var(--accent);
            margin-bottom: 20px;
            text-align: center;
        }

        .help-card h3 {
            font-size: 1.4rem;
            color: var(--text-main);
            margin: 35px 0 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid var(--accent);
        }

        .help-card p, .help-card li {
            color: var(--text-muted);
            line-height: 1.8;
            font-size: 1rem;
            margin-bottom: 14px;
        }

        .help-card ul {
            padding-left: 24px;
        }

        .help-card ul li {
            margin-bottom: 10px;
        }

        @media (max-width: 1024px) {
            .sidebar { width: 80px; }
            .sidebar-header h2, .sidebar-menu a span { display: none; }
            .sidebar-menu a { justify-content: center; }
            .main-wrapper { margin-left: 80px; }
        }

        @media (max-width: 768px) {
            .content-body { padding: 20px; }
            .help-card { padding: 25px; }
            .help-card h1 { font-size: 1.8rem; }
            .top-nav { padding: 0 20px; flex-wrap: wrap; gap: 15px; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo-circle">
                <img src="../img/logo.png" alt="Shree Ganesh Logo">
            </div>
            <h2>Shree Ganesh<br>Enterprises</h2>
        </div>
        <div class="sidebar-menu">
            <a href="Dashboard.aspx"><span>Dashboard</span></a>
            <a href="Customers.aspx"><span>Customers</span></a>
            <a href="Products.aspx"><span>Products</span></a>
            <a href="Purchase.aspx"><span>Purchases</span></a>
            <a href="Sales.aspx"><span>Sales</span></a>
            <a href="Stock.aspx"><span>Stock / Inventory</span></a>
                        <a href="ClientManagement.aspx"><span>Client Management</span></a>

            <a href="Help.aspx" class="active"><span>Help Center</span></a>
            <a href="../Account/Login.aspx"><span>Log Out</span></a>
        </div>
    </div>

    <!-- MAIN -->
    <div class="main-wrapper">
        <nav class="top-nav">
            <div class="page-title">
                <h1>Help Center</h1>
            </div>

            <div class="top-controls">
                <div class="lang-switch">
                    <asp:Button ID="btnEN" runat="server" Text="English" CssClass="lang-btn" OnClick="btnEN_Click" />
                    <asp:Button ID="btnMR" runat="server" Text="मराठी" CssClass="lang-btn" OnClick="btnMR_Click" />
                    <asp:Button ID="btnHI" runat="server" Text="हिंदी" CssClass="lang-btn" OnClick="btnHI_Click" />
                </div>

                <button type="button" class="theme-toggle" id="themeToggle" title="Toggle Theme">
                    ☀️
                </button>
            </div>
        </nav>

        <div class="content-body">
            <div class="help-card">
                <h1>Help Center</h1>
                <asp:Literal ID="litHelpContent" runat="server" Text="<p>Welcome to the Help Center. Select a language above to view instructions.</p>" />
            </div>
        </div>
    </div>
</form>

<script>
    const themeToggle = document.getElementById('themeToggle');
    const body = document.body;

    // Load saved theme
    if (localStorage.getItem('theme') === 'light') {
        body.classList.add('light-theme');
        themeToggle.textContent = '🌙';
    } else {
        themeToggle.textContent = '☀️';
    }

    themeToggle.addEventListener('click', () => {
        body.classList.toggle('light-theme');
    if (body.classList.contains('light-theme')) {
        themeToggle.textContent = '🌙';
        localStorage.setItem('theme', 'light');
    } else {
        themeToggle.textContent = '☀️';
        localStorage.setItem('theme', 'dark');
    }
    });
</script>
</body>
</html>