using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using MySql;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace CallCenter
{
    public partial class AddOperator : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["cstring"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Session["operatorRole"].Equals("1"))
            {
                if(Session["isLogged"].Equals("False"))
                {
                    Response.Redirect("Login.aspx");
                }
                if(Session["isLogged"].Equals("True"))
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            string hash, salt;
            string pw = tempPW.Text;
            string uName = fnameTxt.Text.ToLower() + "." + mnameTxt.Text.ToLower()[0] + "." + lnameTxt.Text.ToLower();
            generateSaltHash(pw, out salt, out hash);

            try
            {
                using(MySqlConnection conn = new MySqlConnection(cs))
                {
                    var proc = "Insert_Operator";
                    using(MySqlCommand cmd = new MySqlCommand(proc, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("uName", uName);
                        cmd.Parameters.AddWithValue("uPW", hash);
                        cmd.Parameters.AddWithValue("uSalt", salt);
                        cmd.Parameters.AddWithValue("uFName", fnameTxt.Text);
                        cmd.Parameters.AddWithValue("uMName", mnameTxt.Text);
                        cmd.Parameters.AddWithValue("uLName", lnameTxt.Text);
                        cmd.Parameters.AddWithValue("rID", roleDDL.SelectedValue);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Dispose();
                        conn.Close();

                        msgLbl.ForeColor = System.Drawing.Color.Black;
                        msgLbl.CssClass = "alert alert-success";
                        msgLbl.Text = "Operator successfully added";
                    }
                }
            }
            catch(MySqlException ex)
            {
                msgLbl.ForeColor = System.Drawing.Color.Red;
                msgLbl.CssClass = "alert alert-danger";
                msgLbl.Text = "An error occurred: " + ex.Code.ToString();
            }

        }

        /// <summary>
        /// generateSaltHash(string, out string, out string) creates the salt and hash for a password
        /// </summary>
        /// <param name="pw">The temporary password</param>
        /// <param name="salt">The salt</param>
        /// <param name="hash">The hashed password</param>
        private void generateSaltHash(string pw, out string salt, out string hash)
        {
            var saltBytes = new byte[64];
            var provider = new RNGCryptoServiceProvider();
            provider.GetNonZeroBytes(saltBytes);
            salt = Convert.ToBase64String(saltBytes);

            var rfc2898DeriveBytes = new Rfc2898DeriveBytes(pw, saltBytes, 10000);
            hash = Convert.ToBase64String(rfc2898DeriveBytes.GetBytes(256));
        }
    }
}