<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>श्री गणेश इंटरप्रायजेस | Warehouse IMS Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Noto+Sans+Devanagari:wght@700&display=swap" rel="stylesheet">
    <style>
        :root {
            --sidebar-width: 280px;
            --sidebar-collapsed-width: 80px;
            --orange: #ff7e00;
            --light-orange: #ffb84d;
            --deep-orange: #f97316;
            --white: #ffffff;
            --bg: #f8f9fc;
            --card-bg: #ffffff;
            --text-main: #333333;
            --text-muted: #666666;
            --border: #e0e0e0;
            --shadow: rgba(0,0,0,0.08);
        }
        /* Soft Dark-Orange Theme (for toggle) */
        body.dark-theme {
            --bg: #fffaf0;
            --card-bg: #fff7ed;
            --text-main: #444444;
            --border: #fed7aa;
            --shadow: rgba(255,126,0,0.1);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body {
            height: 100%;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: var(--text-main);
            transition: all 0.4s ease;
            overflow: hidden;
        }
        /* SIDEBAR */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            background: var(--white);
            display: flex;
            flex-direction: column;
            transition: width 0.3s ease;
            z-index: 100;
            border-right: 1px solid var(--border);
            box-shadow: 4px 0 20px var(--shadow);
        }
        .sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }
        .sidebar-header {
            padding: 30px 20px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 16px;
            min-height: 110px;
            justify-content: center;
            flex-direction: column;
            text-align: center;
        }
        .logo-circle {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            overflow: hidden;
            border: 6px solid var(--light-orange);
            box-shadow: 0 8px 25px rgba(255,126,0,0.2);
        }
        .logo-circle img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .sidebar-title {
            font-family: 'Noto Sans Devanagari', sans-serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--orange);
            margin-top: 12px;
            white-space: nowrap;
            opacity: 1;
            transition: opacity 0.2s ease;
        }
        .sidebar.collapsed .sidebar-title {
            opacity: 0;
            visibility: hidden;
        }
        .sidebar-menu {
            padding: 20px 0;
            flex-grow: 1;
            overflow-y: auto;
        }
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 16px 25px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            margin: 4px 15px;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: var(--light-orange);
            color: white;
            transform: translateX(8px);
        }
        .sidebar-menu a span {
            margin-left: 16px;
            opacity: 1;
            transition: opacity 0.2s ease;
        }
        .sidebar.collapsed .sidebar-menu a span {
            opacity: 0;
            visibility: hidden;
        }
        .sidebar-menu a.logout {
            color: #ef4444;
            margin-top: auto;
            border-top: 1px solid var(--border);
            padding-top: 20px;
        }
        .sidebar-menu a.logout:hover {
            background: #fca5a5;
            color: white;
        }
        /* MAIN */
        .main-wrapper {
            margin-left: var(--sidebar-width);
            display: flex;
            flex-direction: column;
            height: 100vh;
            transition: margin-left 0.3s ease;
        }
        .main-wrapper.collapsed {
            margin-left: var(--sidebar-collapsed-width);
        }
        /* TOP NAV */
        .top-nav {
            background: var(--card-bg);
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 4px 15px var(--shadow);
            border-bottom: 1px solid var(--border);
        }
        .left-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .menu-toggle {
            background: transparent;
            border: 2px solid var(--orange);
            color: var(--orange);
            width: 48px;
            height: 48px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            transition: all 0.3s ease;
        }
        .menu-toggle:hover {
            background: var(--light-orange);
            color: white;
        }
        .page-title h1 {
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--text-main);
        }
        .right-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .theme-toggle {
            background: transparent;
            border: 2px solid var(--orange);
            color: var(--orange);
            width: 48px;
            height: 48px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            transition: all 0.3s ease;
        }
        .theme-toggle:hover {
            background: var(--light-orange);
            color: white;
        }
        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .user-info {
            text-align: right;
        }
        .user-name {
            font-weight: 600;
            font-size: 0.95rem;
            color: var(--text-main);
        }
        .user-role {
            font-size: 0.8rem;
            color: var(--text-muted);
        }
        .user-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--orange);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: white;
            font-size: 1.1rem;
        }
        /* CONTENT */
        .content-body {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
            background: linear-gradient(to bottom, #fff9f0, var(--bg));
        }
        .welcome-banner {
            background: linear-gradient(135deg, var(--light-orange), var(--orange));
            padding: 50px;
            border-radius: 20px;
            margin-bottom: 40px;
            box-shadow: 0 12px 30px rgba(255,126,0,0.2);
            color: white;
            position: relative;
            overflow: hidden;
        }
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at 30% 50%, rgba(255,255,255,0.2), transparent);
            animation: particleFloat 20s linear infinite;
        }
        @keyframes particleFloat {
            0% { transform: translate(0,0); }
            50% { transform: translate(40px, -40px); }
            100% { transform: translate(0,0); }
        }
        .welcome-banner h2 {
            font-size: 2.2rem;
            margin: 0;
            p { margin-top: 12px; font-size: 1.1rem; opacity: 0.9; }
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }
        .stat-card {
            background: var(--card-bg);
            padding: 32px;
            border-radius: 18px;
            box-shadow: 0 10px 25px var(--shadow);
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-10px);
        }
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 8px; height: 100%;
            background: var(--orange);
            border-radius: 8px 0 0 8px;
        }
        .stat-label {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .stat-value {
            font-size: 2.6rem;
            font-weight: 700;
            margin-top: 16px;
            color: var(--text-main);
        }
        .stat-footer {
            margin-top: 20px;
            font-size: 0.95rem;
            color: var(--orange);
            font-weight: 600;
        }
        @media (max-width: 1024px) {
            .sidebar { width: var(--sidebar-collapsed-width); }
            .sidebar .sidebar-title, .sidebar .sidebar-menu a span { opacity: 0; visibility: hidden; }
            .main-wrapper { margin-left: var(--sidebar-collapsed-width); }
        }
        @media (max-width: 768px) {
            .content-body { padding: 20px; }
            .stats-grid { grid-template-columns: 1fr; }
            .welcome-banner { padding: 35px; }
            .welcome-banner h2 { font-size: 1.8rem; }
            .top-nav { padding: 0 15px; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <!-- SIDEBAR -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="logo-circle">
                <img src="../img/logo.png" alt="Shri Ganesh Logo">
            </div>
            <div class="sidebar-title">श्री गणेश इंटरप्रायजेस</div>
        </div>
        <div class="sidebar-menu">
            <a href="Dashboard.aspx" class="active"><span>Dashboard</span></a>
            <a href="Customers.aspx"><span>Customers</span></a>
            <a href="Products.aspx"><span>Products</span></a>
            <a href="Purchase.aspx"><span>Purchases</span></a>
            <a href="Sales.aspx"><span>Sales</span></a>
            <a href="Stock.aspx"><span>Stock / Inventory</span></a>
            <a href="ClientManagement.aspx"><span>Client Management</span></a>
            <a href="Help.aspx"><span>Help Center</span></a>
            <a href="../Account/Login.aspx" class="logout"><span>Log Out</span></a>
        </div>
    </div>
    <!-- MAIN -->
    <div class="main-wrapper" id="mainWrapper">
        <nav class="top-nav">
            <div class="left-controls">
                <button type="button" class="menu-toggle" id="menuToggle" title="Toggle Sidebar">☰</button>
                <div class="page-title">
                    <h1>Dashboard Overview</h1>
                </div>
            </div>
            <div class="right-controls">
                <button type="button" class="theme-toggle" id="themeToggle" title="Toggle Theme">🌙</button>
                <div class="user-profile">
                    <div class="user-info">
                        <span class="user-name"><asp:Label ID="lblAdmin" runat="server" Text="System Admin"></asp:Label></span>
                        <span class="user-role">Warehouse Manager</span>
                    </div>
                    <div class="user-avatar">A</div>
                </div>
            </div>
        </nav>
        <div class="content-body">
            <div class="welcome-banner">
                <h2>Welcome Back, <asp:Label ID="lblWelcomeName" runat="server" Text="Admin" />!</h2>
                <p>Here is what's happening in श्री गणेश इंटरप्रायजेस today.</p>
            </div>
            <div class="stats-grid">
                <div class="stat-card">
                    <span class="stat-label">Total Customers</span>
                    <span class="stat-value"><asp:Label ID="lblCustomers" runat="server" Text="0" /></span>
                    <div class="stat-footer">Active records</div>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Stock Inventory</span>
                    <span class="stat-value"><asp:Label ID="lblProducts" runat="server" Text="0" /></span>
                    <div class="stat-footer">Items in catalog</div>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Procurement</span>
                    <span class="stat-value"><asp:Label ID="lblPurchases" runat="server" Text="0" /></span>
                    <div class="stat-footer">Total purchase orders</div>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Sales Bills</span>
                    <span class="stat-value"><asp:Label ID="lblSales" runat="server" Text="0" /></span>
                    <div class="stat-footer">Invoices generated</div>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Today's Revenue</span>
                    <span class="stat-value">₹ <asp:Label ID="lblTodaySales" runat="server" Text="0.00" /></span>
                    <div class="stat-footer">+12% from yesterday</div>
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    // Theme Toggle (Light ↔ Soft Orange-Dark)
    const themeToggle = document.getElementById('themeToggle');
    const body = document.body;
    if (localStorage.getItem('theme') === 'dark') {
        body.classList.add('dark-theme');
        themeToggle.textContent = '☀️';
    } else {
        themeToggle.textContent = '🌙';
    }
    themeToggle.addEventListener('click', () => {
        body.classList.toggle('dark-theme');
    if (body.classList.contains('dark-theme')) {
        themeToggle.textContent = '☀️';
        localStorage.setItem('theme', 'dark');
    } else {
        themeToggle.textContent = '🌙';
        localStorage.setItem('theme', 'light');
    }
    });
    // Sidebar Toggle
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');
    const mainWrapper = document.getElementById('mainWrapper');
    menuToggle.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
    mainWrapper.classList.toggle('collapsed');
    });
    // Auto-collapse on small screens
    window.addEventListener('resize', () => {
        if (window.innerWidth <= 1024) {
            sidebar.classList.add('collapsed');
    mainWrapper.classList.add('collapsed');
    }
    });
</script>
</body>
</html>