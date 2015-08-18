<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePasword.ascx.cs" Inherits="EMSWidgets.ChangePasword" %>
<%@ Register Assembly="Tavisca.Templar.WebControls" Namespace="Tavisca.Templar.WebControls" TagPrefix="gtc" %>

<%@ Register Assembly="Tavisca.Templar.WebControls" Namespace="Tavisca.Templar.WebControls" TagPrefix="gtc" %>

<asp:Panel ID="pnlSettings" runat="server" Visible="true">
<gtc:TemplarLabel ID="Calculator" runat="server" Text="Change Password"></gtc:TemplarLabel>

<asp:Table ID="Table1" runat="server" Visible="true">
 
    <asp:TableRow>
        <asp:TableCell><gtc:TemplarLabel runat="server" Text="Current Password:" /></asp:TableCell>
       <asp:TableCell> <asp:TextBox ID="TextBoxCurrentPassword" runat="server"></asp:TextBox></asp:TableCell>
       <%-- <asp:TableCell><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxUserName" ErrorMessage="User Name Required." ForeColor="Red"></asp:RequiredFieldValidator>
             </asp:TableCell>--%>

    </asp:TableRow>
    <asp:TableRow>
       <asp:TableCell><gtc:TemplarLabel ID="TemplarLabel1" runat="server" Text="New Password:" /></asp:TableCell>
        <asp:TableCell> <asp:TextBox ID="TextBoxNewPassword" runat="server"></asp:TextBox></asp:TableCell>

    </asp:TableRow>

      <asp:TableRow>
       <asp:TableCell><gtc:TemplarLabel ID="TemplarLabel2" runat="server" Text="New Password:" /></asp:TableCell>
       <asp:TableCell> <asp:TextBox ID="TextBoxConfirmPassword" runat="server"></asp:TextBox></asp:TableCell>

    </asp:TableRow>
    <asp:TableRow>
       <asp:TableCell><gtc:TemplarButton ID="ButtonChangePassword" runat="server" Text="Submit" OnClick="Submit_Clicked"/></asp:TableCell>
      

    </asp:TableRow>

</asp:Table>
</asp:Panel>
<%--<gtc:TemplarLabel ID="Tlabel" runat="server" Text="Name" ></gtc:TemplarLabel>--%>






  