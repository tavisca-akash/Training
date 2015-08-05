using AuthenticationForm.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuthenticationForm
{
    public partial class Userspx : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string email = Session["email"].ToString();
                int id=int.Parse(Session["Id"].ToString());
                //Employee empObject = ((Model.Session.Employee)Session["Response"]).ToServer();
                if (Page.IsPostBack == false)
                {
                    
                    HttpClient client = new HttpClient();
                    var response = client.GetData<RemarkCount>("http://localhost:53412/EmployeeService.svc" + "/remarkCount/" + id + " ", "application/json");
                    GridView.VirtualItemCount = Convert.ToInt32(response.totalRemark);
                   // HttpClient client = new HttpClient();
                    var response1 = client.GetData<EmployeeResponse>("http://localhost:53412/EmployeeService.svc" + "/employee/" + id + "/" + 1 + "", "application/json");
                    GridView.DataSource = response1.Employee.Remarks;
                    GridView.DataBind();
                }
            }
            catch (Exception)
            {
                FormsAuthentication.RedirectToLoginPage();

            }

        }


        protected void ButtonLogout_Click(object sender, EventArgs e)
        {
            Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
            Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);
            Session.Abandon();
            Response.Redirect("~/Account/Login.aspx");
        }

        protected void ButtonChangePassword_Click(object sender, EventArgs e)
        {
           Response.Redirect("~/PasswordChange.aspx");
        }


        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //Employee empObject = ((Model.Session.Employee)Session["Response"]).ToServer();
            int pageNo = e.NewPageIndex;
            int id = int.Parse(Session["Id"].ToString());
            HttpClient client = new HttpClient();
            var response = client.GetData<EmployeeResponse>("http://localhost:53412/EmployeeService.svc" + "/employee/" + id + "/" + pageNo + "", "application/json");
            GridView.PageIndex = pageNo;
            GridView.DataSource =response.Employee.Remarks;
            GridView.DataBind();
        }

        protected void GridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}