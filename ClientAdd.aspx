<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientAdd.aspx.cs" Inherits="Admin_ClientAdd" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>नया क्लाइंट जोड़ें | श्री गणेश इंटरप्रायजेस</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Noto+Sans+Devanagari:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100%;
            background: var(--white);
            overflow-y: auto;
            transition: width 0.3s ease;
            z-index: 100;
            border-right: 1px solid var(--border);
            box-shadow: 4px 0 20px var(--shadow);
        }
        .sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }
        .sidebar-header {
            text-align: center;
            padding: 30px 20px;
            border-bottom: 1px solid var(--border);
        }
        .logo-circle {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 16px;
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
            opacity: 1;
            transition: opacity 0.2s ease;
        }
        .sidebar.collapsed .sidebar-title {
            opacity: 0;
            visibility: hidden;
        }
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 16px 25px;
            color: var(--text-muted);
            transition: all 0.3s ease;
            margin: 4px 15px;
            border-radius: 12px;
        }
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: var(--light-orange);
            color: white;
        }
        .sidebar-menu a i {
            margin-right: 16px;
            font-size: 1.1rem;
            width: 24px;
            text-align: center;
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
        /* MAIN WRAPPER */
        .main-wrapper {
            margin-left: var(--sidebar-width);
            transition: margin-left 0.3s ease;
            height: 100vh;
            overflow: auto;
        }
        .main-wrapper.collapsed {
            margin-left: var(--sidebar-collapsed-width);
        }
        /* TOP NAV */
        .top-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 30px;
            height: 70px;
            background: var(--card-bg);
            box-shadow: 0 4px 15px var(--shadow);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 99;
        }
        .left-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .icon-btn {
            background: none;
            border: none;
            color: var(--orange);
            font-size: 1.4rem;
            cursor: pointer;
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        .icon-btn:hover {
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
        .user-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--orange);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.1rem;
        }
        /* CONTENT */
        .content-body {
            padding: 40px;
            background: linear-gradient(to bottom, #fff9f0, var(--bg));
        }
        .form-card {
            background: var(--card-bg);
            padding: 50px;
            border-radius: 24px;
            box-shadow: 0 12px 40px var(--shadow);
            max-width: 900px;
            margin: 0 auto;
        }
        .form-card h2 {
            font-size: 1.8rem;
            color: var(--orange);
            margin-bottom: 40px;
            text-align: center;
            font-weight: 700;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 28px;
        }
        .form-group label {
            display: block;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 10px;
        }
        .input-field {
            width: 100%;
            padding: 16px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 16px;
            font-size: 1rem;
            background: var(--white);
            color: var(--text-main);
            transition: all 0.3s ease;
        }
        .input-field:focus {
            outline: none;
            border-color: var(--orange);
            box-shadow: 0 0 0 4px rgba(255,126,0,0.15);
        }
        .readonly-input {
            background: #fff4e6;
            border-color: var(--light-orange);
            color: var(--deep-orange);
            font-weight: 600;
        }
        .btn-group {
            grid-column: 1 / -1;
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
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
        .btn-primary {
            background: var(--light-orange);
            color: white;
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
            background: #94a3b8;
            color: white;
        }
        .btn-secondary:hover {
            background: #64748b;
        }
        @media (max-width: 768px) {
            .content-body { padding: 20px; }
            .form-card { padding: 30px; }
            .form-grid { grid-template-columns: 1fr; }
            .btn-group { flex-direction: column; }
            .btn { width: 100%; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="logo-circle">
                <img src="../img/logo.png" alt="Shri Ganesh Logo" onerror="this.src='https://via.placeholder.com/100?text=SG'">
            </div>
            <div class="sidebar-title">श्री गणेश इंटरप्रायजेस</div>
        </div>
        <div class="sidebar-menu">
            <a href="Dashboard.aspx"><i class="fas fa-th-large"></i> <span>Dashboard</span></a>
            <a href="Customers.aspx"><i class="fas fa-users"></i> <span>Customers</span></a>
            <a href="Products.aspx"><i class="fas fa-box"></i> <span>Products</span></a>
            <a href="Purchase.aspx"><i class="fas fa-shopping-cart"></i> <span>Purchases</span></a>
            <a href="Sales.aspx"><i class="fas fa-chart-line"></i> <span>Sales</span></a>
            <a href="Stock.aspx"><i class="fas fa-warehouse"></i> <span>Stock / Inventory</span></a>
            <a href="ClientManagement.aspx" class="active"><i class="fas fa-address-book"></i> <span>Client Management</span></a>
            <a href="Help.aspx"><i class="fas fa-question-circle"></i> <span>Help</span></a>
            <a href="../Account/Login.aspx" class="logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a>
        </div>
    </nav>
    <!-- Main -->
    <div class="main-wrapper" id="mainWrapper">
        <nav class="top-nav">
            <div class="left-controls">
                <button type="button" class="icon-btn" id="menuToggle"><i class="fas fa-bars"></i></button>
                <div class="page-title"><h1>Add New Client</h1></div>
            </div>
            <div class="right-controls">
                <button type="button" class="icon-btn" id="themeToggle"><i class="fas fa-sun" id="themeIcon"></i></button>
                <div class="user-avatar">A</div>
            </div>
        </nav>
        <div class="content-body">
            <div class="form-card">
                <h2>Client Details</h2>
                <asp:Label ID="lblMessage" runat="server" ForeColor="#dc2626" style="display:block; text-align:center; font-weight:600; margin-bottom:20px;" />
                <div class="form-grid">
                    <div class="form-group full-width">
                        <label for="txtCompany">Company Name</label>
                        <asp:TextBox ID="txtCompany" runat="server" CssClass="input-field" placeholder="Enter company name" />
                    </div>
                    <div class="form-group">
                        <label for="txtClient">Contact Person</label>
                        <asp:TextBox ID="txtClient" runat="server" CssClass="input-field" placeholder="Enter contact person name" />
                    </div>
                    <div class="form-group">
                        <label for="txtMobile">Mobile Number</label>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="input-field" placeholder="+91 _________" />
                    </div>
                    <div class="form-group">
                        <label for="txtMaterial">Raw Material Type</label>
                        <asp:TextBox ID="txtMaterial" runat="server" CssClass="input-field" placeholder="e.g. Steel, Plastic" />
                    </div>
                    <div class="form-group">
                        <label for="txtCity">City / Location</label>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="input-field" placeholder="Enter city" />
                    </div>
                    <div class="form-group">
                        <label for="txtTotal">Total Amount (₹)</label>
                        <asp:TextBox ID="txtTotal" runat="server" CssClass="input-field" placeholder="0.00" />
                    </div>
                    <div class="form-group">
                        <label for="txtPaid">Paid Amount (₹)</label>
                        <asp:TextBox ID="txtPaid" runat="server" CssClass="input-field" placeholder="0.00" />
                    </div>
                    <div class="form-group">
                        <label for="txtBalance">Balance Amount (₹)</label>
                        <asp:TextBox ID="txtBalance" runat="server" CssClass="input-field readonly-input" ReadOnly="true" />
                    </div>
                    <div class="btn-group">
                        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click">
                            <i class="fas fa-save"></i> Save Client
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-secondary" OnClick="btnBack_Click">
                            <i class="fas fa-arrow-left"></i> Cancel
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    // Theme Toggle
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = document.getElementById('themeIcon');
    const body = document.body;
    const currentTheme = localStorage.getItem('theme');
    if (currentTheme === 'dark') {
        body.classList.add('dark-theme');
        themeIcon.classList.replace('fa-sun', 'fa-moon');
    } else {
        themeIcon.classList.replace('fa-moon', 'fa-sun');
    }
    themeToggle.addEventListener('click', () => {
        body.classList.toggle('dark-theme');
    const isDark = body.classList.contains('dark-theme');
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
    themeIcon.classList.toggle('fa-sun');
    themeIcon.classList.toggle('fa-moon');
    });
    // Sidebar Toggle
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');
    const mainWrapper = document.getElementById('mainWrapper');
    menuToggle.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
    mainWrapper.classList.toggle('collapsed');
    });
    // Balance Calculation
    const txtTotal = document.getElementById('<%= txtTotal.ClientID %>');
        const txtPaid = document.getElementById('<%= txtPaid.ClientID %>');
    const txtBalance = document.getElementById('<%= txtBalance.ClientID %>');
    function updateBalance() {
        const total = parseFloat(txtTotal.value) || 0;
        const paid = parseFloat(txtPaid.value) || 0;
        txtBalance.value = (total - paid).toFixed(2);
    }
    txtTotal.addEventListener('input', updateBalance);
    txtPaid.addEventListener('input', updateBalance);
    // SweetAlert (if needed from code-behind)
    function showSuccessAlert(message) {
        Swal.fire({
            title: 'Success!',
            text: message,
            icon: 'success',
            confirmButtonColor: '#ff7e00',
            timer: 3000,
            timerProgressBar: true
        });
    }
</script>
</body>
</html>