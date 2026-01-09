using System;
using System.Data;

public partial class Account_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // If already logged in, redirect
        if (Session["Admin"] != null)
            Response.Redirect("~/Admin/Dashboard.aspx");
    }
    public static bool ValidateUser(string username, string password)
    {
        string query =
            "SELECT * FROM Users WHERE Username='" + username +
            "' AND Password='" + password + "'";

        DataTable dt = DBHelper.ExecuteSelect(query);
        return dt.Rows.Count > 0;
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        bool isValid = AuthService.ValidateUser(
            txtUsername.Text.Trim(),
            txtPassword.Text.Trim()
        );

        if (isValid)
        {
            Session["Admin"] = txtUsername.Text;
            Response.Redirect("~/Admin/Dashboard.aspx");
        }
        else
        {
            lblMsg.Text = "Invalid Username or Password";
        }
    }
}
