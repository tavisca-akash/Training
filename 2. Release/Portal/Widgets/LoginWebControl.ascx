<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginWebControl.ascx.cs" Inherits="EMSWidgets.LoginWebControl" %>
<%@ Register Assembly="Tavisca.Templar.WebControls" Namespace="Tavisca.Templar.WebControls" TagPrefix="gtc" %>

<asp:Panel ID="pnlSettings" runat="server" Visible="true">
<gtc:TemplarLabel ID="Calculator" runat="server" Text="Login"></gtc:TemplarLabel>

<asp:Table ID="Table1" runat="server" Visible="true">
 
 
    <asp:TableRow>
       <asp:TableCell><gtc:TemplarLabel ID="TemplarLabel2" runat="server" Text="User Name:" /></asp:TableCell>
        <asp:TableCell> <asp:TextBox ID="TextBoxUserName" runat="server"></asp:TextBox></asp:TableCell>

    </asp:TableRow>

      <asp:TableRow>
       <asp:TableCell><gtc:TemplarLabel ID="TemplarLabel3" runat="server" Text="Password:"  /></asp:TableCell>
       <asp:TableCell> <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password"></asp:TextBox></asp:TableCell>

    </asp:TableRow>
    <asp:TableRow>
       <asp:TableCell><gtc:TemplarButton ID="ButtonChangePassword" runat="server" Text="Submit" OnClick="ButtonChangePassword_Click"/></asp:TableCell>
      

    </asp:TableRow>

</asp:Table>
</asp:Panel>
