using MySql.Data.MySqlClient;
using System;
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
    private TcpToErlang t = null;
    private int copyNumber = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            //userIP.displayIP(DataList1);
            //Response.AppendHeader("Refresh", "3");
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        userIP.displayIP(DataList1);
    }

    protected void send(object sender, EventArgs e)
    {
        t = new TcpToErlang();
        t.sendMessage("start");
    }

    protected String getFolderNameFromIp(String ip)
    {
        int hashedIP = ip.GetHashCode();
        string folderName = hashedIP.ToString();
        return folderName;

    }

    protected void uploadFile(object sender, EventArgs e)
    {
        if (FileUpload.HasFile)
        {
            try
            {
                string filename = Path.GetFileName(FileUpload.FileName);
                string extension = Path.GetExtension(filename);

                // if (extension.ToLower() == ".json") {
                string ip = "192.1.45.189";
                string folderName = getFolderNameFromIp(ip);
                string folderPath = Server.MapPath("Uploads");

                //Checking if a directory for that user exists if not create one
                if (!Directory.Exists(folderName))
                {
                    Directory.CreateDirectory(new Uri(folderPath + @"\" + folderName).LocalPath);
                }

                string curFile = Server.MapPath("~/Uploads/" + folderName + "/") + filename;
                bool state = File.Exists(curFile) ? true : false;

                if (state)
                {
                    string nameWithoutExtension = Path.GetFileNameWithoutExtension(filename);
                    string fileNum = Convert.ToString(copyNumber);
                    string filecopy = string.Concat(nameWithoutExtension, "-Copy") + fileNum;
                    FileUpload.SaveAs(Server.MapPath("~/Uploads/" + folderName + "/") + filecopy + extension);
                    copyNumber++;
                }
                else
                {
                    FileUpload.SaveAs(Server.MapPath("~/Uploads/" + folderName + "/") + filename);
                }
            }
            /**else
            {
                //display message
            }
        }**/

            catch (Exception ex)
            {
                string errorMsg = "Error";
                errorMsg += ex.Message;
                throw new Exception(errorMsg);
            }
        }
    }

    protected void restartProcess(object sender, EventArgs e)
    {
        Process[] processlist = Process.GetProcesses();


        foreach (Process p in processlist)
        {
            if (p.ProcessName == "node")
            {
                p.Kill();
                p.WaitForExit();
            }
            //Response.Write(process.ProcessName + "<br>");
        }

        Process process = new Process();
        process.StartInfo.WorkingDirectory = "c:\\Users\\Murat Kan\\Desktop\\serverside";
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.FileName = "cmd.exe";
        process.StartInfo.Arguments = "/c node listen.js";
        process.StartInfo.CreateNoWindow = true;
        process.StartInfo.RedirectStandardInput = true;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.Start();
        //string output = si.StandardOutput.ReadToEnd();
        process.Close();
        //Response.Write(output);
    }
}