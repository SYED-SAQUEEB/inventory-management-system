using System;
using System.Data;
using System.Data.SqlClient;

public static class DBHelper
{
    private static string conStr =
        @"Data Source=VICTUS-PC\SQLEXPRESS;Initial Catalog=InventoryDB;Integrated Security=True";

    public static DataTable ExecuteSelect(string query, params SqlParameter[] parameters)
    {
        DataTable dt = new DataTable();

        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error: " + ex.Message, ex);
        }

        return dt;
    }

    public static int ExecuteNonQuery(string query, params SqlParameter[] parameters)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                con.Open();
                return cmd.ExecuteNonQuery();
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error: " + ex.Message, ex);
        }
    }

    // ⭐ REQUIRED FOR SALES PAGE
    public static int ExecuteScalarInt(string query, params SqlParameter[] parameters)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }
        catch (SqlException ex)
        {
            throw new Exception("Database error: " + ex.Message, ex);
        }
    }

    public static bool TestConnection()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                return true;
            }
        }
        catch
        {
            return false;
        }
    }
}
