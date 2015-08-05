<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HRAddRemarkPage.aspx.cs" Inherits="AuthenticationForm.HRAddRemark" %>

<%@ Register Src="~/User Controls/HRAddRemarkTab.ascx" TagPrefix="uc1" TagName="HRAddRemarkTab" %>


<%--<%@ Register Src="~/HRAddRemarkTab.ascx" TagPrefix="uc1" TagName="HRAddRemarkTab" %>--%>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
      <div class="container">
  <ul class="nav nav-tabs">
   
      <li><a href="HRAddEmployeeTabPage.aspx">AddEmployee</a></li>
    <li><a href="HRAddRemarkPage.aspx">AddRemark</a></li>
      <li><a href="PasswordChange.aspx">ChangePassword</a></li>
      
    

      <li></li>
      
    

  </ul>
          <uc1:HRAddRemarkTab runat="server" ID="HRAddRemarkTab" />
    <%--<uc1:HRAddRemarkTab runat="server" ID="HRAddRemarkTab" />--%>
      </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
