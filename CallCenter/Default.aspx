<%@ Page Title="Overview" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CallCenter._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    <style type="text/css">
        .tooltip-inner {max-width: 50% !important;}
    </style>

    <asp:HiddenField ID="reportHistoryHF" runat="server" />
    <asp:HiddenField ID="unresolvedReportsHF" runat="server" />
    <asp:HiddenField ID="supReportsHF" runat="server" />

    <div class="jumbotron">
        <h1>Overview for <asp:Label ID="nameLbl" runat="server" Text=""></asp:Label></h1>
        <p class="lead">View<asp:Label ID="superLbl" runat="server" Text=" "></asp:Label>your recently resolved reports and current un-resolved reports</p>
        <button id="myBtn" style="margin-right: 5px;" class="btn btn-primary" onclick="return false;">My Reports</button>
        <button id="unresBtn" style="margin-right: 5px;" class="btn btn-primary" onclick="return false;">Unresolved Reports</button>
        <button id="allBtn" style="visibility: hidden;" class="btn btn-primary" onclick="return false;">All Reports</button>
    </div>

    <%-- Operator's resolved reports table --%>
    <div id="myreports" class="row" style="padding-left: 3%;">
        <h2>My 25 Recently Resolved Reports</h2><br />
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
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Unresolved reports table --%>
    <div id="unresolved" style="visibility: hidden; padding-left: 3%;">
        <h2>Current Unresolved Reports</h2>
        <div id="unresolvedreports">
            <table id="unresolvedTable" class="table table-hover table-sm">
                <thead class="thead-dark">
                    <tr>
                        <th>Report ID</th>
                        <th>Created By</th>
                        <th>Create Date</th>
                        <th>Last Update</th>
                        <th>Support Type</th>
                        <th>Problem Type</th>
                        <th>Customer</th>
                        <th>Resolved</th>
                        <th>Comment</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Supervisor reports table --%>
    <div id="super" style="visibility: hidden; padding-left: 3%;">
        <h2>All Reports</h2>
        <div id="superreports">
            <table id="superTable" class="table table-hover table-sm">
                <thead class="thead-dark">
                    <tr>
                        <th>Report ID</th>
                        <th>Created By</th>
                        <th>Resolved By</th>
                        <th>Create Date</th>
                        <th>Last Update</th>
                        <th>Support Type</th>
                        <th>Problem Type</th>
                        <th>Customer</th>
                        <th>Resolved</th>
                        <th>Comment</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <asp:Label ID="msgLbl" runat="server" Text=" "></asp:Label>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script defer type="text/javascript">
        $(document).ready(function () {
            /****Creates tables using the JQuery DataTables library****/

            //Operator's resolved reports table
            var t = $('#reportsTable').DataTable({ "pageLength": 5, "lengthChange": false, "drawCallback": function (settings) { $('[data-toggle="tooltip"]').tooltip(); }, language: { search: "" } });
            $('#reportsTable_filter input').addClass('form-control');
            $('#reportsTable_filter input').attr("placeholder", "Search here...");

            var json = $("#" + '<%= reportHistoryHF.ClientID %>').val();
            json = JSON.parse(decodeURIComponent(json));

            //Get each item in json
            $.each(json, function (key, item) {
                t.row.add([item.reportID, item.reportContents[0], item.reportContents[1], item.reportContents[2], item.reportContents[3],
                item.reportContents[4], item.reportContents[5], item.reportContents[6], item.reportContents[7]]).draw();
            });

            //Unresolved reports table
            t = $('#unresolvedTable').DataTable({ "pageLength": 5, "lengthChange": false, "drawCallback": function (settings) { $('[data-toggle="tooltip"]').tooltip(); }, language: { search: "" } });
            $('#unresolvedTable_filter input').addClass('form-control');
            $('#unresolvedTable_filter input').attr("placeholder", "Search here...");

            json = $("#" + '<%= unresolvedReportsHF.ClientID %>').val();
            json = JSON.parse(decodeURIComponent(json));

            //Get each item in json
            $.each(json, function (key, item) {
                t.row.add([item.reportID, item.reportContents[0], item.reportContents[1], item.reportContents[2], item.reportContents[3],
                item.reportContents[4], item.reportContents[5], item.reportContents[6], item.reportContents[7]]).draw();
            });

            //All reports table (supervisors only)
            if ($("#" + '<%= supReportsHF.ClientID %>').val() != "none") {
                t = $('#superTable').DataTable({ "pageLength": 5, "lengthChange": false, "drawCallback": function (settings) { $('[data-toggle="tooltip"]').tooltip(); }, language: { search: "" } });
                $('#superTable_filter input').addClass('form-control');
                $('#superTable_filter input').attr("placeholder", "Search here...");

                json = $("#" + '<%= supReportsHF.ClientID %>').val();
                json = JSON.parse(decodeURIComponent(json));

                //Get each item in json
                $.each(json, function (key, item) {
                    t.row.add([item.reportID, item.reportContents[0], item.reportContents[1], item.reportContents[2], item.reportContents[3],
                    item.reportContents[4], item.reportContents[5], item.reportContents[6], item.reportContents[7], item.reportContents[8]]).draw();
                });

                //Removes the css tag that makes all reports table invisible for page load
                $('#super').hide();
                $('#super').css('visibility', 'visible');

                //Removes the css tag that makes all reports button invisible for page load
                $('#allBtn').css('visibility', 'visible');
            }

            //$('[data-toggle="tooltip"]').tooltip();


            //Removes the css tag that makes unresolved table invisible for page load
            $('#unresolved').hide();
            $('#unresolved').css('visibility', 'visible');

            //Shows operator's reports table
            $('#myBtn').click(function () {
                $('#unresolved').hide();
                $('#myreports').show();
                $('#super').hide();
            });

            //Shows unresolved reports table
            $('#unresBtn').click(function () {
                $('#unresolved').show();
                $('#myreports').hide();
                $('#super').hide();
            });

            //Shows all reports table
            $('#allBtn').click(function () {
                $('#unresolved').hide();
                $('#myreports').hide();
                $('#super').show();
            });
        });

    </script>

</asp:Content>
