using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CallCenter
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {           
            //Displays the non-logged navbar
            if (Session["isLogged"].Equals("False"))
            {
                System.Diagnostics.Debug.WriteLine("SiteMaster: " + Session["isLogged"]);
                notLog.Visible = true;
                opLog.Visible = false;
                supLog.Visible = false;
            }
            //Displays supervisor navbar
            else if (Session["isLogged"].Equals("True") && Session["operatorRole"].Equals("1"))
            {
                notLog.Visible = false;
                opLog.Visible = false;
                supLog.Visible = true;
            }
            //Displays operator navbar
            else if(Session["isLogged"].Equals("True") && Session["operatorRole"].Equals("2"))
            {
                notLog.Visible = false;
                opLog.Visible = true;
                supLog.Visible = false;
            }
            //Else display not logged navbar
            else
            {
                notLog.Visible = true;
                opLog.Visible = false;
                supLog.Visible = false;
            }

            //Stores the operator's role to be read by JavaScript
            if (Session["operatorRole"] != null)
            {
                sessHF.Value = Session["operatorRole"].ToString();
            }
        }

        /// <summary>
        /// logoutBtn_Click(object, EventArgs) logs out user when clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}