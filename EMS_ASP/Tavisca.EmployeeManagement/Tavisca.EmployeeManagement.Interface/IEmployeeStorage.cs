using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tavisca.EmployeeManagement.Model;

namespace Tavisca.EmployeeManagement.Interface
{
    public interface IEmployeeStorage
    {
        Employee Save(Employee employee);
        Remark SaveRemark(string employeeId,Remark remark);
        Employee Get(string employeeId, string pageNo);
        bool UpdatePassword(string oldPassword,string newPassword,string emailId);
        Employee Authenticate(string emailId, string password);
        string CountRemark(string employeeId);

        List<Employee> GetAll();
    }
}
