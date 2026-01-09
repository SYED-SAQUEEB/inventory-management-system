using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_ClientManagement : System.Web.UI.Page
{
    string cs = @"Data Source=VICTUS-PC\SQLEXPRESS;Initial Catalog=InventoryDB;Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // DELETE CLIENT
            if (Request.QueryString["del"] != null)
            {
                int id;
                if (int.TryParse(Request.QueryString["del"], out id))
                {
                    DeleteClient(id);
                    Response.Redirect("ClientManagement.aspx");
                    return;
                }
            }

            // EDIT CLIENT
            if (Request.QueryString["edit"] != null)
            {
                int id;
                if (int.TryParse(Request.QueryString["edit"], out id))
                {
                    Response.Redirect("ClientAdd.aspx?id=" + id);
                    return;
                }
            }

            LoadClients();
            InjectStats();
        }
    }

    // ================= LOAD CLIENT LIST =================
    void LoadClients(string orderBy = "ClientName ASC", string search = "")
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
                SELECT 
                    CustomerID AS ClientID,
                    CompanyName,
                    ClientName,
                    RawMaterialName,
                    City,
                    MobileNo,
                    TotalAmount,
                    PaidAmount,
                    (TotalAmount - PaidAmount) AS BalanceAmount
                FROM Client
                WHERE (@search = '' 
                       OR CompanyName LIKE @search
                       OR ClientName LIKE @search
                       OR City LIKE @search)
                ORDER BY " + orderBy;

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                DataTable dt = new DataTable();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }

                gvClients.DataSource = dt;
                gvClients.DataBind();
            }
        }
    }

    // ================= INJECT DASHBOARD STATS =================
    void InjectStats()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
                SELECT 
                    COUNT(*) AS TotalClients,
                    ISNULL(SUM(PaidAmount),0) AS PaidAmount,
                    ISNULL(SUM(TotalAmount - PaidAmount),0) AS BalanceAmount,
                    ISNULL(SUM(TotalAmount),0) AS TotalAmount
                FROM Client";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        string script = "";
                        script += "document.querySelectorAll('.stat-value')[0].innerText = '" + dr["TotalClients"] + "';";
                        script += "document.querySelectorAll('.stat-value')[1].innerText = '₹ " +
                                    Convert.ToDecimal(dr["PaidAmount"]).ToString("N2") + "';";
                        script += "document.querySelectorAll('.stat-value')[2].innerText = '₹ " +
                                    Convert.ToDecimal(dr["BalanceAmount"]).ToString("N2") + "';";
                        script += "document.querySelectorAll('.stat-value')[3].innerText = '₹ " +
                                    Convert.ToDecimal(dr["TotalAmount"]).ToString("N2") + "';";

                        ClientScript.RegisterStartupScript(this.GetType(), "LoadStats", script, true);
                    }
                }
            }
        }
    }

    // ================= SEARCH =================
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string orderBy = GetSortOrder();
        LoadClients(orderBy, txtSearch.Text.Trim());
        InjectStats();
    }

    // ================= ADD CLIENT =================
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClientAdd.aspx");
    }

    // ================= SORT LOGIC =================
    string GetSortOrder()
    {
        switch (ddlSort.SelectedValue)
        {
            case "Paid":
                return "PaidAmount DESC";
            case "Balance":
                return "(TotalAmount - PaidAmount) DESC";
            case "AZ":
                return "ClientName ASC";
            case "ZA":
                return "ClientName DESC";
            default:
                return "ClientName ASC";
        }
    }

    // ================= DELETE CLIENT =================
    void DeleteClient(int id)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("DELETE FROM Client WHERE CustomerID = @ID", con))
            {
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
