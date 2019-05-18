<%@ Page Title="Operator Add" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddOperator.aspx.cs" Inherits="CallCenter.AddOperator" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        .add-form {
	        width: 340px;
            margin: 50px auto;
        }
        .loging-form form {
            margin-bottom: 15px;
            background: #f7f7f7;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }
        .add-form h2 {
            margin: 0 0 15px;
            padding-right: 17%;
        }
        .form-control, .btn {
            min-height: 38px;
            border-radius: 2px;
        }
        .btn {        
            font-size: 15px;
            font-weight: bold;
        }
    </style>

    <div class="add-form">
        <div class="row">
            <div class="col text-center">
                <h2>Add Operator</h2>       
            </div>
        </div>
        <div class="form-group">
            <asp:TextBox ID="fnameTxt" CssClass="form-control" placeholder="First Name" required="required" runat="server" />
        </div>
        <div class="form-group">
            <asp:TextBox ID="mnameTxt" CssClass="form-control" placeholder="Middle Name" required="required" runat="server" />
        </div>
        <div class="form-group">
            <asp:TextBox ID="lnameTxt" CssClass="form-control" placeholder="Last Name" required="required" runat="server" />
        </div>
        <div class="form-group">
            <asp:TextBox ID="tempPW" CssClass="form-control" TextMode="Password" placeholder="Temporary Password" required="required" runat="server" />
        </div>
        <div class="form-group">
            <asp:DropDownList ID="roleDDL" CssClass="form-control" runat="server">
                <asp:ListItem Value="1">Supervisor</asp:ListItem>
                <asp:ListItem Selected="True" Value="2">Operator</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div>
            <asp:button ID="addBtn" type="submit" class="btn btn-primary btn-block" Text="Add Operator" runat="server" OnClick="addBtn_Click"/> 
        </div>
        <br />
        <div class="clearfix center">
            <asp:Label ID="msgLbl" runat="server" ForeColor="Red" Text=""></asp:Label>
        </div>  
    </div>


</asp:Content>
