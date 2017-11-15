using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Upload
{
	public partial class WebForm1 : System.Web.UI.Page
	{

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void UploadButton_Click(object sender, EventArgs e)
		{
			if (FileUploadControl.HasFile)
			{
				try
				{
					if (FileUploadControl.PostedFile.ContentType == "application/json")
					{
						string filename = Path.GetFileName(FileUploadControl.FileName);
						FileUploadControl.SaveAs(Server.MapPath("~/") + filename);
						StatusLabel.Text = "Upload status: File uploaded to " + Server.MapPath("~/") + filename;
					}else
					{
						StatusLabel.Text = "Upload status. File type not supported, only JSON files are allowed.";
					}
				}
				catch (Exception ex)
				{
					StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
				}
			}
		}
	}
}