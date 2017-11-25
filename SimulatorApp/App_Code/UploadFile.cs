using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for UploadFile
/// </summary>
public class UploadFile
{
    private MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
    private UserIP ip = new UserIP();

    private static int copyNumber = 1;

    public UploadFile()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public void uploadFile(FileUpload fileupload)
    {
        conn.Open();
        string userIP = ip.getIP();
        MySqlCommand cmd = null;
        int port = Int32.Parse(getSingelValue("port", "files", " ORDER BY port DESC LIMIT 1"));
        port += 1;

        if (fileupload.HasFile)
        {
            try
            {
                string filename = Path.GetFileName(fileupload.FileName);
                string nameWithoutExtension = Path.GetFileNameWithoutExtension(filename);
                string extension = Path.GetExtension(filename);
                
                if (extension.ToLower() == ".json")
                {

                    //Create a folder name from the ip of the user
                    string folderName = userIP.GetHashCode().ToString();
                    string folderPath = System.Web.HttpContext.Current.Server.MapPath("Uploads");

                    string savedPath = "C:/inetpub/wwwroot/SimulatorApp/Uploads/" + folderName;

                    //Checking if a directory for that user exists if not create one
                    if (!Directory.Exists(folderName))
                    {
                        Directory.CreateDirectory(new Uri(folderPath + @"\" + folderName).LocalPath);
                    }

                    string curFile = System.Web.HttpContext.Current.Server.MapPath("~/Uploads/" + folderName + "/") + filename;
                    string folderAndFile = "./Uploads/" + folderName + "/" + filename;
                    bool state = File.Exists(curFile) ? true : false;

                    if (state)
                    {
                        string fileNum = Convert.ToString(copyNumber);
                        string filecopy = string.Concat(nameWithoutExtension, "-Copy") + fileNum;

                        fileupload.SaveAs(System.Web.HttpContext.Current.Server.MapPath("~/Uploads/" + folderName + "/") + filecopy + extension);
                        createNodejsServer(folderName + "/", filecopy, port);

                        String sql = "INSERT INTO files(filePath, completeFilePath, json, js, port) VALUES ('" + savedPath.ToString() + "/', '" + folderAndFile + "', '" + filecopy + ".json', '" + filecopy  + ".js', '" + port +"')";
                        cmd = new MySqlCommand(sql, conn);

                        copyNumber++;
                    }
                    else
                    {
                        fileupload.SaveAs(System.Web.HttpContext.Current.Server.MapPath("~/Uploads/" + folderName + "/") + filename);
                        createNodejsServer(folderName + "/", nameWithoutExtension, port);

                        String sql = "INSERT INTO files(filePath, completeFilePath, json, js, port) VALUES ('" + savedPath.ToString() + "', '" + folderAndFile + "', '" + nameWithoutExtension + ".json', '" + nameWithoutExtension + ".js', '" + port + "')";
                        cmd = new MySqlCommand(sql, conn);

                    }

                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        string errorMsg = "Error";
                        errorMsg += ex.Message;
                        throw new Exception(errorMsg);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
                else
                {
                    //display message
                }
            }

            catch (Exception ex)
            {
                string errorMsg = "Error";
                errorMsg += ex.Message;
                throw new Exception(errorMsg);
            }
        } 
    }

    public void displayFile(DataList datalist)
    {
        DataTable dt = new DataTable();
        using (conn)
        {
            MySqlDataAdapter ad = new MySqlDataAdapter("SELECT * FROM files", conn);
            ad.Fill(dt);
        }

        datalist.DataSource = dt;
        datalist.DataBind();

        conn.Close();
    }

    protected void createNodejsServer(string path, string file, int Port)
    {
        using (StreamWriter jsFile = new StreamWriter(System.Web.HttpContext.Current.Server.MapPath("~/Uploads/" + path + file + ".js"), true))
        {
            jsFile.Write("var net = require('net'),http = require('http'),fs = require('fs'),data = '';" +
                "net.createServer(function (socket) " +
                "{socket.setEncoding('utf8');" +
                "socket.on('data', function (chunk) {data += '<br>' + chunk;});" +
                "}).listen(" + Port + ", 'localhost');" +
                "http.createServer(function (req, res) " +
                "{res.writeHead(200, " +
                "{'Content-Type': 'text/html','Access-Control-Allow-Origin': '*'," +
                "'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE'," +
                "'Access-Control-Allow-Headers': 'X-Requested-With,content-type'," +
                "'Access-Control-Allow-Credentials': 'true'});" +
                "res.write(data);" +
                "res.end();}).listen(" + Port + ");");
        }
    }

    public string getSingelValue(string column, string table, string other)
    {
        string query = "SELECT " + column + " FROM " + table + other;
        string result = "";

        MySqlCommand cmd = new MySqlCommand(query, conn);
        MySqlDataReader rdr = cmd.ExecuteReader();

        if (rdr.HasRows)
        {
            if (rdr.Read())
            {
                result = rdr[column].ToString();
            }
        }
        else
        {
            result = "8089";
        }

        rdr.Close();

        return result;
    }

}