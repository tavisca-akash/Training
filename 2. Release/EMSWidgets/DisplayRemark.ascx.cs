using RollBasedAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tavisca.Templar.Contract;

namespace EMSWidgets
{
    public partial class DisplayRemark1 : System.Web.UI.UserControl,IWidget
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string email = Session["Email"].ToString();
            int id = int.Parse(Session["Id"].ToString());
            LabelUserName.Text = email;
            //Employee empObject = ((Model.Session.Employee)Session["Response"]).ToServer();
            if (Page.IsPostBack == false)
            {
                var response = RemarkCount.TotalRemarks(id);
                GridView.VirtualItemCount = Convert.ToInt32(response.totalRemark);
                var response2 = EmployeeResponse.GetAllRemarks(id, 1);
                GridView.DataSource = response2.Employee.Remarks;
                GridView.DataBind();
                TextBoxEmployee.Text = response2.Employee.FirstName + " " + response2.Employee.LastName;
            }
        }

        public void HideSettings()
        {
           // throw new NotImplementedException();
        }

        public new void Init(IWidgetHost host)
        {
            //throw new NotImplementedException();
        }

        public void ShowSettings()
        {
            //throw new NotImplementedException();
        
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //Employee empObject = ((Model.Session.Employee)Session["Response"]).ToServer();
            int pageNo = e.NewPageIndex;
            int id = int.Parse(Session["Id"].ToString());
            HttpClient client = new HttpClient();
            var response = EmployeeResponse.GetAllRemarks(id, pageNo);
            GridView.PageIndex = pageNo;
            GridView.DataSource = response.Employee.Remarks;
            GridView.DataBind();
        }

        protected void GridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ButtonLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login");
        }

    }
}