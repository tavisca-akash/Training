using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tavisca.EmployeeManagement.Interface;
using Newtonsoft.Json;
using Tavisca.EmployeeManagement.ErrorSpace;
using Tavisca.EmployeeManagement.EnterpriseLibrary;
using System.Data;
using System.Data.SqlClient;

namespace Tavisca.EmployeeManagement.FileStorage
{
    public class EmployeeStorage : IEmployeeStorage
    {

        public Model.Employee Save(Model.Employee employee)
        {
            try
            {
                
              
                    SqlConnection con = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
                    con.Open();
                    SqlCommand cmd = new SqlCommand("Myprocedure", con);
                    cmd.CommandType = CommandType.StoredProcedure;


                    SqlParameter p2 = new SqlParameter("FirstName", employee.FirstName);
                    SqlParameter p3 = new SqlParameter("LastName", employee.LastName);
                    SqlParameter p4 = new SqlParameter("title", employee.Title);
                    SqlParameter p5 = new SqlParameter("Email", employee.Email);
                    SqlParameter p6= new SqlParameter("phno", employee.Phone);
                    SqlParameter p7 = new SqlParameter("Doj", employee.JoiningDate.ToString());
                    SqlParameter p8 = new SqlParameter("Password","test123!@#");
                    cmd.Parameters.Add(p2);
                    cmd.Parameters.Add(p3);
                    cmd.Parameters.Add(p4);
                    cmd.Parameters.Add(p5);
                    cmd.Parameters.Add(p6);
                    cmd.Parameters.Add(p7);
                    cmd.Parameters.Add(p8);

                    cmd.ExecuteNonQuery();
                    con.Close();
             
                return employee;


            }
            catch (Exception ex)
            {
                var rethrow = ExceptionPolicy.HandleException("data.policy", ex);
                if (rethrow) throw;
                return null;
            }
        }

        public Model.Employee Get(string employeeId,string pageNumber)
        {
            try
            {
                int flag=0;
                Model.Employee emp = new Model.Employee();
                List<Model.Remark> tempRemark = new List<Model.Remark>();
                SqlConnection conEmp = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
                SqlConnection conEmpRemark = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
                conEmp.Open();
                conEmpRemark.Open();
                SqlCommand cmd = new SqlCommand("GetbyId", conEmp);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@Id", employeeId));

                SqlDataReader empReader = cmd.ExecuteReader();
                while (empReader.Read())
                {
                    emp.Id = empReader[0].ToString();
                    emp.FirstName = empReader[2].ToString();
                    emp.LastName = empReader[3].ToString();
                    emp.Title = empReader[1].ToString();
                    emp.Email = empReader[4].ToString();
                    emp.Phone = empReader[5].ToString();
                    emp.JoiningDate = DateTime.Parse(empReader[6].ToString());


                    SqlCommand cmdRemark = new SqlCommand("GetRemarksByIdPagenated", conEmpRemark);
                    cmdRemark.CommandType = CommandType.StoredProcedure;
                    cmdRemark.Parameters.Add(new SqlParameter("@Id", emp.Id));
                    cmdRemark.Parameters.Add(new SqlParameter("@PageNumber", pageNumber));
                    SqlDataReader empRemarkReader = cmdRemark.ExecuteReader();

                    while (empRemarkReader.Read())
                    {
                        flag++;
                        Model.Remark remark = new Model.Remark();
                        remark.Text = empRemarkReader[3].ToString();
                        remark.CreateTimeStamp = Convert.ToDateTime(empRemarkReader[4].ToString());
                        tempRemark.Add(remark);
                    }
                }
                emp.Remarks = tempRemark;
                conEmp.Close();
                conEmpRemark.Close();
                return emp;
            }


            catch (Exception ex)
            {
                var rethrow = ExceptionPolicy.HandleException("data.policy", ex);
                if (rethrow) throw;
                return null;
            }
        }
        public Model.Remark SaveRemark(string employeeId, Model.Remark remark)
        {
           
              SqlConnection con = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
                    con.Open();
                    SqlCommand cmdRemark = new SqlCommand("AddRemark", con);
                    cmdRemark.CommandType = CommandType.StoredProcedure;

                   
                  
                        cmdRemark.Parameters.Add(new SqlParameter("@EmpId", employeeId));
                        cmdRemark.Parameters.Add(new SqlParameter("@Remark", remark.Text));
                        cmdRemark.Parameters.Add(new SqlParameter("@RemarkTime", remark.CreateTimeStamp));
                        cmdRemark.ExecuteNonQuery();

                   

                    con.Close();

                    return remark;
        }

        public List<Model.Employee> GetAll()
        {
            List<Model.Employee> empList = new List<Model.Employee>();
           


            SqlConnection con = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
            con.Open();
            SqlCommand cmd = new SqlCommand("GetAll ", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader empReader = cmd.ExecuteReader();

            while (empReader.Read())
            {
                Model.Employee emp = new Model.Employee();
                emp.Id = empReader[0].ToString();
                emp.FirstName = empReader[1].ToString();
                emp.LastName = empReader[2].ToString();
                emp.Title = empReader[3].ToString();
                emp.Email = empReader[4].ToString();
                emp.Phone = empReader[5].ToString();
                emp.JoiningDate = DateTime.Parse(empReader[6].ToString());
                empList.Add(emp);
            }
            con.Close();
            return empList;

        }

        public bool UpdatePassword(string oldPassword,string newPassword,string emailId)
        {
            EmployeeStorage storageObject = new EmployeeStorage();
            var employee =storageObject.Authenticate(emailId,oldPassword);
            if (employee == null)
            {
                return false;
            }

            SqlConnection con = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
            con.Open();
            SqlCommand cmd = new SqlCommand("UpdatePassword", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Password", newPassword));
            cmd.Parameters.Add(new SqlParameter("@Id", employee.Id));
            
            cmd.ExecuteNonQuery();
            con.Close();
            return true;
            
        }
        public Model.Employee Authenticate(string emailId, string password)
        {
            Model.Employee employee=new Model.Employee();
            SqlConnection con = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
            con.Open();
            SqlCommand cmd = new SqlCommand("Authenticate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@emailId",emailId));
            cmd.Parameters.Add(new SqlParameter("@password",password));
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
               EmployeeStorage storageObject= new EmployeeStorage();
               employee = storageObject.Get(dr[0].ToString(), "1");        
               return employee;
            }
            con.Close();
            return null;
        }
        public string CountRemark(string employeeId)
        {
            SqlConnection con = new SqlConnection("Data Source=Training3;Initial Catalog=Employee;Persist Security Info=True;User ID=sa;Password=test123!@#");
            con.Open();
            SqlCommand cmd = new SqlCommand("GetCount", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Id", employeeId));
            SqlDataReader dr = cmd.ExecuteReader();
            if(dr.Read())
            {
              return  dr[0].ToString();
 
            }
            return "0";
           
        }


    }
}
