<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientManagement.aspx.cs" Inherits="Admin_ClientManagement" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>क्लाइंट प्रबंधन | श्री गणेश इंटरप्रायजेस</title>
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
            --paid-bg: #059669;
            --balance-bg: #dc2626;
        }
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
        .page-header {
            margin-bottom: 40px;
            text-align: center;
        }
        .page-header h2 {
            font-size: 2.4rem;
            font-weight: 700;
            color: var(--orange);
        }
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 28px;
            margin-bottom: 40px;
        }
        .stat-card {
            background: var(--card-bg);
            padding: 32px;
            border-radius: 20px;
            box-shadow: 0 12px 30px var(--shadow);
            border: 1px solid var(--border);
            text-align: center;
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-10px);
        }
        .stat-icon {
            font-size: 2.8rem;
            margin-bottom: 16px;
        }
        .stat-label {
            font-size: 0.95rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }
        .stat-value {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--text-main);
            margin-top: 8px;
        }
        .toolbar {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 40px;
            padding: 24px;
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: 0 8px 20px var(--shadow);
            align-items: center;
        }
        .toolbar input, .toolbar select {
            padding: 16px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 16px;
            font-size: 1rem;
            min-width: 280px;
            background: var(--white);
            transition: all 0.3s ease;
        }
        .toolbar input:focus, .toolbar select:focus {
            border-color: var(--orange);
            box-shadow: 0 0 0 4px rgba(255,126,0,0.15);
            outline: none;
        }
        .toolbar input::placeholder {
            color: var(--text-muted);
        }
        .btn {
            padding: 16px 32px;
            border: none;
            border-radius: 16px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: var(--light-orange);
            color: white;
            position: relative;
            overflow: hidden;
        }
        .btn-primary:hover {
            background: #ffa133;
        }
        .btn-primary::before {
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
        .btn-primary:hover::before {
            left: 120%;
        }
        .btn-secondary {
            background: #f1f5f9;
            color: var(--text-main);
            border: 2px solid var(--border);
        }
        .btn-secondary:hover {
            background: var(--border);
        }
        .table-container {
            background: var(--card-bg);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 12px 30px var(--shadow);
            border: 1px solid var(--border);
            overflow-x: auto;
        }
        .modern-grid {
            width: 100%;
            border-collapse: collapse;
        }
        .modern-grid th {
            background: linear-gradient(135deg, var(--light-orange), var(--orange));
            color: white;
            padding: 20px 24px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }
        .modern-grid td {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            color: var(--text-main);
        }
        .modern-grid tr:hover {
            background-color: rgba(255,126,0,0.05);
        }
        .status-paid {
            background: var(--paid-bg);
            color: white;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 700;
        }
        .status-balance {
            background: var(--balance-bg);
            color: white;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 700;
        }
        .actions {
            display: flex;
            gap: 16px;
        }
        .actions a {
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .actions a:first-child {
            background: #3b82f6;
            color: white;
        }
        .actions a:first-child:hover {
            background: #2563eb;
        }
        .actions a.delete {
            background: #ef4444;
            color: white;
        }
        .actions a.delete:hover {
            background: #dc2626;
        }
        @media (max-width: 1024px) {
            .sidebar { width: var(--sidebar-collapsed-width); }
            .sidebar .sidebar-title, .sidebar .sidebar-menu a span { opacity: 0; visibility: hidden; }
            .main-wrapper { margin-left: var(--sidebar-collapsed-width); }
        }
        @media (max-width: 768px) {
            .content-body { padding: 20px; }
            .stats-row { grid-template-columns: 1fr; }
            .toolbar { flex-direction: column; }
            .toolbar input, .toolbar select, .toolbar button { min-width: 100%; }
            .page-header h2 { font-size: 1.8rem; }
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
            <a href="Dashboard.aspx"><span>Dashboard</span></a>
            <a href="Customers.aspx"><span>Customers</span></a>
            <a href="Products.aspx"><span>Products</span></a>
            <a href="Purchase.aspx"><span>Purchases</span></a>
            <a href="Sales.aspx"><span>Sales</span></a>
            <a href="Stock.aspx"><span>Stock / Inventory</span></a>
            <a href="ClientManagement.aspx" class="active"><span>Client Management</span></a>
            <a href="Help.aspx"><span>Help Center</span></a>
            <a href="../Account/Login.aspx" class="logout"><span>Log Out</span></a>
        </div>
    </div>
    <!-- MAIN -->
    <div class="main-wrapper" id="mainWrapper">
        <nav class="top-nav">
            <div class="left-controls">
                <button type="button" class="menu-toggle" id="menuToggle">☰</button>
                <div class="page-title">
                    <h1>Client Management</h1>
                </div>
            </div>
            <div class="right-controls">
                <button type="button" class="theme-toggle" id="themeToggle">🌙</button>
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
            <div class="page-header">
                <h2>Client Management</h2>
            </div>
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <div class="stat-label">Total Clients</div>
                    <div class="stat-value">127</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✅</div>
                    <div class="stat-label">Paid Amount</div>
                    <div class="stat-value">₹12.5L</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⚠️</div>
                    <div class="stat-label">Balance Due</div>
                    <div class="stat-value">₹3.8L</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">💰</div>
                    <div class="stat-label">Total Amount</div>
                    <div class="stat-value">₹16.3L</div>
                </div>
            </div>
            <div class="toolbar">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="input-field" placeholder="🔍 Search by client or company name" />
                <asp:DropDownList ID="ddlSort" runat="server" CssClass="select-field">
                    <asp:ListItem Value="" Text="📊 Sort By" />
                    <asp:ListItem Value="Paid" Text="Highest Paid First" />
                    <asp:ListItem Value="Balance" Text="Highest Balance First" />
                    <asp:ListItem Value="AZ" Text="Name A → Z" />
                    <asp:ListItem Value="ZA" Text="Name Z → A" />
                </asp:DropDownList>
                <asp:Button ID="btnSearch" runat="server" Text="Apply Filters" CssClass="btn btn-secondary" OnClick="btnSearch_Click" />
                <asp:Button ID="btnAdd" runat="server" Text="➕ Add New Client" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
            </div>
            <div class="table-container">
                <asp:GridView ID="gvClients" runat="server" AutoGenerateColumns="False" CssClass="modern-grid" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" />
                        <asp:BoundField DataField="RawMaterialName" HeaderText="Raw Material" />
                        <asp:BoundField DataField="City" HeaderText="City" />
                        <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="₹ {0:N2}" HtmlEncode="false" />
                        <asp:TemplateField HeaderText="Paid Amount">
                            <ItemTemplate>
                                <span class="status-paid">₹ <%# Eval("PaidAmount", "{0:N2}") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Balance Amount">
                            <ItemTemplate>
                                <span class="status-balance">₹ <%# Eval("BalanceAmount", "{0:N2}") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="actions">
                                    <a href='ClientAdd.aspx?edit=<%# Eval("ClientID") %>'>✏️ Edit</a>
                                    <a href='ClientManagement.aspx?del=<%# Eval("ClientID") %>' class="delete" onclick="return confirm('Are you sure?');">🗑️ Delete</a>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</form>
<script>
    // Theme Toggle
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
    // Sidebar Collapse
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