using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for UserIP
/// </summary>
public class UserIP
{
    private MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
    private StringBuilder table = new StringBuilder();

    public UserIP()
    {
        
    }

    private void storeIP()
    {
        string ipAddress = string.Empty;
        string lastlogin = DateTime.Now.ToString();
        if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDER_FOR"] != null)
        {
            ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();
        }
        else if (HttpContext.Current.Request.UserHostAddress.Length != 0)
        {
            ipAddress = HttpContext.Current.Request.UserHostAddress;
        }

        conn.Open();
        String sql = "INSERT INTO users (ip, lastlogin) SELECT '" + ipAddress + "', '" + lastlogin + "' WHERE NOT EXISTS (SELECT ip FROM users WHERE ip = '" + ipAddress + "')";
        MySqlCommand cmd = new MySqlCommand(sql, conn);
        
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            string errorMsg = "Error";
            errorMsg += ex.Message;
            throw new Exception(errorMsg);
        }
        finally
        {
            conn.Close();
        }
    }

    public void displayIP(DataList datalist)
    {
        conn.Open();
        string lastlogin = DateTime.Now.AddSeconds(-5).ToString();
        String sql = "DELETE FROM `users` WHERE lastlogin < '" + lastlogin + "'";
        MySqlCommand cmd = new MySqlCommand(sql, conn);

        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            string errorMsg = "Error";
            errorMsg += ex.Message;
            throw new Exception(errorMsg);
        }
        finally
        {
            conn.Close();
        }

        storeIP();

        DataTable dt = new DataTable();
        using (conn)
        {
            MySqlDataAdapter ad = new MySqlDataAdapter("SELECT ip FROM users", conn);
            ad.Fill(dt);
        }

        datalist.DataSource = dt;
        datalist.DataBind();

        conn.Close();
        
    }
}