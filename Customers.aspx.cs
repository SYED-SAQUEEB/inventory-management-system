using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Customers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadCustomers();
    }

    private void LoadCustomers()
    {
        DataTable dt = DBHelper.ExecuteSelect("SELECT * FROM Customers ORDER BY PartyName");
        gvCustomers.DataSource = dt;
        gvCustomers.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(hfCustomerID.Value))
        {
            DBHelper.ExecuteNonQuery(
                "INSERT INTO Customers (PartyName, City, MobileNo) VALUES (@P, @C, @M)",
                new SqlParameter("@P", txtPartyName.Text),
                new SqlParameter("@C", txtCity.Text),
                new SqlParameter("@M", txtMobile.Text)
            );
            lblMsg.Text = "Customer Added Successfully";
        }
        else
        {
            DBHelper.ExecuteNonQuery(
                "UPDATE Customers SET PartyName=@P, City=@C, MobileNo=@M WHERE CustomerID=@ID",
                new SqlParameter("@P", txtPartyName.Text),
                new SqlParameter("@C", txtCity.Text),
                new SqlParameter("@M", txtMobile.Text),
                new SqlParameter("@ID", hfCustomerID.Value)
            );
            lblMsg.Text = "Customer Updated Successfully";
        }

        ClearForm();
        LoadCustomers();
    }

    protected void gvCustomers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        int id = Convert.ToInt32(gvCustomers.DataKeys[index].Value);

        if (e.CommandName == "EditRow")
        {
            DataTable dt = DBHelper.ExecuteSelect(
                "SELECT * FROM Customers WHERE CustomerID=@ID",
                new SqlParameter("@ID", id)
            );

            hfCustomerID.Value = id.ToString();
            txtPartyName.Text = dt.Rows[0]["PartyName"].ToString();
            txtCity.Text = dt.Rows[0]["City"].ToString();
            txtMobile.Text = dt.Rows[0]["MobileNo"].ToString();
            btnSave.Text = "Update";
        }

        if (e.CommandName == "DeleteRow")
        {
            DBHelper.ExecuteNonQuery(
                "DELETE FROM Customers WHERE CustomerID=@ID",
                new SqlParameter("@ID", id)
            );
            LoadCustomers();
        }
    }

    private void ClearForm()
    {
        hfCustomerID.Value = "";
        txtPartyName.Text = "";
        txtCity.Text = "";
        txtMobile.Text = "";
        btnSave.Text = "Save";
    }
}
