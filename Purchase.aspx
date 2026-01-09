<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Purchase.aspx.cs" Inherits="Admin_Purchase" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>खरीद प्रबंधन | श्री गणेश इंटरप्रायजेस - Warehouse IMS</title>
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
        /* CONTENT */
        .content-body {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
            background: linear-gradient(to bottom, #fff9f0, var(--bg));
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }
        .page-header {
            margin-bottom: 40px;
            text-align: center;
        }
        .page-header h1 {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--orange);
        }
        .page-header p {
            color: var(--text-muted);
            font-size: 1.1rem;
            margin-top: 10px;
        }
        .form-container {
            background: var(--card-bg);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 12px 30px var(--shadow);
            border: 1px solid var(--border);
            margin-bottom: 40px;
        }
        .form-container h3 {
            font-size: 1.6rem;
            color: var(--orange);
            margin-bottom: 30px;
            padding-bottom: 12px;
            border-bottom: 3px solid var(--light-orange);
            font-weight: 700;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 28px;
            margin-bottom: 35px;
        }
        .form-group label {
            display: block;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 10px;
        }
        .input-field, .select-field {
            width: 100%;
            padding: 16px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 16px;
            font-size: 1rem;
            background: var(--white);
            color: var(--text-main);
            transition: all 0.3s ease;
        }
        .input-field:focus, .select-field:focus {
            outline: none;
            border-color: var(--orange);
            box-shadow: 0 0 0 4px rgba(255,126,0,0.15);
        }
        .form-actions {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
        }
        .btn-save {
            background: var(--light-orange);
            color: white;
            padding: 16px 40px;
            border: none;
            border-radius: 16px;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: background 0.3s ease;
        }
        .btn-save:hover {
            background: #ffa133;
        }
        .btn-save::before {
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
        .btn-save:hover::before {
            left: 120%;
        }
        .message {
            font-weight: 600;
            color: var(--orange);
            font-size: 1rem;
        }
        .grid-container {
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
            min-width: 800px;
        }
        .modern-grid th {
            background: linear-gradient(135deg, var(--light-orange), var(--orange));
            color: white;
            text-align: left;
            padding: 20px 24px;
            font-size: 0.95rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .modern-grid td {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            color: var(--text-main);
        }
        .modern-grid tr:hover {
            background-color: rgba(255,126,0,0.05);
        }
        .action-btn {
            padding: 10px 20px;
            border-radius: 12px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            margin-right: 12px;
            transition: all 0.3s ease;
        }
        .btn-edit {
            background: #3b82f6;
            color: white;
        }
        .btn-edit:hover {
            background: #2563eb;
            transform: translateY(-2px);
        }
        .btn-delete {
            background: #ef4444;
            color: white;
        }
        .btn-delete:hover {
            background: #dc2626;
            transform: translateY(-2px);
        }
        @media (max-width: 1024px) {
            .sidebar { width: var(--sidebar-collapsed-width); }
            .sidebar .sidebar-title, .sidebar .sidebar-menu a span { opacity: 0; visibility: hidden; }
            .main-wrapper { margin-left: var(--sidebar-collapsed-width); }
        }
        @media (max-width: 768px) {
            .content-body { padding: 20px; }
            .form-grid { grid-template-columns: 1fr; }
            .form-container { padding: 30px; }
            .page-header h1 { font-size: 1.8rem; }
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
            <a href="Purchase.aspx" class="active"><span>Purchases</span></a>
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
                    <h1>Procurement Management</h1>
                </div>
            </div>
            <div class="right-controls">
                <button type="button" class="theme-toggle" id="themeToggle" title="Toggle Theme">🌙</button>
            </div>
        </nav>
        <div class="content-body">
            <div class="page-header">
                <h1>New Purchase Entry</h1>
                <p>Record incoming inventory from suppliers and update stock levels.</p>
            </div>
            <!-- Purchase Form -->
            <div class="form-container">
                <h3>Log Purchase</h3>
                <asp:HiddenField ID="hfPurchaseID" runat="server" />
                <div class="form-grid">
                    <div class="form-group">
                        <label>Select Product</label>
                        <asp:DropDownList ID="ddlProducts" runat="server" CssClass="select-field" />
                    </div>
                    <div class="form-group">
                        <label>Quantity</label>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="input-field" placeholder="0.00" />
                    </div>
                    <div class="form-group">
                        <label>Rate (per unit)</label>
                        <asp:TextBox ID="txtRate" runat="server" CssClass="input-field" placeholder="₹ 0.00" />
                    </div>
                    <div class="form-group">
                        <label>Purchase Date</label>
                        <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="input-field" TextMode="Date" />
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="btnSave" runat="server" Text="Log Purchase" CssClass="btn-save" OnClick="btnSave_Click" />
                    <asp:Label ID="lblMsg" runat="server" CssClass="message" />
                </div>
            </div>
            <!-- Purchase History Table -->
            <div class="grid-container">
                <asp:GridView ID="gvPurchases" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="PurchaseID"
                    OnRowCommand="gvPurchases_RowCommand"
                    CssClass="modern-grid"
                    GridLines="None"
                    EmptyDataText="No purchase records found.">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Product" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" DataFormatString="{0:N2}" />
                        <asp:BoundField DataField="Rate" HeaderText="Rate" DataFormatString="₹ {0:N2}" />
                        <asp:BoundField DataField="Total" HeaderText="Total Amount" DataFormatString="₹ {0:N2}" />
                        <asp:BoundField DataField="PurchaseDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button runat="server" Text="Edit" CommandName="EditRow"
                                    CommandArgument='<%# Container.DataItemIndex %>' CssClass="action-btn btn-edit" />
                                <asp:Button runat="server" Text="Delete" CommandName="DeleteRow"
                                    CommandArgument='<%# Container.DataItemIndex %>' CssClass="action-btn btn-delete"
                                    OnClientClick="return confirm('Delete this purchase record?');" />
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