<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>The Greatest Simulator Ever</title>
    <link rel="stylesheet" href="css/style.css" type="text/css" />

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
    <script src="js/screenShot.js"></script>
    <script src="js/popUp.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:FileUpload ID="FileUpload" runat="server" Style="display: none" />
        <asp:Button runat="server" ID="UploadButton" Style="display: none" Text="Upload" OnClick="UploadFile" />

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:Button runat="server" ID="btnStart" Style="display: none" OnClick="start" autopostback="false" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div>
            <div class="header">SEQUENCE DIAGRAM SIMULATOR</div>
            <div class="left">
                <div class="content3">
                    Device List:<br />
                    <br />
                    <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:Timer ID="Timer2" runat="server" Interval="1000" OnTick="Timer2_Tick"></asp:Timer>

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:DataList ID="DataList1" runat="server" RepeatDirection="Vertical">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"><%# Eval("ip") %></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>

                <div class="content3" id="uploads">
                    Uploaded Files
                <asp:UpdatePanel ID="pnlUploads" runat="server">
                    <ContentTemplate>
                        <asp:DataList ID="DataList2" runat="server" RepeatDirection="Vertical" OnItemCommand="DataList2_ItemCommand" >
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("json") %>'></asp:Label>

                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("port") %>' Style="display: none"></asp:Label>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("filePath") %>' Style="display: none"></asp:Label>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("js") %>' Style="display: none"></asp:Label>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("json") %>' Style="display: none"></asp:Label>

                                <asp:Button CommandName="chooseFile" Text="Choose" runat="server" OnClientClick='<%# String.Format("updateInfo(\"{0}\", \"{1}\")", Eval("completeFilePath"), Eval("port")) %>' />
                            </ItemTemplate>
                        </asp:DataList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer2" EventName="Tick" />
                    </Triggers>
                </asp:UpdatePanel>
                </div>
                <span id="mCount"></span>

                <div class="content3" id="nCount">Name of Nodes</div>
            </div>

            <div class="container">

                <div class="nav">
                    <ul>
                        <li>
                            <div class="upload" onclick="document.getElementById('<%= FileUpload.ClientID %>').click()"></div>
                        </li>
                        <li>
                            <div class="start" onclick="document.getElementById('<%= btnStart.ClientID %>').click()"></div>
                        </li>
                        <li>
                            <div class="capture" onclick="screenShot()"></div>
                        </li>
                        <li>
                            <div class="send" onclick="popUp('E-mail.aspx')"></div>
                        </li>
                    </ul>
                </div>

                <div class="sd">
                    <canvas id="SDCanvas"></canvas>
                </div>
            </div>

            <script type="text/javascript" src="js/parse.js"></script>
            <script src="js/simulator.js"></script>
            <script type="text/javascript">
                function UploadFile(fileUpload) {
                    if (fileUpload.value != '') {
                        document.getElementById("<%=UploadButton.ClientID %>").click();
                    }
                }
            </script>

        </div>
    </form>
</body>
</html>
