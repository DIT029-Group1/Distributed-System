<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>The Greatest Simulator Ever</title>
    <link rel="stylesheet" href="css/style.css" type="text/css" />

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>


</head>
<body>

    <form id="form1" runat="server">

        <div class="header">SEQUENCE DIAGRAM SIMULATOR</div>
        <div class="left">
            <div class="content1" id="mCount1"></div>
            <div class="content2" id="mCount2"></div>
            <div class="content3" id="nCount">Name of Nodes</div>
        </div>
        <div class="container">

            <asp:Button runat="server" ID="btnSend" Style="display: none" OnClick="send" />
            <asp:Button runat="server" ID="btnRestart" Style="display: none" OnClick="restartProcess" />

            <div class="nav">
                <ul>
                    <li>
                        <div class="upload"></div>
                    </li>
                    <li>
                        <div class="start" onclick="document.getElementById('<%= btnSend.ClientID %>').click()"></div>
                    </li>
                    <li>
                        <div class="pause"></div>
                    </li>
                    <li>
                        <div class="stopReset" onclick="document.getElementById('<%= btnRestart.ClientID %>').click()"></div>
                    </li>
                    <li>
                        <div class="capture"></div>
                    </li>
                    <li>
                        <div class="send"></div>
                    </li>
                </ul>
            </div>
            <div class="sd">
                <canvas id="SDCanvas"></canvas>
            </div>
        </div>
        <div class="right">
            <div class="device">
                Device List:<br />
                <br />
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>

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
        </div>
        <div class="footer">console log here</div>
        <script type="text/javascript" src="js/parse.js"></script>
        <script src="js/simulator.js"></script>

    </form>

</body>
</html>
