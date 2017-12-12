using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    private UserIP userIP = new UserIP();
    private TcpToErlang t = new TcpToErlang();
    private UploadFile uf = new UploadFile();

    private static string[] fileProperties = new string[4];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            FileUpload.Attributes["onchange"] = "UploadFile(this)";
        }
    }

    // Murat

    protected void start(object sender, EventArgs e)
    {
        t.sendMessage("start," + fileProperties[0] + "," + fileProperties[1] + "," + fileProperties[2] + "," + fileProperties[3]);
    }

    protected void UploadFile(object sender, EventArgs e)
    {
        uf.uploadFile(FileUpload);
    }

    // Murat

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        userIP.displayIP(DataList1);
    }

    // Murat

    protected void Timer2_Tick(object sender, EventArgs e)
    {
        uf.displayFile(DataList2);
    }

    // Murat

    protected void DataList2_ItemCommand(object source, DataListCommandEventArgs e)
    {
        Array.Clear(fileProperties, 0, fileProperties.Length);

        if (e.CommandName == "chooseFile")
        {
            Label port = ((Label) e.Item.FindControl("Label2"));
            Label filePath = ((Label)e.Item.FindControl("Label3"));
            Label js = ((Label)e.Item.FindControl("Label4"));
            Label json = ((Label)e.Item.FindControl("Label5"));

            fileProperties[0] = port.Text;
            fileProperties[1] = filePath.Text;
            fileProperties[2] = js.Text;
            fileProperties[3] = json.Text;            
        }
    }
}