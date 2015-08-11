
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mvc__EMS.Models;
using RollBasedAccess;


namespace Mvc__EMS.Controllers
{
    public class HRController : Controller
    {
        //
        // GET: /HR/
        
        public ActionResult Index()
        {
            return View();
        }
       [Authorize(Roles = "Hr")]
        public ActionResult GotoAddEmployee(AddEmployee model)
        {
          
            return View("AddEmployeeView");
           
        }
       [Authorize(Roles = "Hr")]
        public ActionResult SaveEmployee(Employee employee)
        {
            if (ModelState.IsValid)
            {
                EmployeeResponse.Save(employee);
                return View("AddEmployeeView");
            }
            else
            {
                return RedirectToAction("LoginPage","Login");
            }
        }

        [Authorize(Roles = "Hr")]
        public ActionResult HRProfile(Employee employee)
        {

            //if(!Request.Form["UserName"].Equals(""))
                return View("HRProfileView");
            //return RedirectToAction("LoginPAge","Logn");
            
        }
      [Authorize(Roles = "Hr")]
        public ActionResult AddRemark(AddEmployee model)
        {
            GetAllEmployee response = GetAllEmployee.GetAllEmployeeDetails();
            

                List<SelectListItem> empList = new List<SelectListItem>();
                foreach (var employee in response.AllEmployeeList)
                {
                    empList.Add(new SelectListItem { Value = employee.Id, Text = employee.FirstName + "  " + employee.LastName });
                  
                }
                ViewData["EmpList"] = empList;
              
            
            return View("AddRemarkView");
        }

     [Authorize(Roles = "Hr")]
        public ActionResult SaveRemark(AddRemark model)
        {
            Remark remark = new Remark();
            string id = Request["Employee"];
            remark.Text = model.Remark;
            remark.CreateTimeStamp = Convert.ToDateTime(DateTime.UtcNow);
            RemarkResponse.AddRemark(id, remark);
            return View("HRProfileView");
        }

         [Authorize(Roles = "Employee")]
        public ActionResult GetEmployees(EmployeeModel model,int page=1)
        {
            EmployeeModel emp = new EmployeeModel();
              
           int   id= int.Parse(Session["Idd"].ToString());

           int totalPages;
           int pageSize = 3;
           var response = EmployeeResponse.GetAllRemarks(id,page);
           var responseRemark= RemarkCount.TotalRemarks(id);
           int totalRemarks = int.Parse(responseRemark.totalRemark);
           totalPages = (totalRemarks / pageSize) + ((totalRemarks % pageSize) > 0 ? 1 : 0);
            List<EmployeeModel> listEmployee = new List<EmployeeModel>();
         foreach (var remark in response.Employee.Remarks)
            {
                emp = new EmployeeModel();
                emp.Text = remark.Text;
                emp.CreateTimeStamps = remark.CreateTimeStamp.ToString();
                listEmployee.Add(emp);
            }
            ViewBag.totalPages = totalPages;
            ViewBag.TotalRemarks = totalRemarks;
            ViewBag.PageSize = 2;
            var data = listEmployee;
            return View(data);
        }
        
    }
}
