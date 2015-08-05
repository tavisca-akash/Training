<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PasswordChange.aspx.cs" Inherits="AuthenticationForm.PasswordChange" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 373px;
        }
        .auto-style3 {
            width: 373px;
            height: 28px;
        }
        .auto-style4 {
            width: 373px;
            height: 18px;
        }
        .auto-style5 {
            width: 373px;
            text-align: right;
        }
        .auto-style6 {
            width: 373px;
            height: 18px;
            text-align: right;
        }
        .auto-style7 {
            width: 373px;
            height: 28px;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <table class="auto-style1">
        <tr>
            <td class="auto-style2">
                <asp:Label ID="Label1" runat="server" Text="Old Password"></asp:Label>
            </td>
            <td class="auto-style2">
                &nbsp;</td>
            <td class="auto-style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:TextBox ID="TextBoxOldPassword" runat="server" TextMode="Password" Width="261px"></asp:TextBox>
            </td>
            <td class="auto-style3">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxOldPassword" ErrorMessage="Field cannot be empty"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:Label ID="Label2" runat="server" Text="New Password"></asp:Label>
            </td>
            <td class="auto-style2">
                &nbsp;</td>
            <td class="auto-style5">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:TextBox ID="TextBoxNewPassword" runat="server" TextMode="Password" Width="262px"></asp:TextBox>
            </td>
            <td class="auto-style2">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxNewPassword" ErrorMessage="Field cannot be empty"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style5">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label3" runat="server" Text="Confirm New Password"></asp:Label>
            </td>
            <td class="auto-style4">
                </td>
            <td class="auto-style6">
                </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:TextBox ID="TextBoxConfirmPassword" runat="server" TextMode="Password" Width="259px"></asp:TextBox>
            </td>
            <td class="auto-style2">
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TextBoxNewPassword" ControlToValidate="TextBoxConfirmPassword" ErrorMessage="Password Mismatch"></asp:CompareValidator>
            </td>
            <td class="auto-style5">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
                </td>
            <td class="auto-style2">
                &nbsp;</td>
            <td class="auto-style2">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
