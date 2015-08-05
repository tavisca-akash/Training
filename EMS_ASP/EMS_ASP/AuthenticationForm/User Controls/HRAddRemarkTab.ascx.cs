using AuthenticationForm.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuthenticationForm
{
    public partial class HRAddRemarkTab : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                Dictionary<string, string> empDictionary = new Dictionary<string, string>();
                var client = new HttpClient();
                //client.Headers.Add("Content-Type", "application/json");

                //  var employeeList = client.DownloadData("http://localhost:53412/EmployeeService.svc/employee");
                var employeeList = client.GetData<GetAllEmployee>("http://localhost:53412/EmployeeService.svc/employee");
                foreach (Employee employee in employeeList.AllEmployeeList)
                {
                    empDictionary.Add(employee.Id, employee.FirstName + "  " + employee.LastName);
                }
                DropDownListEmployee.DataTextField = "Value";
                DropDownListEmployee.DataValueField = "Key";
                DropDownListEmployee.DataSource = empDictionary;
                DropDownListEmployee.DataBind();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            Employee employee = new Employee();
            Remark remark = new Remark();
            //employee.Id = TextBoxEmployee.Text;
            remark.Text = TextBoxRemark.Text;
            int index = DropDownListEmployee.SelectedIndex;
            employee.Id = DropDownListEmployee.SelectedValue;              
            remark.CreateTimeStamp=DateTime.UtcNow;// ToUtcDateTime() 

            int employeeId = Convert.ToInt32(DropDownListEmployee.SelectedValue);
            remark.Text = TextBoxRemark.Text;
            remark.CreateTimeStamp = DateTime.UtcNow;
            HttpClient client = new HttpClient();
            var empRespone = client.UploadData<Remark, RemarkResponse>("http://localhost:53412/EmployeeManagementService.svc" + "/employee/" + employeeId + "/remark", remark);
           // Label2.Text = "Success!!";
            TextBoxRemark.Text = "";
            DropDownListEmployee.SelectedIndex = -1;

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
           
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