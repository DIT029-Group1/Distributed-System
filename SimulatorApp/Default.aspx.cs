using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    private UserIP userIP = new UserIP();
    private TcpToErlang t = new TcpToErlang();
    private UploadFile uf = new UploadFile();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            FileUpload.Attributes["onchange"] = "UploadFile(this)";
        }

    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        userIP.displayIP(DataList1);
    }

    protected void Timer2_Tick(object sender, EventArgs e)
    {
        uf.displayFile(DataList2);
    }

    protected void start(object sender, EventArgs e)
    {
        t.sendMessage("start,8080,C:\\inetpub\\wwwroot\\SimulatorApp\\Uploads\\228070144\\,listen.js,data.json");
    }

    protected void UploadFile(object sender, EventArgs e)
    {
        uf.uploadFile(FileUpload);
    }

    protected void chooseFile(object sender, EventArgs e)
    {
        // Samer's part
        // * I have to be able to get path, files' names and port  when you finished your part ~Murat~*
    }


}