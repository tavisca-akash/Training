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
    public partial class ChangePasword1 : System.Web.UI.UserControl,IWidget
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Submit_Clicked(object sender, EventArgs e)
        {
            string currentPasword = TextBoxCurrentPassword.Text;
            string NewPassword = TextBoxNewPassword.Text;
            string confrmPassword = TextBoxConfirmPassword.Text;
            Credentials credential = new Credentials();
            credential.EmailId = Session["Email"].ToString();
            credential.Password = currentPasword;
            var response = Credentials.Authenticate(credential);
            if (response.Status.StatusCode == "200" && NewPassword == confrmPassword)
            {
                RollBasedAccess.ChangePassword cp = new RollBasedAccess.ChangePassword();
                cp.EmailId = credential.EmailId;
                cp.OldPassword = currentPasword;
                cp.NewPassword = NewPassword;
                RollBasedAccess.ChangePassword.ChangePasword(cp);
            }
        }

        public void HideSettings()
        {
            
        }

        public new void Init(IWidgetHost host)
        {
           
        }

        public void ShowSettings()
        {
            pnlSettings.Visible = true;
        }
    }
}