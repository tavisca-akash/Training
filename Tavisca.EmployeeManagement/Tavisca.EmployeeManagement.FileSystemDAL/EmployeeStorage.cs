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
        readonly string EXTENSION = ".emp";

        public Model.Employee Save(Model.Employee employee)
        {
            try
            {

                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = "Data Source=TRAINING3;Initial Catalog=EmployeeDataBase;User ID=sa;Password=test123!@#";
                    conn.Open();
                    SqlCommand insertCommand = new SqlCommand("INSERT INTO EmployeeDetails (Id , Title, FirstName, LastName,Email,Phone) VALUES (@0, @1, @2, @3,@4,@5)", conn);
                    insertCommand.Parameters.Add(new SqlParameter("0", employee.Id));
                    insertCommand.Parameters.Add(new SqlParameter("1", employee.Title));
                    insertCommand.Parameters.Add(new SqlParameter("2", employee.FirstName));
                    insertCommand.Parameters.Add(new SqlParameter("3", employee.LastName));
                    insertCommand.Parameters.Add(new SqlParameter("4", employee.Email));
                    insertCommand.Parameters.Add(new SqlParameter("5", employee.Phone));
                    insertCommand.ExecuteNonQuery();
                }

            }
            catch(Exception ex)
            {
                
            }
            return employee;
        }

        public Model.Employee Get(string employeeId)
        {
            try
            {
                Model.Employee employee = new Model.Employee();
                using (SqlConnection conn = new SqlConnection())
                {
                    string employeeString = "";
                    conn.ConnectionString = "Data Source=TRAINING3;Initial Catalog=EmployeeDataBase;User ID=sa;Password=test123!@#";
                    conn.Open();
                    SqlCommand command = new SqlCommand("SELECT * FROM EmployeeDetails where (Id=@0)", conn);
                    // Add the parameters.
                    command.Parameters.Add(new SqlParameter("0", employeeId));
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                       
                        while (reader.Read())
                        {
                            employee.Id=reader[0].ToString();
                            employee.Title = reader[1].ToString() ;
                            employee.FirstName = reader[2].ToString();
                            employee.LastName = reader[3].ToString() ;
                            employee.Email = reader[4].ToString();
                            employee.Phone = reader[5].ToString();
                        }
                    }
                    return employee;
                }
            }
            catch (Exception ex)
            {
                var rethrow = ExceptionPolicy.HandleException("data.policy", ex);
                if (rethrow) throw;
                return null;
            }
        }
        public List<Model.Employee> GetAll()
        {
            try
            {
                SqlConnection conn = new SqlConnection();
                List<Model.Employee> emplist = new List<Model.Employee>();
                Model.Employee employee = new Model.Employee();
                conn.ConnectionString = "Data Source=TRAINING3;Initial Catalog=EmployeeDataBase;User ID=sa;Password=test123!@#";
                conn.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM EmployeeDetails ", conn);
                SqlDataReader reader = command.ExecuteReader();
                while(reader.Read())
                {
                    employee.Id=reader[0].ToString();
                            employee.Title = reader[1].ToString() ;
                            employee.FirstName = reader[2].ToString();
                            employee.LastName = reader[3].ToString() ;
                            employee.Email = reader[4].ToString();
                            employee.Phone = reader[5].ToString();
                            emplist.Add(employee);           
                }

                return emplist;

                
            }
            catch (Exception ex)
            {
                var rethrow = ExceptionPolicy.HandleException("data.policy", ex);
                if (rethrow) throw;
                return null;
            }
        }

        private string GetFileName(string employeeId)
        {
            return string.Format(@"{0}\{1}.emp", Configurations.StoragePath, employeeId);
        }
    }
}
