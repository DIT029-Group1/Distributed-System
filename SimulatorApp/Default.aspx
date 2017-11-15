<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html>
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
		<asp:FileUpload ID="FileUpload" runat="server" style="display:none" />
		<asp:Button runat="server" ID="UploadButton" style="display:none" Text="Upload" OnClick="UploadFile" />
        <asp:Button runat="server" ID="btnStart" Style="display: none" OnClick="start" />

        <div class="header">SEQUENCE DIAGRAM SIMULATOR</div>
        <div class="left">
            <div class="content3">
                Device List:<br/> <br/>
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

            <div class="content3" id="uploads">Uploaded Files
                <asp:UpdatePanel ID="pnlUploads" runat="server">
                    <ContentTemplate>
                        <asp:DataList ID="DataList2" runat="server" RepeatDirection="Vertical" OnItemCommand="chooseFile">
                            <ItemTemplate>
                                <asp:label ID="Label1" runat="server"><%# Eval("json") %></asp:label>
                                <asp:Button Text="Choose" runat="server" OnClientClick='<%# Eval("completeFilePath", "updateInfo(\"{0}\"); return false;") %>' />
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

    </form>

</body>
</html>
