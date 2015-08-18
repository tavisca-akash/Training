<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HtmlWidget.ascx.cs"
    Inherits="SampleWidgets.Login" %>
<asp:Panel ID="Settings" runat="server" Style="width: auto; height: 250px;" Visible="false">
    <div>
        <textarea id="Editor" rows="5" cols="50" runat="server" style="width: 99%; margin-left: 5px;
            height: 210px;"></textarea>
    </div>
    <div>
        <asp:Button ID="btnSaveSettings" runat="server" Style="float: left;" OnClick="btnSaveSettings_Click"
            Text="Save" EnableViewState="false" />&nbsp;
    </div>
</asp:Panel>
<asp:Panel ID="H" runat="server" EnableViewState="false">
    <asp:Literal ID="ltrOutput" runat="server" EnableViewState="false"></asp:Literal>
</asp:Panel>
