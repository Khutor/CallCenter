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
    public partial class Login : System.Web.UI.Page
    {

        private string cs = ConfigurationManager.ConnectionStrings["cstring"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// loginBtn_Click(object, EventArgs) handles the logging in of a user
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void loginBtn_Click(object sender, EventArgs e)
        {
            var uname = unameTxt.Text;
            var pw = pwTxt.Text;

           try
            {
                using(MySqlConnection conn = new MySqlConnection(cs))
                {
                    var proc = "Validate_Login";
                    using (MySqlCommand cmd = new MySqlCommand(proc, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("uName", uname);

                        using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            //Should be just 1 row exactly, else invalid login
                            if (dt.Rows.Count == 1)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    //Verifies the entered password by comparing it to the hashed pw and salt
                                    bool verified = verifyPassword(pw, row["operatorSalt"].ToString(), row["operatorPassword"].ToString());
                                    if (verified)
                                    {
                                        //Sets session vars and redirects to overview page
                                        Session["operatorID"] = row["operatorID"].ToString();
                                        Session["operatorName"] = row["operatorFName"].ToString() + " " + row["operatorLName"].ToString();
                                        Session["operatorRole"] = row["roleID"].ToString();
                                        Session["isLogged"] = "True";
                                        Response.Redirect("Default.aspx");
                                    }
                                    else
                                    {
                                        msgLbl.CssClass = "alert alert-danger";
                                        msgLbl.Text = "Invalid username/password";
                                    }
                                }
                            }
                            else
                            {
                                msgLbl.CssClass = "alert alert-danger";
                                msgLbl.Text = "Invalid username/password";
                            }
                        }
                    }
                }
            }
            catch(MySqlException ex)
            {
                msgLbl.CssClass = "alert alert-danger";
                msgLbl.Text = "An error occurred: " + ex.Code.ToString();
            }

        }

        /// <summary>
        /// verifyPassword(string, string, string) returns a true/false to see if the password matches via
        /// hashing and salting through rfc2898DeriveBytes method
        /// </summary>
        /// <param name="pw">User entered password</param>
        /// <param name="salt">Password salt</param>
        /// <param name="hash">Hashed password</param>
        /// <returns></returns>
        private bool verifyPassword(string pw, string salt, string hash)
        {
            var saltBytes = Convert.FromBase64String(salt);
            var rfc2898DeriveBytes = new Rfc2898DeriveBytes(pw, saltBytes, 10000);
            return Convert.ToBase64String(rfc2898DeriveBytes.GetBytes(256)) == hash;

        }
    }
}