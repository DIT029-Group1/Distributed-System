<%@ Page Language="C#" AutoEventWireup="true" CodeFile="E-mail.aspx.cs" Inherits="E_mail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SENDING AN E_MAIL WITH FILE ATTACHED</title>
    <link rel="stylesheet" href="css/style.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <p>

            <asp:Label ID="Label1" runat="server" Text="Please enter your E-mail address: " ForeColor="White"></asp:Label>
            <asp:TextBox ID="TextEmail" runat="server" Width="188px"></asp:TextBox>

        </p>
        <p>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ErrorMessage="Please enter an E-mail!" ControlToValidate="TextEmail"
                ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                runat="server" ErrorMessage="Please Enter Valid Email ID!"
                ControlToValidate="TextEmail" ForeColor="Red"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
            </asp:RegularExpressionValidator>
        </p>
        <p>
            <asp:FileUpload ID="FileUpload" runat="server" ForeColor="White" />
        </p>
        <p>
            <asp:Label ID="Label2" runat="server" ForeColor="White"></asp:Label>
        </p>
        <asp:Button ID="Send" runat="server" OnClick="Send_Click" Text="Send" />
    </form>
</body>
</html>
