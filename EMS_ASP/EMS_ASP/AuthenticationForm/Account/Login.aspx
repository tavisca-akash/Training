<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AuthenticationForm.Account.Login" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<%@ Register Src="~/User Controls/LoginUserControl.ascx" TagPrefix="uc" TagName="LoginUserControl" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <br />
    <uc:LoginUserControl runat="server" ID="LoginUserControl" />

<br />
<br />
<br />
<br />

    </asp:Content>
