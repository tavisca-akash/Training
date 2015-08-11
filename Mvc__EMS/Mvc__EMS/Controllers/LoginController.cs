using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mvc__EMS.Models;
using RollBasedAccess;
using System;
using WebMatrix.WebData;
using System.Web.Security;


namespace Mvc__EMS.Controllers
{
    public class LoginController : Controller
    {
        //
        // GET: /Login/

        public ActionResult Index()
        {
            return View();
        }
        [AllowAnonymous]
        public ActionResult LoginPage(Login model)
        {

            return View("LoginView");
        }
       [HttpPost]
        public ActionResult Authenticate(Login model)
        {
           
            Credentials credential = new Credentials();
            credential.EmailId = model.UserName;
            credential.Password = model.Password;
            var res=Credentials.Authenticate(credential);
            if (res.Status.StatusCode == "200")
            {

                FormsAuthentication.SetAuthCookie(model.UserName.Trim(), false);
                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, model.UserName.Trim(), DateTime.UtcNow, DateTime.UtcNow.AddMinutes(10), false, res.Employee.Title.Trim());
                HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket));
                Response.Cookies.Add(cookie);
                    if(string.Equals(res.Employee.Title, "Hr", StringComparison.CurrentCultureIgnoreCase))
                        return RedirectToAction("HRProfile", "HR");
                    else
                    {
                        TempData["Id"] = res.Employee.Id;
                        Session["Idd"] = res.Employee.Id;
                        return RedirectToAction("GetEmployees", "HR");
                    }
                
            }
            return View("LoginView");
        }
    }
}
