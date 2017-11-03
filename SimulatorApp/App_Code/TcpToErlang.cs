using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Web;

public class TcpToErlang
{
    private TcpClient client;
    private int byteCount;
    private byte[] sendData;
    private NetworkStream stream;

    private string serverIp = "192.168.0.104";
    private int port = 8080;

    public TcpToErlang()
    {
        client = new TcpClient(serverIp, port);
        this.byteCount = Encoding.ASCII.GetByteCount("");
        this.sendData = new byte[byteCount]; ;
        stream = client.GetStream();
    }

    public void sendMessage(string message)
    {
        sendData = Encoding.ASCII.GetBytes(message);
        stream.Write(sendData, 0, sendData.Length);
        stream.Close();
        client.Close();
    }

}