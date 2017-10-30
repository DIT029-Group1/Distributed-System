using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Sockets;

namespace ProjectSprint4TCP
{
	public partial class WebForm1 : System.Web.UI.Page
	{
		string serverIp = "localhost";
		int port = 8080;

		protected void Page_Load(object sender, EventArgs e)
		{
			TcpClient client = new TcpClient(serverIp, port);

			int byteCount = Encoding.ASCII.GetByteCount("message");

			byte[] sendData = new byte[byteCount];

			sendData = Encoding.ASCII.GetBytes("message");

			NetworkStream stream = client.GetStream();

			stream.Write(sendData, 0, sendData.Length);

			stream.Close();
			client.Close();

		}
	}
}