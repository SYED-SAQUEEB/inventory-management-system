using System.Data;

public class AuthService
{
    public static bool ValidateUser(string username, string password)
    {
        string query =
            "SELECT * FROM Users WHERE Username='" + username +
            "' AND Password='" + password + "'";

        DataTable dt = DBHelper.ExecuteSelect(query);
        return dt.Rows.Count > 0;
    }
}
