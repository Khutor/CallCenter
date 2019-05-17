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
            if (Session["isLogged"].Equals("False"))
            {
                System.Diagnostics.Debug.WriteLine("SiteMaster: " + Session["isLogged"]);
                notLog.Visible = true;
                opLog.Visible = false;
                supLog.Visible = false;
            }
            else if (Session["isLogged"].Equals("True") && Session["operatorRole"].Equals("1"))
            {
                notLog.Visible = false;
                opLog.Visible = false;
                supLog.Visible = true;
            }
            else if(Session["isLogged"].Equals("True") && Session["operatorRole"].Equals("2"))
            {
                notLog.Visible = false;
                opLog.Visible = true;
                supLog.Visible = false;
            }
            else
            {
                notLog.Visible = true;
                opLog.Visible = false;
                supLog.Visible = false;
            }

            if (Session["operatorRole"] != null)
            {
                sessHF.Value = Session["operatorRole"].ToString();
            }
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}