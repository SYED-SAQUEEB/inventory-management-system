using System;
using System.Data;

public partial class Admin_Stock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStock();
        }
    }

    private void LoadStock()
    {
        string query = @"
        SELECT 
            P.ProductID,
            P.ProductName,
            P.Unit,
            ISNULL(Purchased.TotalPurchased, 0) - ISNULL(Sold.TotalSold, 0) AS StockQty,
            Purchased.LastPurchaseDate AS LastUpdated
        FROM Products P
        LEFT JOIN (
            SELECT ProductID, 
                   SUM(Quantity) AS TotalPurchased,
                   MAX(PurchaseDate) AS LastPurchaseDate
            FROM Purchases 
            GROUP BY ProductID
        ) Purchased ON P.ProductID = Purchased.ProductID
        LEFT JOIN (
            SELECT ProductID, 
                   SUM(Quantity) AS TotalSold
            FROM SaleItems 
            GROUP BY ProductID
        ) Sold ON P.ProductID = Sold.ProductID
        ORDER BY P.ProductName";

        DataTable dt = DBHelper.ExecuteSelect(query);
        gvStock.DataSource = dt;
        gvStock.DataBind();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        LoadStock();
    }
}
