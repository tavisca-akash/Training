using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tavisca.EmployeeManagement.Model;

namespace Tavisca.EmployeeManagement.Interface
{
    public interface IEmployeeManager
    {
        Employee Get(string employeeId,string pageNo);

        List<Employee> GetAll();

        string CountRemark(string employeeID);
    }
}
