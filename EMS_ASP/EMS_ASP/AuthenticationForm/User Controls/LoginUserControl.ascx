<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginUserControl.ascx.cs" Inherits="AuthenticationForm.LoginUserControl" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
        height: 161px;
    }
    .auto-style4 {
        width: 207px;
    }
    .auto-style5 {
        width: 157px;
    }
    .auto-style7 {
        width: 152px;
    }
    #Reset1 {
        width: 74px;
        text-align: center;
    }
    .auto-style8 {
        width: 152px;
        text-align: right;
    }
</style>

<asp:Panel ID="Panel1" runat="server" Height="165px" Width="422px">
    <table class="auto-style1">
        <tr>
            <td class="auto-style8">
                <asp:Label ID="Label1" runat="server" Text="User Name:"></asp:Label>
            </td>
            <td class="auto-style5">
                <asp:TextBox ID="UsernameTextbox" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style4">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UsernameTextbox" ErrorMessage="Username Required." ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">Password:</td>
            <td class="auto-style5">
                <asp:TextBox ID="PasswordTextbox" runat="server" TextMode="Password"></asp:TextBox>
            </td>
            <td class="auto-style4">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="PasswordTextbox" ErrorMessage="Password Required." ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:Button ID="LoginButton" runat="server" OnClick="LoginButton_Click" style="text-align: center" Text="Login" Width="82px" />
            </td>
            <td class="auto-style5">
                <input id="Reset1" type="reset" value="reset" />
            </td>
            <td class="auto-style4">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:CheckBox ID="CheckBox1" runat="server" Font-Size="X-Small" Text="Remember Me?" />
            </td>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style4">&nbsp;</td>
        </tr>
    </table>
</asp:Panel>

