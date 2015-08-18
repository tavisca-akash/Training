using System;
using System.Xml.Linq;
using Tavisca.Templar.Contract;

namespace SampleWidgets
{
    public partial class Login : System.Web.UI.UserControl, IWidget
    {
        private IWidgetHost Host { get; set; }

        public void ShowSettings()
        {
            this.ltrOutput.Visible = false;
            this.Settings.Visible = true;
            this.Editor.InnerText = this.Host.GetState();
        }

        public void HideSettings()
        {
            this.ltrOutput.Visible = true;
            this.Settings.Visible = false;
        }

        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            this.Host.SaveState(this.Editor.Value);
            this.Host.HideSettings();
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            this.ltrOutput.Text = this.Host.GetState();
        }
                
        public void Init(Tavisca.Templar.Contract.IWidgetHost host)
        {
            this.Host = host;
        }
    }
}