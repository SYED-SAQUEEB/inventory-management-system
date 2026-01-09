using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data;

public partial class Admin_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin"] == null)
        {
            Response.Redirect("~/Account/Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadDashboard();
        }
    }

    private void LoadDashboard()
    {
        lblAdmin.Text = "Welcome, " + Session["Admin"].ToString();

        lblCustomers.Text = GetCount("Customers");
        lblProducts.Text = GetCount("Products");
        lblPurchases.Text = GetCount("Purchases");
        lblSales.Text = GetCount("Sales");

        DataTable dtTodaySales = DBHelper.ExecuteSelect(
            "SELECT ISNULL(SUM(BillAmount),0) AS Total " +
            "FROM Sales WHERE SaleDate = CAST(GETDATE() AS DATE)"
        );

        lblTodaySales.Text = dtTodaySales.Rows[0]["Total"].ToString();
    }

    private string GetCount(string tableName)
    {
        DataTable dt =
            DBHelper.ExecuteSelect("SELECT COUNT(*) AS Total FROM " + tableName);
        return dt.Rows[0]["Total"].ToString();
    }
}
