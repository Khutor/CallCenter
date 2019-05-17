<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CallCenter.Login" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
	    .login-form {
		    width: 340px;
    	    margin: 50px auto;
	    }
        .login-form form {
    	    margin-bottom: 15px;
            background: #f7f7f7;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }
        .login-form h2 {
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

    <div class="login-form">
        <div class="row">
            <div class="col text-center">
                <h2>Operator Login</h2>       
            </div>
        </div>
        <div class="form-group">
            <asp:TextBox ID="unameTxt" CssClass="form-control" placeholder="Username" required="required" runat="server" />
        </div>
        <div class="form-group">
            <asp:TextBox ID="pwTxt" CssClass="form-control" TextMode="Password" placeholder="Password" required="required" runat="server" />
        </div>
        <div class="form-group">
            <asp:button ID="loginBtn" type="submit" class="btn btn-primary btn-block" Text="Login" runat="server" OnClick="loginBtn_Click"/> 
        </div>
        <div class="clearfix center">
            <asp:Label ID="msgLbl" runat="server" ForeColor="Red" Text=""></asp:Label>
        </div>  
    </div>

</asp:Content>
