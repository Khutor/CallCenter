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
                nameLbl.Text = Session["operatorName"].ToString();
                getOperatorReports();
            }
            else
            {
                Response.Redirect("Login.aspx");
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
                            //Operator's own reports
                            while(reader.Read())
                            {
                                string comment = reader[7].ToString();
                                string newComment = "";
                                //Adds a tooltip to show the full comment
                                if (comment.Length > 40)
                                {
                                    newComment = "<a style='border-bottom: 1px dotted black;' data-toggle='tooltip' title='" + comment + "'>";
                                    comment = comment.Substring(0, 39);
                                    if(comment.Substring(comment.Length -1, 1).Equals(" "))
                                    {
                                        comment.TrimEnd(' ');
                                    }
                                    comment += "...";
                                    newComment += comment + "</a>";
                                }
                                else
                                {
                                    newComment = comment;
                                }
                                
                                //Adds the reports
                                reports.Add(new report { reportID = reader[0].ToString(),
                                    reportContents = new List<string> { reader[1].ToString(), reader[2].ToString(), reader[3].ToString(),
                                    reader[4].ToString(), reader[5].ToString(), reader[6].ToString(), newComment }
                                });
                            }
                            //Convert reports to JSON
                            var json = JsonConvert.SerializeObject(reports);
                            reportHistoryHF.Value = json;

                            //Get unresolved reports
                            reader.NextResult();

                            reports = new List<report>();
                            //All unresolved reports
                            while (reader.Read())
                            {
                                string comment = reader[7].ToString();
                                string newComment = "";
                                //Adds a tooltip to show the full comment
                                if (comment.Length > 40)
                                {
                                    newComment = "<a style='border-bottom: 1px dotted black;' data-toggle='tooltip' title='" + comment + "'>";
                                    comment = comment.Substring(0, 39);
                                    if (comment.Substring(comment.Length - 1, 1).Equals(" "))
                                    {
                                        comment.TrimEnd(' ');
                                    }
                                    comment += "...";
                                    newComment += comment + "</a>";
                                }
                                else
                                {
                                    newComment = comment;
                                }
                                //Creates a link containing the report's ID
                                string resolved = "<a href='Reporter.aspx?report=" + reader[0].ToString() + "'>" + reader[6].ToString() + "</a>";

                                //Adds the reports
                                reports.Add(new report
                                {
                                    reportID = reader[0].ToString(),
                                    reportContents = new List<string> { reader[1].ToString(), reader[2].ToString(), reader[3].ToString(),
                                    reader[4].ToString(), reader[5].ToString(), resolved, newComment }
                                });
                            }
                            //Convert reports to JSON
                            json = JsonConvert.SerializeObject(reports);
                            unresolvedReportsHF.Value = json;

                            //If supervisor, get all reports
                            if(Session["operatorRole"].Equals("1"))
                            {
                                reader.NextResult();

                                reports = new List<report>();
                                while (reader.Read())
                                {
                                    string comment = reader[9].ToString();
                                    string newComment = "";
                                    //Adds a tooltip to show the full comment
                                    if (comment.Length > 40)
                                    {                                       
                                        newComment = "<a style='border-bottom: 1px dotted black;' data-toggle='tooltip' title='" + comment + "'>";
                                        comment = comment.Substring(0, 39);
                                        if (comment.Substring(comment.Length - 1, 1).Equals(" "))
                                        {
                                            comment.TrimEnd(' ');
                                        }
                                        comment += "...";
                                        newComment += comment + "</a>";
                                    }
                                    else
                                    {
                                        newComment = comment;
                                    }

                                    
                                    string resolved = reader[8].ToString();
                                    if(resolved.Equals("Not Resolved"))
                                    {
                                        resolved = "<a href='Reporter.aspx?report=" + reader[0].ToString() + "'>" + resolved + "</a>";
                                    }

                                    //Adds the reports
                                    reports.Add(new report
                                    {
                                        reportID = reader[0].ToString(),
                                        reportContents = new List<string> { reader[1].ToString(), reader[2].ToString(), reader[3].ToString(),
                                        reader[4].ToString(), reader[5].ToString(), reader[6].ToString(), reader[7].ToString(), resolved, newComment }
                                    });
                                }

                                //Convert reports to JSON
                                json = JsonConvert.SerializeObject(reports);
                                supReportsHF.Value = json;
                                superLbl.Text = " all reports, ";
                            }
                            else
                            {
                                supReportsHF.Value = "none";
                            }
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

    /// <summary>
    /// report class holds the reports (could probably be better)
    /// </summary>
    public class report
    {
        public string reportID { get; set; }
        public List<string> reportContents { get; set; }
    }
}