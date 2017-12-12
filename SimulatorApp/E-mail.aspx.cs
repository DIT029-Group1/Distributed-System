/* @author Yazan Alsahhar */ 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Net.Mail;

public partial class E_mail : System.Web.UI.Page
{
    protected void Send_Click(object sender, EventArgs e)
    {
        MailMessage msg = new MailMessage();
        msg.From = new MailAddress("dit029management@gmail.com");
        msg.To.Add(new MailAddress(TextEmail.Text));
        msg.Subject = "Sequence diagram's photo";
        String body = "Hi there, here's your file!"
            + Environment.NewLine + Environment.NewLine + "Best regards,"
            + Environment.NewLine + "Dit029 Management.";

        msg.Body = body;
        msg.IsBodyHtml = false;

        if (FileUpload.HasFile)
        {
            msg.Attachments.Add(new Attachment(FileUpload.PostedFile.InputStream, FileUpload.FileName));
            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("dit029management@gmail.com", "dit12345");
            smtp.EnableSsl = true;
            smtp.Send(msg);
            Label2.Text = "The file has been sent!";
        }
        else
        {
            Label2.Text = "Please upload a file!";
        }
    }
}