using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tavisca.Templar.Contract;
using RollBasedAccess;
using System.Web.Security;

namespace EMSWidgets
{
    public partial class LoginWebControl : System.Web.UI.UserControl,IWidget
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
            pnlSettings.Visible = true;
            //throw new NotImplementedException();
        }

        protected void ButtonChangePassword_Click(object sender, EventArgs e)
        {
            Credentials credential = new Credentials();
            credential.EmailId = TextBoxUserName.Text;
            credential.Password = TextBoxPassword.Text;
            Session["Email"] = TextBoxUserName.Text;

            //--Authenticaton--//
            var res = Credentials.Authenticate(credential);
            FormsAuthentication.SetAuthCookie(credential.EmailId.Trim(), false);
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, credential.EmailId.Trim(), DateTime.UtcNow, DateTime.UtcNow.AddMinutes(10), false, res.Employee.Designation.Trim().ToLower());
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket));
            Response.Cookies.Add(cookie);
           
            if (res.Status.StatusCode == "200")
            {
                Session["Id"] = res.Employee.Id;
                if (string.Equals(res.Employee.Title, "Hr", StringComparison.CurrentCultureIgnoreCase))
                    Response.Redirect("HRHomePage");
                else
                {
                    Response.Redirect("DisplayRemarks");
                }

            }
         
        }

       
    }
}