<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Upload.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<form id="form1" runat="server">
		<asp:FileUpload id="FileUploadControl" runat="server" />
		<asp:Button runat="server" id="UploadButton" text="Upload" onclick="UploadButton_Click" />
		<br /><br />
		<asp:Label runat="server" id="StatusLabel" text="Upload status: " />
	</form>
</asp:Content>
