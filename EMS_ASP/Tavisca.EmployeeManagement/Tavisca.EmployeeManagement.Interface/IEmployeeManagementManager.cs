using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tavisca.EmployeeManagement.Model;

namespace Tavisca.EmployeeManagement.Interface
{
    public interface IEmployeeManagementManager
    {
        Employee Create(Employee employee);

        Remark AddRemark(string employeeId, Remark remark);

       bool UpdatePassword(string oldPassword,string newPassword,string emailId);

       Employee Authenticate(string emaliId, string password);
    }
}
