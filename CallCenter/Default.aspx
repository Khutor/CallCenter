<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CallCenter._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">

    <asp:HiddenField ID="reportHistoryHF" runat="server" />

    <div class="jumbotron">
        <h1>Overview</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
    </div>

    <div class="row" style="padding-left: 3%;">
        <h2>My Recent Reports</h2><br />
        <div id="recentReports">
            <table id="reportsTable" class="table table-hover table-sm">
                <thead class="thead-dark">
                    <tr>
                        <th>Report ID</th>
                        <th>Create Date</th>
                        <th>Last Update</th>
                        <th>Support Type</th>
                        <th>Problem Type</th>
                        <th>Customer</th>
                        <th>Resolved</th>
                        <th>Comment</th>
                    </tr>
                </thead>
                <tbody id="tablecont">
                </tbody>
            </table>
        </div>
    </div>

    <asp:Label ID="msgLbl" runat="server" Text=" "></asp:Label>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script defer type="text/javascript">
        $(document).ready(function () {
            var t = $('#reportsTable').DataTable();

            var json = $("#" + '<%= reportHistoryHF.ClientID %>').val();
            json = JSON.parse(decodeURIComponent(json));

            $.each(json, function (key, item) {
                t.row.add([item.reportID, item.reportContents[0], item.reportContents[1], item.reportContents[2], item.reportContents[3],
                    item.reportContents[4], item.reportContents[5], item.reportContents[6], item.reportContents[7]]).draw();

                /*
                //$("#tablecont").append("<tr>");
                //$("#tablecont").append("<td>" + item.reportID + "</td>");
                for (var i in item.reportContents) {
                    //$("#tablecont").append("<td>" + item.reportContents[i] + "</td>");
                }
                //$("#tablecont").append("</tr>");
                */
            });
        });
    </script>

</asp:Content>
