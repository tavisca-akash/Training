
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

        public ActionResult GotoAddEmployee(AddEmployee model)
        {
          
            return View("AddEmployeeView");
           
        }
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
        public ActionResult HRProfile(Employee employee)
        {

            
                return View("HRProfileView");
            
        }
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
        public ActionResult SaveRemark(AddRemark model)
        {
            Remark remark = new Remark();
            string id = Request["Employee"];
            remark.Text = model.Remark;
            remark.CreateTimeStamp = Convert.ToDateTime(DateTime.UtcNow);
            RemarkResponse.AddRemark(id, remark);
            return View("HRProfileView");
        }


        public ActionResult GetEmployees(EmployeeModel model)
        {
            EmployeeModel emp = new EmployeeModel();
            int id = int.Parse(TempData["Id"].ToString());
            var response =EmployeeResponse.GetAllRemarks(id,2);
            List<EmployeeModel> listEmployee = new List<EmployeeModel>();

            int totalPages = 2;
            int pageSize = 2;

            foreach (var remark in response.Employee.Remarks)
            {
                emp = new EmployeeModel();
                emp.Text = remark.Text;
                emp.CreateTimeStamps = remark.CreateTimeStamp.ToString();
                listEmployee.Add(emp);
            }
            ViewBag.TotalRows = pageSize;
            ViewBag.PageSize = totalPages;
            var data = listEmployee;
            return View(data);
        }
        
    }
}
