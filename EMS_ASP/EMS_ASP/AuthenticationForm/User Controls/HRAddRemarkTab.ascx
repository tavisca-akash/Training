<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HRAddRemarkTab.ascx.cs" Inherits="AuthenticationForm.HRAddRemarkTab" %>
<style type="text/css">
    #Reset1 {
        text-align: left;
        width: 74px;
        margin-left: 38px;
    }
    .auto-style1 {
        width: 95%;
        height: 102px;
    }
    .auto-style3 {
        width: 167px;
    }
    .auto-style5 {
        width: 153px;
        height: 56px;
        text-align: right;
    }
    .auto-style6 {
        width: 167px;
        height: 56px;
    }
    .auto-style7 {
        width: 153px;
        text-align: right;
    }
    #TextArea1 {
        height: 35px;
        width: 182px;
    }
</style>

<table class="auto-style1">
    <tr>
        <td class="auto-style5">Select Employee:</td>
        <td class="auto-style6">
            <asp:DropDownList ID="DropDownListEmployee" runat="server" Height="27px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Width="166px" style="margin-bottom: 0px">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Button ID="ButtonLogout" runat="server" OnClick="ButtonLogout_Click" style="text-align: right" Text="Logout" />
        </td>
    </tr>
    <tr>
        <td class="auto-style7">Enter Remark:</td>
        <td class="auto-style3">
            
    <asp:TextBox ID="TextBoxRemark" runat="server" Height="35px" Width="158px"></asp:TextBox></td>
    </tr>
    <tr>
       <td class="auto-style2">
            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
        </td>
        <td class="auto-style3">
            &nbsp;</td>
    </tr>
</table>

