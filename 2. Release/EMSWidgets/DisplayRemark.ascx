<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayRemark.ascx.cs" Inherits="EMSWidgets.DisplayRemark1" %>
<%@ Register Assembly="Tavisca.Templar.WebControls" Namespace="Tavisca.Templar.WebControls" TagPrefix="gtc" %>

<asp:Panel ID="pnlSettings" runat="server" Visible="true">
    <asp:Table runat="server" Visible="true" Enabled="False">
    <asp:TableRow>
        <asp:TableCell><gtc:TemplarLabel ID="TemplarLabel1" runat="server" Text="Employee" /></asp:TableCell>
        <asp:TableCell> <asp:TextBox ID="TextBoxEmployee" runat="server" ></asp:TextBox></asp:TableCell>
        <asp:TableCell>
            <asp:Label ID="LabelUserName" runat="server" Text=""></asp:Label>
        </asp:TableCell>
        <asp:TableCell>
            <a href="Logout">Logout</a> 
        </asp:TableCell>
    </asp:TableRow>
        
    </asp:Table>
    <asp:Label ID="Label2" runat="server" Text="Remarks"></asp:Label><asp:GridView ID="GridView" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="True" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" OnSelectedIndexChanged="GridView_SelectedIndexChanged" PageSize="3" CellSpacing="2" AllowCustomPaging="True">
                 
                       <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FFF1D4" />
                    <SortedAscendingHeaderStyle BackColor="#B95C30" />
                    <SortedDescendingCellStyle BackColor="#F1E5CE" />
                    <SortedDescendingHeaderStyle BackColor="#93451F" />
                </asp:GridView>
        
</asp:Panel>