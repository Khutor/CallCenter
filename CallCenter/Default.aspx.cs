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
using Newtonsoft.Json;

namespace CallCenter
{
    public partial class _Default : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["cstring"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["operatorID"] != null)
            {
                getOperatorReports();
            }
        }

        protected void getOperatorReports()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(cs))
                {
                    var proc = "Get_Operator_Reports";
                    using(MySqlCommand cmd = new MySqlCommand(proc, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("opID", Convert.ToInt32(Session["operatorID"].ToString()));
                        conn.Open();
                        using(MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            var reports = new List<report>();
                            while(reader.Read())
                            {
                                string comment = reader[7].ToString();
                                string newComment = "<a style='text-decoration: underline;'>";
                                if (comment.Length > 5)
                                {
                                    comment = comment.Substring(0, 4);
                                    comment += "...";
                                }
                                newComment += comment;
                                newComment += "</a>";

                                reports.Add(new report { reportID = reader[0].ToString(), reportContents = new List<string> { reader[1].ToString(), reader[2].ToString(), reader[3].ToString(),
                                    reader[4].ToString(), reader[5].ToString(), reader[6].ToString(), newComment } });
                            }
                            var json = JsonConvert.SerializeObject(reports);
                            reportHistoryHF.Value = json;
                        }
                        conn.Dispose();
                        conn.Close();
                    }
                }
            }
            catch(MySqlException ex)
            {
                msgLbl.Text = ex.ToString();
            }
        }
    }

    public class report
    {
        public string reportID { get; set; }
        public List<string> reportContents { get; set; }
    }
}