<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HRAddEmployeeTab.ascx.cs" Inherits="AuthenticationForm.HRAddEmployeeTab" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
    .auto-style2 {
        width: 199px;
        text-align: right;
    }
    .auto-style3 {
        width: 179px;
    }
    .auto-style4 {
        width: 199px;
        text-align: right;
        height: 26px;
    }
    .auto-style5 {
        width: 179px;
        height: 26px;
    }
    .auto-style6 {
        height: 26px;
    }
    #Reset1 {
        text-align: left;
        width: 74px;
        margin-left: 38px;
    }
    .auto-style7 {
        height: 26px;
        width: 401px;
    }
    .auto-style8 {
        width: 401px;
    }
</style>

<table class="auto-style1">
    <tr>
        <td class="auto-style4">Title:</td>
        <td class="auto-style5">
            <asp:TextBox ID="TextBoxTitle" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
        </td>
        <td class="auto-style7">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxTitle" ErrorMessage="Title Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style6">
            <asp:Button ID="ButtonLogout" runat="server" Height="27px" OnClick="ButtonLogout_Click" Text="Logout" />
        </td>
    </tr>
    <tr>
        <td class="auto-style2">First Name:</td>
        <td class="auto-style3">
            <asp:TextBox ID="TextBoxFirstName" runat="server"></asp:TextBox>
        </td>
        <td class="auto-style8">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="TextBoxFirstName" ErrorMessage="First Name Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style4">Last Name:</td>
        <td class="auto-style5">
            <asp:TextBox ID="TextBoxLastName" runat="server"></asp:TextBox>
        </td>
        <td class="auto-style7">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="TextBoxLastName" ErrorMessage="Last Name Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style6">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style4">Email Id:</td>
        <td class="auto-style5">
            <asp:TextBox ID="TextBoxEmail" runat="server"></asp:TextBox>
        </td>
        <td class="auto-style7">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="TextBoxEmail" ErrorMessage="Email Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style6">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style4">Phone No:</td>
        <td class="auto-style5">
            <asp:TextBox ID="TextBoxPhone" runat="server"></asp:TextBox>
        </td>
        <td class="auto-style7">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="TextBoxPhone" ErrorMessage="Phone No. Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style6">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">Designation:</td>
        <td class="auto-style3">
            <asp:TextBox ID="TextBoxDesignation" runat="server"></asp:TextBox>
        </td>
        <td class="auto-style8">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="TextBoxDesignation" ErrorMessage="Designation Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style4">&nbsp;</td>
        <td class="auto-style5">
            &nbsp;</td>
        <td class="auto-style7">
            &nbsp;</td>
        <td class="auto-style6">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">
            <asp:Button ID="ButtonEmpSubmit" runat="server" Text="Submit" OnClick="ButtonEmpSubmit_Click" />
        </td>
        <td class="auto-style3">
            <input id="Reset1" type="reset" value="reset" /></td>
        <td class="auto-style8">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>

