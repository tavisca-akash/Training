<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddRemark.ascx.cs" Inherits="EMSWidgets.DisplayRemark" %>
<%@ Register Assembly="Tavisca.Templar.WebControls" Namespace="Tavisca.Templar.WebControls" TagPrefix="gtc" %>

<asp:Panel ID="pnlSettings" runat="server" Visible="true">


<asp:Table ID="Table1" runat="server" Visible="true">
   
    <asp:TableRow>
        <asp:TableCell><gtc:TemplarLabel Text="Select Employee" runat="server"/></asp:TableCell>
        <asp:TableCell><gtc:TemplarDropDownList ID="DropdownlistEmployee" runat="server" Width="100px" /></asp:TableCell>
                  
    </asp:TableRow>
    
    <asp:TableRow>
        <asp:TableCell><gtc:TemplarLabel ID="TemplarLabel1" Text="Enter Remark" runat="server"/></asp:TableCell>
        <asp:TableCell><textarea id="TextAreaRemark" rows="2" cols="20" runat="server"></textarea></asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>
            <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" OnClick="ButtonSubmit_Click"/>
        </asp:TableCell>
    </asp:TableRow>
   
</asp:Table>
</asp:Panel>