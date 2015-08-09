using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mvc__EMS.Models;
using RollBasedAccess;
using System;
using WebMatrix.WebData;


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
        public ActionResult LoginPage(Login model)
        {

            return View("LoginView");
        }
        [HttpPost ]
        public ActionResult LoginPage1(Login model)
        {
           
            Credentials credential = new Credentials();
            credential.EmailId = model.UserName;
            credential.Password = model.Password;
            var res=Credentials.Authenticate(credential);
            if (res.Status.StatusCode == "200")
            {

                HttpCookie cookie = new HttpCookie("Cookie");
                cookie["UserName"] = credential.EmailId;
                cookie["Title"] = res.Employee.Title;
                cookie.Expires.AddDays(30);
                HttpContext.Response.Cookies.Add(cookie);

                ViewBag.MyCookie = cookie;
                
                    if (string.Equals(res.Employee.Title, "Hr", StringComparison.CurrentCultureIgnoreCase))
                        return RedirectToAction("HRProfile", "HR");
                    else
                    {
                        TempData["Id"] = res.Employee.Id;
                        return RedirectToAction("GetEmployees", "HR");
                    }
                
            }
            return View("LoginView");
        }
    }
}
