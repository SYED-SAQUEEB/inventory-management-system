using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Sales : System.Web.UI.Page
{
    DataTable ItemTable
    {
        get
        {
            if (ViewState["Items"] == null)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ProductID");
                dt.Columns.Add("ProductName");
                dt.Columns.Add("Quantity", typeof(decimal));
                dt.Columns.Add("Rate", typeof(decimal));
                dt.Columns.Add("Total", typeof(decimal));
                ViewState["Items"] = dt;
            }
            return (DataTable)ViewState["Items"];
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadProducts();
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }

    void LoadProducts()
    {
        DataTable dt = DBHelper.ExecuteSelect("SELECT ProductID, ProductName FROM Products");
        ddlProducts.DataSource = dt;
        ddlProducts.DataTextField = "ProductName";
        ddlProducts.DataValueField = "ProductID";
        ddlProducts.DataBind();
    }

    protected void btnAddItem_Click(object sender, EventArgs e)
    {
        decimal qty = decimal.Parse(txtQty.Text);
        decimal rate = decimal.Parse(txtRate.Text);
        decimal total = qty * rate;

        ItemTable.Rows.Add(
            ddlProducts.SelectedValue,
            ddlProducts.SelectedItem.Text,
            qty,
            rate,
            total
        );

        gvItems.DataSource = ItemTable;
        gvItems.DataBind();

        CalculateBill();
        txtQty.Text = txtRate.Text = "";
    }

    void CalculateBill()
    {
        decimal bill = 0;
        foreach (DataRow r in ItemTable.Rows)
            bill += Convert.ToDecimal(r["Total"]);

        txtBill.Text = bill.ToString("0.00");

        decimal paid = 0;
        decimal.TryParse(txtPaid.Text, out paid);
        txtBalance.Text = (bill - paid).ToString("0.00");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlParameter[] saleParams =
        {
            new SqlParameter("@D", txtDate.Text),
            new SqlParameter("@PN", txtCustomer.Text),
            new SqlParameter("@C", txtCity.Text),
            new SqlParameter("@M", txtMobile.Text),
            new SqlParameter("@B", txtBill.Text),
            new SqlParameter("@P", txtPaid.Text)
        };

        int saleId = DBHelper.ExecuteScalarInt(
            @"INSERT INTO Sales (SaleDate, PartyName, City, MobileNo, BillAmount, CashPaid)
              VALUES (@D,@PN,@C,@M,@B,@P);
              SELECT SCOPE_IDENTITY();",
            saleParams
        );

        foreach (DataRow r in ItemTable.Rows)
        {
            DBHelper.ExecuteNonQuery(
                @"INSERT INTO SaleItems (SaleID, ProductID, Quantity, Rate, Total)
                  VALUES (@S,@P,@Q,@R,@T)",
                new SqlParameter("@S", saleId),
                new SqlParameter("@P", r["ProductID"]),
                new SqlParameter("@Q", r["Quantity"]),
                new SqlParameter("@R", r["Rate"]),
                new SqlParameter("@T", r["Total"])
            );
        }

        lblMsg.Text = "Sale saved successfully!";
        ViewState["Items"] = null;
        gvItems.DataSource = null;
        gvItems.DataBind();
    }
}
