using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Net;
using System.IO;
using System.Runtime.Serialization.Json;
using AuthenticationForm.Model;
using System.Data.SqlClient;
using System.Data;
using System.Web.Security;
namespace AuthenticationForm
{
    public partial class LoginUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
                {
                    UsernameTextbox.Text = Request.Cookies["UserName"].Value;
                    PasswordTextbox.Attributes["value"] = Request.Cookies["Password"].Value;
                    
                }
            }
        }
        protected void LoginButton_Click(object sender, EventArgs e)
        {


            if (CheckBox1.Checked)
            {
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(30);
                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(30);
            }
            else
            {
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);

            }
            Response.Cookies["UserName"].Value = UsernameTextbox.Text.Trim();
            Response.Cookies["Password"].Value = PasswordTextbox.Text.Trim();

         

              FormsAuthentication.Initialize();
              Credentials credentials = new Credentials();
              credentials.EmailId = UsernameTextbox.Text;
             credentials.Password = PasswordTextbox.Text;
            try
            {
                HttpClient client = new HttpClient();
                var empResponse = client.UploadData<Credentials, EmployeeResponse>("http://localhost:53412/EmployeeManagementService.svc" + "/login", credentials);
                HttpCookie cookie = new HttpCookie("UserCredentials");
                cookie["Email"] = empResponse.Employee.Password;
      
                Response.Cookies.Add(cookie);
                if (empResponse != null)
                {
                    Session["FirstName"] = empResponse.Employee.FirstName;
                    Session["Email"] = empResponse.Employee.Email;
                    Session["Id"] = empResponse.Employee.Id;
                    if (empResponse.Employee.Title.Equals("Hr"))
                        Response.Redirect("~/HRPage.aspx");
                    else if (empResponse.Employee.Title.Equals("Employee"))
                        Response.Redirect("~/UsersPAge.aspx");
                
                }
            }
            catch (Exception) { }
        }
        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}