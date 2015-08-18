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
    public partial class AddEmployee : System.Web.UI.UserControl,IWidget
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            Employee employee = new Employee();
            employee.Phone = TextBoxPhoneNo.Text;
            employee.FirstName = TextBoxFirstName.Text;
            employee.LastName = TextBoxLastName.Text;
            employee.Title = TextBoxDesignation.Text;
            employee.Email = TextBoxEmail.Text;
            EmployeeResponse.Save(employee);
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
           // throw new NotImplementedException();
        }
    }
}