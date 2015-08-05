using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Tavisca.EmployeeManagement.DataContract
{
    [DataContract]
    public class GetAllEmployee:Result
    {
        [DataMember]
        public List<Employee> AllEmployeeList
        {
            get;
            set;
        }
    }
}
