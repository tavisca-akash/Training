using AuthenticationForm.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuthenticationForm
{
    public partial class HRAddEmployeeTab : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ButtonEmpSubmit_Click(object sender, EventArgs e)
        {
            Employee employee = new Employee();
            employee.Title = TextBoxTitle.Text;
            employee.FirstName = TextBoxFirstName.Text;
            employee.LastName = TextBoxLastName.Text;
            employee.Email = TextBoxEmail.Text;
            employee.Phone = TextBoxPhone.Text;
            employee.Id = "";
            HttpClient client = new HttpClient();
            var empResponse = client.UploadData<Employee, EmployeeResponse>("http://localhost:53412/EmployeeManagementService.svc" + "/employee", employee);
           
        }

        protected void ButtonLogout_Click(object sender, EventArgs e)
        {
            Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
            Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);
            Session.Abandon();
            Response.Redirect("~/Account/Login.aspx");
        }

    }
}