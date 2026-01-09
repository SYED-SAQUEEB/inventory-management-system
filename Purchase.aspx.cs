using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Purchase : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadProducts();
            LoadPurchases();
        }
    }

    private void LoadProducts()
    {
        DataTable dt = DBHelper.ExecuteSelect("SELECT ProductID, ProductName FROM Products ORDER BY ProductName");
        ddlProducts.DataSource = dt;
        ddlProducts.DataTextField = "ProductName";
        ddlProducts.DataValueField = "ProductID";
        ddlProducts.DataBind();
        ddlProducts.Items.Insert(0, new ListItem("--Select Product--", "0"));
    }

    private void LoadPurchases()
    {
        DataTable dt = DBHelper.ExecuteSelect(@"
            SELECT p.PurchaseID, pr.ProductName, p.Quantity, p.Rate, 
                   (p.Quantity * p.Rate) AS Total, p.PurchaseDate
            FROM Purchases p
            INNER JOIN Products pr ON p.ProductID = pr.ProductID
            ORDER BY p.PurchaseDate DESC
        ");
        gvPurchases.DataSource = dt;
        gvPurchases.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        int productId = int.Parse(ddlProducts.SelectedValue);
        decimal quantity = 0, rate = 0;
        DateTime purchaseDate;

        decimal.TryParse(txtQuantity.Text.Trim(), out quantity);
        decimal.TryParse(txtRate.Text.Trim(), out rate);
        DateTime.TryParse(txtPurchaseDate.Text.Trim(), out purchaseDate);

        if (productId == 0)
        {
            lblMsg.Text = "Please select a product.";
            lblMsg.CssClass = "message message-error";
            return;
        }

        if (string.IsNullOrEmpty(hfPurchaseID.Value))
        {
            // Insert
            DBHelper.ExecuteNonQuery(
                "INSERT INTO Purchases (ProductID, Quantity, Rate, PurchaseDate) VALUES (@P, @Q, @R, @D)",
                new SqlParameter("@P", productId),
                new SqlParameter("@Q", quantity),
                new SqlParameter("@R", rate),
                new SqlParameter("@D", purchaseDate)
            );
            lblMsg.Text = "Purchase added successfully.";
            lblMsg.CssClass = "message message-success";
        }
        else
        {
            // Update
            DBHelper.ExecuteNonQuery(
                "UPDATE Purchases SET ProductID=@P, Quantity=@Q, Rate=@R, PurchaseDate=@D WHERE PurchaseID=@ID",
                new SqlParameter("@P", productId),
                new SqlParameter("@Q", quantity),
                new SqlParameter("@R", rate),
                new SqlParameter("@D", purchaseDate),
                new SqlParameter("@ID", hfPurchaseID.Value)
            );
            lblMsg.Text = "Purchase updated successfully.";
            lblMsg.CssClass = "message message-success";
        }

        ClearForm();
        LoadPurchases();
    }

    protected void gvPurchases_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        int id = Convert.ToInt32(gvPurchases.DataKeys[index].Value);

        if (e.CommandName == "EditRow")
        {
            DataTable dt = DBHelper.ExecuteSelect(
                "SELECT * FROM Purchases WHERE PurchaseID=@ID",
                new SqlParameter("@ID", id)
            );

            if (dt.Rows.Count > 0)
            {
                hfPurchaseID.Value = dt.Rows[0]["PurchaseID"].ToString();
                ddlProducts.SelectedValue = dt.Rows[0]["ProductID"].ToString();
                txtQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                txtRate.Text = dt.Rows[0]["Rate"].ToString();
                txtPurchaseDate.Text = Convert.ToDateTime(dt.Rows[0]["PurchaseDate"]).ToString("yyyy-MM-dd");
                btnSave.Text = "Update";
            }
        }

        if (e.CommandName == "DeleteRow")
        {
            DBHelper.ExecuteNonQuery(
                "DELETE FROM Purchases WHERE PurchaseID=@ID",
                new SqlParameter("@ID", id)
            );
            LoadPurchases();
        }
    }

    private void ClearForm()
    {
        hfPurchaseID.Value = "";
        ddlProducts.SelectedIndex = 0;
        txtQuantity.Text = "";
        txtRate.Text = "";
        txtPurchaseDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        btnSave.Text = "Save";
    }
}
