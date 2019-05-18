<%@ Page Title="Reporter" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reporter.aspx.cs" Inherits="CallCenter.Reporter" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <style type="text/css">
        .wrapp {padding-top: 10px;}
        .align-right {text-align: right;}
        .align-left {text-align: left;}        
        .w {padding-right: 10px;}
        .ddlHeight {margin-bottom: 15px;}
        .cmntWidth {max-width: 500px;}
        .ddlWidth {width: 110%;}
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
                            <asp:CheckBox ID="newCustChkBox" CssClass="form-check-input" runat="server" Checked="true" />
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
            <div class="row" >
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="col-form-label">
                                <asp:DropDownList ID="custSearchDDL" CssClass="selectpicker show-tick" data-width="175px" data-size="5" data-live-search="true" runat="server"></asp:DropDownList>
                                <p class="break"><br /></p>
                                <p class="cust">Name:<span style="color:red">*</span></p>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <p class="break2"><br /></p>
                            <asp:TextBox ID="nameTxt" placeholder="John Doe" CssClass="custTxtBx name form-control" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="regexName" runat="server" ValidationExpression="^[A-Z][a-z]+\s[A-Z][a-z]+$" ControlToValidate="nameTXt" ErrorMessage="Invalid Name Format" Font-Bold="False" Font-Size="10px" ForeColor="#CC0000"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="col-form-label">
                                <p class="cust email">Email:<span style="color:red">*</span></p>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <asp:TextBox ID="emailTxt" required="true" placeholder="example@example.com" Font-Size="13px" CssClass="custTxtBx email form-control" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="emailTXt" ErrorMessage="Invalid Email Format" Font-Bold="False" Font-Size="10px" ForeColor="#CC0000"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row custInfo">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="col-form-label">
                                <p class="cust phone">Phone:<span style="color:red">*</span></p>
                            </div>
                        </div>
                        <div class="col-lg-9">                           
                            <asp:TextBox ID="phoneTxt" placeholder="(123) 456-7890" CssClass="custTxtBx phone form-control" runat="server"></asp:TextBox>
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
                            <asp:DropDownList ID="supportTypeDDL" CssClass="form-control ddlWidth" runat="server"></asp:DropDownList>
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
                            <asp:DropDownList ID="problemTypeDDL" CssClass="form-control ddlWidth" runat="server"></asp:DropDownList>
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
                            <asp:DropDownList ID="resolvedDDL" CssClass="form-control ddlWidth" runat="server">
                                <asp:ListItem Selected="True" Value="1">Resolved</asp:ListItem>
                                <asp:ListItem Value="0">Not Resolved</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6" style="padding-left: 3%">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-form-label">
                                Comment<span style="color:red">*</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <asp:TextBox ID="commentTxt" placeholder="What was discussed, reason for not resolved, etc." CssClass="form-control cmntWidth" required="true" TextMode="MultiLine" runat="server" Height="100px" Width="100%" Font-Size="13px"></asp:TextBox>
            </div>
        </div>

    </div>

    <div class="row">
        <div class="col"></div>
        <div class="col">
            <asp:Button ID="submitBtn" runat="server" CssClass="btn btn-primary" Text="Submit Report" OnClick="submitBtn_Click" />
            <br /><br />
            <div id="msg" role="alert">
                <asp:Label ID="msgLbl" runat="server" Text=""></asp:Label>
            </div>
        </div>
        <div class="col"></div>
    </div>
    </div>

    <script defer="defer" type="text/javascript">
        //Hides the cust search dropdown on page load and masks the phone# textbox
        $(document).ready(function () {
            $('.selectpicker').selectpicker();
            $('.selectpicker').selectpicker('hide');
            $('#<%= phoneTxt.ClientID %>').mask('(000) 000-0000');
            $("p.break").html("");
            $("p.break2").html("");

            
            var msg = $('#<%= msgLbl.ClientID %>').text();
            if (~msg.indexOf("Please fix") || ~msg.indexOf("An error")) {
                //$('#msg').removeClass();
                //$('#msg').addClass("alert alert-danger");
            } else if (~msg.indexOf("Report successfully")) {
                //$('#msg').removeClass();
                //$('#msg').addClass("alert alert-success");
            }
            

        });

        //Fills the name, phone, email textboxes with contents of dropdown
        function fillTextBoxes() {
            var sel = $('.selectpicker option:selected').text();
            var parts = sel.split(',');
            $('.name').val(parts[0]);
            $('.email').val(parts[2]);
            $('.phone').val(parts[1]);
        }

        //Allows showing/hiding of customer search dropdown and customer info if new checked
        $('#<%= newCustChkBox.ClientID %>').change(function() {
            if (this.checked) {
                $('.selectpicker').selectpicker('hide');
                $('.custTxtBx').val('');
                $('.custTxtBx').prop('required', true);
                $('.custTxtBx').removeAttr('disabled');
                $("p.break").html("");
                $("p.break2").html("");
            } else {
                $('.selectpicker').selectpicker('show');
                $('.custTxtBx').val('');
                $('.custTxtBx').attr('disabled', 'disabled').val('');
                $("p.break").html("<br/>");
                $("p.break2").html("<br/><br/>");

                fillTextBoxes();
            }
        });

        //Dynamically changes the name, phone, email textboxes on each selected change
        $('.selectpicker').change(function () {
            fillTextBoxes();
        });

        
    </script>

</asp:Content>
