using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CallCenter
{
    public partial class Reporter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            newCustChkBox.Checked = true;
        }

        protected void newCustChkBox_CheckedChanged(object sender, EventArgs e)
        {
            //custInfoPnl.Visible = newCustChkBox.Checked;
        }

    }
}