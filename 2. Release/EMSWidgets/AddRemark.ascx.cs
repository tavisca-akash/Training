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
    public partial class DisplayRemark : System.Web.UI.UserControl,IWidget
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAllEmployee response = GetAllEmployee.GetAllEmployeeDetails();
            List<Employee> allEmployeeList = null;
            allEmployeeList = response.AllEmployeeList;
            Dictionary<string, string> dictionary = new Dictionary<string, string>();

            for (int i = 0; i < response.AllEmployeeList.Count(); i++)
            {
                Employee tempEmployee = allEmployeeList.ElementAt(i);
                dictionary.Add(tempEmployee.Id.Trim(), tempEmployee.Id.Trim() + "." + tempEmployee.FirstName.Trim() + " " + tempEmployee.LastName.Trim());
            }
            DropdownlistEmployee.DataTextField = "Value";
            DropdownlistEmployee.DataValueField = "Key";
            DropdownlistEmployee.DataSource = dictionary;
            DropdownlistEmployee.DataBind();
            //  DDLSelectEmployee.Items.Insert(0, new ListItem("--Select Employee--", "0"));
           
           
        }

        public void HideSettings()
        {
            //throw new NotImplementedException();
        }

        public new void Init(IWidgetHost host)
        {
            //throw new NotImplementedException();
        }

        public void ShowSettings()
        {
            //throw new NotImplementedException();
        }

        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            Employee employee = new Employee();
            Remark remark = new Remark();
            string employeeId = DropdownlistEmployee.SelectedValue;
            remark.Text = TextAreaRemark.Value;
            remark.CreateTimeStamp = DateTime.UtcNow;
            RemarkResponse.AddRemark(employeeId, remark);
        }
    }
}