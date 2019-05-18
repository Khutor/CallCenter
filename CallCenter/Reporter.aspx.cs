using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace CallCenter
{
    public partial class Reporter : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["cstring"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Must be set to true on load for some reason
            if(!IsPostBack)
            {
                newCustChkBox.Checked = true;
            }

            //Fills the dropdowns from DB even after postback to get the updated customer dropdown if new customer added
            fillDDLs();
        }

        /// <summary>
        /// fillDDLs() fills the customer search, support type, and problem type dropdowns from the database
        /// </summary>
        private void fillDDLs()
        {
            try
            {
                //Establish connection
                using(MySqlConnection conn = new MySqlConnection(cs))
                {
                    var proc = "Get_CustomerSupportProblem";
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(proc, conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    //Execute the procedure
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (IsPostBack) custSearchDDL.Items.Clear();
                        //While reading the customer, add them to the dropdown
                        while(reader.Read())
                        {
                            var customer = reader[1] + " " + reader[2] + ", " + reader[3] + ", " + reader[4];
                            custSearchDDL.Items.Add(new ListItem(customer, reader[0].ToString()));
                        }

                        if(!IsPostBack) { 
                            //Get next result (support type)
                            reader.NextResult();

                            //Get each support type and add to dropdown
                            while(reader.Read())
                            {
                                supportTypeDDL.Items.Add(new ListItem(reader[1].ToString(), reader[0].ToString()));
                            }

                            //Get next result (problem type)
                            reader.NextResult();

                            //Get each problem type and add to dropdown
                            while(reader.Read())
                            {
                                problemTypeDDL.Items.Add(new ListItem(reader[1].ToString(), reader[0].ToString()));
                            }
                        }

                    }
                    conn.Close();
                }              
            }
            catch (MySqlException ex)
            {
                msgLbl.Text = ex.ToString();
            }
        }

        protected void submitBtn_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                var custID = "";
                if(newCustChkBox.Checked)
                {
                    //Gets the new customer's ID
                    custID = insertGetCustomer(nameTxt.Text, phoneTxt.Text, emailTxt.Text);
                }
                else
                {
                    //Gets the existing customer's ID
                    custID = custSearchDDL.SelectedValue;
                }
                
                try
                {
                    using (MySqlConnection conn = new MySqlConnection(cs))
                    {
                        var proc = "Insert_Report";
                        using(MySqlCommand cmd = new MySqlCommand(proc, conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("opID", Convert.ToInt32(Session["operatorID"].ToString()));
                            cmd.Parameters.AddWithValue("custID", custID);
                            cmd.Parameters.AddWithValue("suppID", supportTypeDDL.SelectedValue);
                            cmd.Parameters.AddWithValue("probID", problemTypeDDL.SelectedValue);
                            cmd.Parameters.AddWithValue("resolved", resolvedDDL.SelectedValue);
                            cmd.Parameters.AddWithValue("cmnt", commentTxt.Text);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Dispose();
                            conn.Close();
                            //msgLbl.ForeColor = System.Drawing.Color.Black;
                            msgLbl.CssClass = "alert alert-success";
                            msgLbl.Text = "Report successfully created!";
                        }
                    }
                }
                catch(MySqlException ex)
                {
                   // msgLbl.ForeColor = System.Drawing.Color.Red;
                    msgLbl.CssClass = "alert alert-danger";
                    msgLbl.Text = "An error occurred: " + ex.Code.ToString();
                }

            }
            else
            {
                //Fields not valid; do not submit
                msgLbl.CssClass = "alert alert-danger";
                //msgLbl.ForeColor = System.Drawing.Color.Red;
                msgLbl.Text = "Please fix the indicated fields";
            }
        }

        /// <summary>
        /// insertGetCustomer(string, string, string) inserts a customer and grabs that new ID
        /// and returns it to the calling function
        /// </summary>
        /// <param name="name">Customer's name</param>
        /// <param name="phone">Customer's phone number</param>
        /// <param name="email">Customer's email</param>
        /// <returns>returns the new customer's ID</returns>
        private string insertGetCustomer(string name, string phone, string email)
        {
            //Split name into first and last
            string[] nameParts = name.Split(' ');
            string fName = nameParts[0];
            string lName = nameParts[1];

            if(newCustChkBox.Checked)
            {
                //Removes extra stuff from phone number
                phone = phone.Replace("(", string.Empty)
                             .Replace(")", string.Empty)
                             .Replace(" ", string.Empty)
                             .Replace("-", string.Empty);
            }
            string custID = "";
            try
            {
                using (MySqlConnection conn = new MySqlConnection(cs))
                {
                    var proc = "Insert_Get_Customer";
                    using(MySqlCommand cmd = new MySqlCommand(proc, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("fName", fName);
                        cmd.Parameters.AddWithValue("lName", lName);
                        cmd.Parameters.AddWithValue("phone", phone);
                        cmd.Parameters.AddWithValue("email", email);
                        conn.Open();
                        using(MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            //Checks to see if there is anything to read
                            if(reader.HasRows)
                            {
                                while(reader.Read())
                                {
                                    //Sets the customerID (grabbed even if the customer already exists)
                                    custID = reader[0].ToString();
                                }
                            }
                        }
                        conn.Dispose();
                        conn.Close();
                    }
                }
                fillDDLs();
            }
            catch(MySqlException ex)
            {
                msgLbl.CssClass = "alert alert-danger";
                msgLbl.Text = "An error occurred: " + ex.Code.ToString();
            }

            return custID;
        }
    }
}