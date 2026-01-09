using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Admin_ClientAdd : System.Web.UI.Page
{
    // Connection string
    string cs = @"Data Source=VICTUS-PC\SQLEXPRESS;Initial Catalog=InventoryDB;Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtBalance.Text = "0.00";

            // If editing an existing client
            if (Request.QueryString["id"] != null)
            {
                int clientId;
                if (int.TryParse(Request.QueryString["id"], out clientId))
                {
                    LoadClientData(clientId);
                }
            }
        }
    }

    // ================= LOAD EXISTING CLIENT =================
    void LoadClientData(int clientId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT * FROM Client WHERE CustomerID = @ID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ID", clientId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtCompany.Text = dr["CompanyName"].ToString();
                    txtClient.Text = dr["ClientName"].ToString();
                    txtMaterial.Text = dr["RawMaterialName"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtMobile.Text = dr["MobileNo"].ToString();
                    txtTotal.Text = Convert.ToDecimal(dr["TotalAmount"]).ToString("0.00");
                    txtPaid.Text = Convert.ToDecimal(dr["PaidAmount"]).ToString("0.00");

                    decimal balance = Convert.ToDecimal(dr["TotalAmount"]) - Convert.ToDecimal(dr["PaidAmount"]);
                    txtBalance.Text = balance.ToString("0.00");
                }
                dr.Close();
            }
        }
    }

    // ================= SAVE / UPDATE CLIENT =================
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";

        // Validate required fields
        if (string.IsNullOrWhiteSpace(txtCompany.Text) ||
            string.IsNullOrWhiteSpace(txtClient.Text) ||
            string.IsNullOrWhiteSpace(txtMaterial.Text))
        {
            lblMessage.Text = "Company, Client, and Material are required.";
            return;
        }

        // Parse amounts safely
        decimal totalAmount;
        if (!decimal.TryParse(txtTotal.Text, out totalAmount))
        {
            lblMessage.Text = "Invalid Total Amount.";
            return;
        }

        decimal paidAmount;
        if (!decimal.TryParse(txtPaid.Text, out paidAmount))
        {
            lblMessage.Text = "Invalid Paid Amount.";
            return;
        }

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // Check if client exists
            string checkSql = "SELECT CustomerID, TotalAmount, PaidAmount FROM Client " +
                              "WHERE LOWER(CompanyName)=LOWER(@Company) AND LOWER(ClientName)=LOWER(@Client) AND LOWER(RawMaterialName)=LOWER(@Material)";

            using (SqlCommand checkCmd = new SqlCommand(checkSql, con))
            {
                checkCmd.Parameters.AddWithValue("@Company", txtCompany.Text.Trim());
                checkCmd.Parameters.AddWithValue("@Client", txtClient.Text.Trim());
                checkCmd.Parameters.AddWithValue("@Material", txtMaterial.Text.Trim());

                SqlDataReader reader = checkCmd.ExecuteReader();

                if (reader.HasRows)
                {
                    // Client exists → update PaidAmount
                    reader.Read();
                    int clientId = Convert.ToInt32(reader["CustomerID"]);
                    decimal existingTotal = Convert.ToDecimal(reader["TotalAmount"]);
                    decimal existingPaid = Convert.ToDecimal(reader["PaidAmount"]);
                    reader.Close();

                    decimal newPaid = existingPaid + paidAmount;
                    if (newPaid > existingTotal)
                    {
                        lblMessage.Text = "Total Paid Amount cannot exceed Total Amount.";
                        return;
                    }

                    decimal balance = existingTotal - newPaid;

                    string updateSql = "UPDATE Client SET PaidAmount=@Paid WHERE CustomerID=@ID";
                    using (SqlCommand updateCmd = new SqlCommand(updateSql, con))
                    {
                        updateCmd.Parameters.AddWithValue("@Paid", newPaid);
                        updateCmd.Parameters.AddWithValue("@ID", clientId);
                        updateCmd.ExecuteNonQuery();
                    }

                    txtBalance.Text = balance.ToString("0.00");
                    lblMessage.Text = "Payment updated successfully. Remaining Balance: ₹" + balance.ToString("0.00");
                }
                else
                {
                    reader.Close();

                    decimal balance = totalAmount - paidAmount;

                    string insertSql = "INSERT INTO Client (CompanyName, ClientName, RawMaterialName, City, MobileNo, TotalAmount, PaidAmount) " +
                                       "VALUES (@Company, @Client, @Material, @City, @Mobile, @Total, @Paid)";

                    using (SqlCommand insertCmd = new SqlCommand(insertSql, con))
                    {
                        insertCmd.Parameters.AddWithValue("@Company", txtCompany.Text.Trim());
                        insertCmd.Parameters.AddWithValue("@Client", txtClient.Text.Trim());
                        insertCmd.Parameters.AddWithValue("@Material", txtMaterial.Text.Trim());
                        insertCmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                        insertCmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                        insertCmd.Parameters.AddWithValue("@Total", totalAmount);
                        insertCmd.Parameters.AddWithValue("@Paid", paidAmount);

                        insertCmd.ExecuteNonQuery();
                    }

                    txtBalance.Text = balance.ToString("0.00");
                    lblMessage.Text = "New client added successfully.";
                }

                // Show SweetAlert
                string safeMsg = lblMessage.Text.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "showSuccessAlert('" + safeMsg + "');", true);
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClientManagement.aspx");
    }
}
