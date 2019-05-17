<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="CallCenter.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Contact Info</h2>
    <address>
        Call Center Avenue<br />
        Redmond, WA 98052-6399<br />
        Phone:
        (123) 456-7890
    </address>

    <address>
        <strong>Center Support:</strong>   <a href="mailto:support@example.com">support@example.com</a><br />
        <strong>Marketing:</strong> <a href="mailto:marketing@example.com">marketing@example.com</a><br />
        <strong>Careers:</strong> <a href="mailto:careers@example.com">careers@example.com</a>
    </address>
</asp:Content>
