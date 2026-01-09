using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Products : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadProducts();
    }

    private void LoadProducts()
    {
        DataTable dt = DBHelper.ExecuteSelect("SELECT ProductID, ProductName, Unit, CreatedDate FROM Products ORDER BY ProductName");
        gvProducts.DataSource = dt;
        gvProducts.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtProductName.Text))
        {
            lblMsg.Text = "Product Name is required";
            lblMsg.CssClass = "message message-error";
            return;
        }

        if (string.IsNullOrEmpty(hfProductID.Value))
        {
            // Insert new product
            DBHelper.ExecuteNonQuery(
                "INSERT INTO Products (ProductName, Unit) VALUES (@P, @U)",
                new SqlParameter("@P", txtProductName.Text.Trim()),
                new SqlParameter("@U", txtUnit.Text.Trim())
            );
            lblMsg.Text = "Product Added Successfully";
            lblMsg.CssClass = "message message-success";
        }
        else
        {
            // Update existing product
            DBHelper.ExecuteNonQuery(
                "UPDATE Products SET ProductName=@P, Unit=@U WHERE ProductID=@ID",
                new SqlParameter("@P", txtProductName.Text.Trim()),
                new SqlParameter("@U", txtUnit.Text.Trim()),
                new SqlParameter("@ID", hfProductID.Value)
            );
            lblMsg.Text = "Product Updated Successfully";
            lblMsg.CssClass = "message message-success";
        }

        ClearForm();
        LoadProducts();
    }

    protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        int id = Convert.ToInt32(gvProducts.DataKeys[index].Value);

        if (e.CommandName == "EditRow")
        {
            DataTable dt = DBHelper.ExecuteSelect(
                "SELECT ProductID, ProductName, Unit FROM Products WHERE ProductID=@ID",
                new SqlParameter("@ID", id)
            );

            if (dt.Rows.Count > 0)
            {
                hfProductID.Value = dt.Rows[0]["ProductID"].ToString();
                txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                txtUnit.Text = dt.Rows[0]["Unit"].ToString();
                btnSave.Text = "Update";
            }
        }

        if (e.CommandName == "DeleteRow")
        {
            DBHelper.ExecuteNonQuery(
                "DELETE FROM Products WHERE ProductID=@ID",
                new SqlParameter("@ID", id)
            );
            LoadProducts();
        }
    }

    private void ClearForm()
    {
        hfProductID.Value = "";
        txtProductName.Text = "";
        txtUnit.Text = "";
        btnSave.Text = "Save";
    }
}
