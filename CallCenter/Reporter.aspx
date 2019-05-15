<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reporter.aspx.cs" Inherits="CallCenter.Reporter" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <style type="text/css">
        .wrapp {padding-top: 10px;}
        .align-right {text-align: right;}
        .align-left {text-align: left;}
        .custInfo {padding-left: 8px;}
        .w {padding-right: 10px;}
        .ddlHeight {margin-bottom: 15px;}
    </style>

    <div class="jumbotron wrapp">
        <h1>Reporter Tool</h1>
        <p class="lead">Fill out the information below to create or update reports</p>
    </div>
    <div style="margin-left: 70px;">
    <div class="row">
        <div class="col-xl-3">
            <div class="row">
                <div class="col-xl-12">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="col-form-label">
                                New Report
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <asp:CheckBox ID="newReportChkBox" CssClass="form-check-input" Checked="true" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="col-form-label">
                                New Customer
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <asp:CheckBox ID="newCustChkBox" CssClass="form-check-input" runat="server" Checked="true" OnCheckedChanged="newCustChkBox_CheckedChanged" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="col-form-label">
                                <p style="text-decoration: underline;">Customer Info</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row custInfo" >
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="col-form-label">
                                <asp:DropDownList ID="custSearchDDL" CssClass="selectpicker show-tick" data-width="fit" data-live-search="true" runat="server">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>Nooooooooooooooo</asp:ListItem>
                                </asp:DropDownList>
                                <p class="cust">Name:</p>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <asp:TextBox ID="nameTxt" placeholder="John Doe" CssClass="test form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row custInfo">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="col-form-label">
                                <p class="cust">Email:</p>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <asp:TextBox ID="emailTxt" required="true" placeholder="example@example.com" Font-Size="13px" CssClass="test form-control" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="emailTXt" ErrorMessage="Invalid Email" Font-Bold="False" Font-Size="10px" ForeColor="#CC0000"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row custInfo">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="col-form-label">
                                <p class="cust">Phone:</p>
                            </div>
                        </div>
                        <div class="col-lg-9">                           
                            <asp:TextBox ID="phoneTxt" placeholder="(123) 456-7890" CssClass="test form-control" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="regexPhone" runat="server" ValidationExpression="^\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}$" ControlToValidate="phoneTxt" ErrorMessage="Invalid Phone" Font-Bold="False" Font-Size="10px" ForeColor="#CC0000"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row ddlHeight">
                        <div class="col-lg-6">
                            <div class="col-form-label">
                                Support Type
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <asp:DropDownList ID="supportTypeDDL" CssClass="form-control" runat="server">
                                <asp:ListItem Selected="True" Value="1">Call</asp:ListItem>
                                <asp:ListItem Value="2">Email</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="row ddlHeight">
                        <div class="col-lg-6">
                            <div class="col-form-label">
                                Problem Type
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <asp:DropDownList ID="problemTypeDDL" CssClass="form-control input-sm" runat="server">
                                <asp:ListItem Selected="True" Value="1">Account</asp:ListItem>
                                <asp:ListItem Value="2">Purchase</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="row ddlHeight">
                        <div class="col-lg-6">
                            <div class="col-form-label">
                                Resolved Status
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                                <asp:ListItem Selected="True" Value="1">Resolved</asp:ListItem>
                                <asp:ListItem Value="2">Not Resolved</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-form-label">
                                Comment
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <asp:TextBox ID="commentTxt" CssClass="form-control" required="true" TextMode="MultiLine" runat="server" Height="84px" Width="700px" Font-Size="13px"></asp:TextBox>
            </div>
        </div>

    </div>

    <div class="row">
        <div class="col"></div>
        <div class="col">
            <asp:Button ID="submitBtn" runat="server" CssClass="btn btn-primary" Text="Submit Report" />
        </div>
        <div class="col"></div>
    </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
    <script type="text/javascript">
        //Hides the cust search dropdown on page load and masks the phone# textbox
        $(document).ready(function () {
            $('.selectpicker').selectpicker();
            $('.selectpicker').selectpicker('hide');
            $('#<%= phoneTxt.ClientID %>').mask('(000) 000-0000');
        });

        //Allows showing/hiding of customer search dropdown and customer info if new checked
        $('#<%= newCustChkBox.ClientID %>').change(function() {
            if (this.checked) {
                $('.selectpicker').selectpicker('hide');
                $('.test').show();
                $('.test').val('');
                $('.test').prop('required', true);
                $("p.cust").css('visibility', 'visible');
            } else {
                $('.selectpicker').selectpicker('show');
                $('.test').hide();
                $('.test').val('');
                $('.test').prop('required', false);
                $("p.cust").css('visibility', 'hidden');
            }
        });
        
    </script>

</asp:Content>
